import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mekanik/app/componen/color.dart';
import 'package:mekanik/app/data/data_endpoint/absenhistory.dart';
import 'package:mekanik/app/data/data_endpoint/profile.dart';
import 'package:mekanik/app/data/endpoint.dart';
import 'package:mekanik/app/modules/home/controllers/home_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'listhistory/absensekarang.dart';
import 'listhistory/listhistoryabsen.dart';
import 'listhistory/tombolabsen.dart';
import 'listhistory/tombolabsenpulang.dart';

class AbsenView extends StatefulWidget {
  const AbsenView({super.key});

  @override
  _AbsenViewState createState() => _AbsenViewState();
}

class _AbsenViewState extends State<AbsenView> {
  String _currentTime = '';
  String _currentDate = '';
  bool isButtonDisabled = false;
  bool isButtonDisabledpulang = false;
  String idabsen = '';
  String idkaryawan = '';
  bool isLoading = false;
  final controller = Get.put(HomeController());
  final _refreshController = RefreshController();
  String _currentAddress = 'Mengambil lokasi...';
  TextEditingController locationController = TextEditingController();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  Position? _currentPosition;
  Position? _previousPosition;
  final double _maxAllowedDistance = 50.0;
  final Duration _maxAllowedTime = const Duration(minutes: 5);

  @override
  void initState() {
    super.initState();
    _updateTime();
    _fetchAbsenInfo();
    _fetchidkaryawan();
    _checkPermissions();
    _checkPermissionsfile();
    _requestNotificationPermission();
    _initializeNotifications();
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('Current position: Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}');

      bool isFake = await _checkFakeGPS(_currentPosition!);

      if (isFake) {
        Get.snackbar(
          'Warning',
          'Fake GPS detected',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      await _getAddressFromLatLng();
      locationController.text = '${_currentPosition!.latitude}, ${_currentPosition!.longitude}';
    } catch (e) {
      print('Error getting current location: $e');
      Get.snackbar(
        'Error',
        'Error getting current location',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<bool> _checkFakeGPS(Position position) async {
    if (position.speed <= 0) {
      if (await _isLocationConsistent(position)) {
        return true;
      }
    }
    return false;
  }

  Future<bool> _isLocationConsistent(Position position) async {
    if (_previousPosition == null) {
      _previousPosition = position;
      return false;
    }

    double distance = Geolocator.distanceBetween(
      _previousPosition!.latitude,
      _previousPosition!.longitude,
      position.latitude,
      position.longitude,
    );

    Duration timeDifference = DateTime.now().difference(_previousPosition!.timestamp!);

    bool isDistanceConsistent = distance < _maxAllowedDistance;
    bool isTimeConsistent = timeDifference < _maxAllowedTime;

    _previousPosition = position;

    return !isDistanceConsistent || !isTimeConsistent;
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      Placemark place = placemarks[0];
      _currentAddress = "${place.locality}, ${place.subAdministrativeArea}";
      setState(() {});
    } catch (e) {
      print('Error getting address: $e');
    }
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.location.status;
    print('Permission status: $status');
    if (status.isGranted) {
      print('Permission already granted');
      await _getCurrentLocation();
    } else {
      var requestedStatus = await Permission.location.request();
      print('Requested permission status: $requestedStatus');
      if (requestedStatus.isGranted) {
        print('Permission granted');
        await _getCurrentLocation();
      } else {
        print('Permission denied');
        Get.snackbar(
          'Error',
          'Permission denied',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  Future<void> _requestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _checkPermissionsfile() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      var requestedStatus = await Permission.storage.request();
      if (!requestedStatus.isGranted) {
        print('Storage permission denied');
      }
    }
  }

  void _initializeButtonState() async {
    try {
      final response = await API.AbsenHistoryID(idkaryawan: idkaryawan);
      if (response.historyAbsen != null && response.historyAbsen!.isNotEmpty) {
        final lastAbsen = response.historyAbsen!.last;
        final absenDateStr = lastAbsen.tglAbsen ?? '';

        if (absenDateStr.isNotEmpty) {
          final absenDate = DateFormat('yyyy-MM-dd').parse(absenDateStr);
          final currentDate = DateTime.now();
          final isSameDay = absenDate.year == currentDate.year &&
              absenDate.month == currentDate.month &&
              absenDate.day == currentDate.day;

          setState(() {
            isButtonDisabled = isSameDay;
          });
        } else {
          setState(() {
            isButtonDisabled = false;
          });
        }
      } else {
        setState(() {
          isButtonDisabled = false;
        });
      }
    } catch (e) {
      print('Error initializing button state: $e');
      setState(() {
        isButtonDisabled = false;
      });
    }
  }

  void _initializeButtonpulangState() async {
    try {
      final response = await API.AbsenHistoryID(idkaryawan: idkaryawan);
      if (response.historyAbsen != null && response.historyAbsen!.isNotEmpty) {
        final lastAbsen = response.historyAbsen!.last;
        final absenDateStr = lastAbsen.tglAbsen ?? '';
        final jamPulang = lastAbsen.jamKeluar;

        if (absenDateStr.isNotEmpty) {
          final absenDate = DateFormat('yyyy-MM-dd').parse(absenDateStr);
          final currentDate = DateTime.now();
          final isSameDay = absenDate.year == currentDate.year &&
              absenDate.month == currentDate.month &&
              absenDate.day == currentDate.day;

          setState(() {
            isButtonDisabledpulang = isSameDay && jamPulang != null;
          });
        } else {
          setState(() {
            isButtonDisabledpulang = false;
          });
        }
      } else {
        setState(() {
          isButtonDisabledpulang = false;
        });
      }
    } catch (e) {
      print('Error initializing button pulang state: $e');
      setState(() {
        isButtonDisabledpulang = false;
      });
    }
  }

  void _fetchAbsenInfo() async {
    try {
      final absen = await API.AbsenHistoryID(idkaryawan: idkaryawan);
      setState(() {
        if (absen.historyAbsen != null && absen.historyAbsen!.isNotEmpty) {
          idabsen = absen.historyAbsen![0].id.toString();
        } else {
          idabsen = '';
        }
        print('$idabsen');
      });
    } catch (e) {
      print('Error fetching absen info: $e');
    }
  }

  void _fetchidkaryawan() async {
    try {
      final idkaryawan2 = await API.profileiD();
      setState(() {
        idkaryawan = idkaryawan2.data?.id.toString() ?? '';
        print('$idkaryawan');
      });
      _initializeButtonState();
      _initializeButtonpulangState();
    } catch (e) {
      print('Error fetching absen info: $e');
    }
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = DateFormat('HH:mm:ss').format(now);
      _currentDate = DateFormat('EEEE, d MMMM y').format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: MyColors.appPrimaryColor,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bgabsen.png"),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            header: const WaterDropHeader(),
            onLoading: _onLoading,
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Row(
                        children: [
                          Stack(
                            alignment: const Alignment(0.9, 0.9),
                            children: <Widget>[
                              const CircleAvatar(
                                backgroundImage: AssetImage("assets/avatar.png"),
                                radius: 20.0,
                              ),
                              Container(
                                height: 10,
                                width: 10,
                                alignment: Alignment.bottomRight,
                                child: Image.asset("assets/success_logo.png"),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10,),
                          FutureBuilder<Profile>(
                            future: API.profileiD(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                if (snapshot.data != null) {
                                  final nama = snapshot.data!.data?.namaKaryawan ?? "";
                                  final hp = snapshot.data!.data?.hp ?? "";
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        nama,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        hp,
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return const Text('Tidak ada data');
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    _currentAddress,
                    style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Penting !!', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                        Text('Bila anda mencoba menggunakan fake GPS maka absen tidak berfungsi.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 9),),
                        Text('Bila anda mencoba menggubah tanggal dan jam pada settingan Smartphone anda absen tidak berfungsi.',  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 9),),
                      ],
                    ),
                  ),
                  const SizedBox(height : 30,),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 30,),
                        const Text('Kehadiran Langsung', style: TextStyle(fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        FutureBuilder(
                          future: API.AbsenHistoryID(idkaryawan: idkaryawan),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState != ConnectionState.waiting &&
                                snapshot.data != null) {
                              AbsenHistory getDataAcc = snapshot.data!;
                              final currentTime = DateTime.now();
                              HistoryAbsen? matchingAbsen;

                              if (getDataAcc.historyAbsen != null && getDataAcc.historyAbsen!.isNotEmpty) {
                                for (var e in getDataAcc.historyAbsen!) {
                                  if (e.jamMasuk != null && e.tglAbsen != null) {
                                    final dateStr = e.tglAbsen!;
                                    final timeStr = e.jamMasuk!;
                                    final dateTimeStr = '$dateStr $timeStr';
                                    try {
                                      final jamMasuk = DateFormat('yyyy-MM-dd HH:mm').parse(dateTimeStr);
                                      final isSameDay = jamMasuk.year == currentTime.year &&
                                          jamMasuk.month == currentTime.month &&
                                          jamMasuk.day == currentTime.day;

                                      if (isSameDay && (jamMasuk.hour == currentTime.hour || jamMasuk.isBefore(currentTime))) {
                                        matchingAbsen = e;
                                        break;
                                      }
                                    } catch (e) {
                                    }
                                  }
                                }
                              }
                              if (matchingAbsen != null) {
                                final timeStr = matchingAbsen.jamMasuk!;
                                final jamMasuk = DateFormat('HH:mm').parse(timeStr);
                                return Column(
                                  children: AnimationConfiguration.toStaggeredList(
                                    duration: const Duration(milliseconds: 475),
                                    childAnimationBuilder: (widget) => SlideAnimation(
                                      child: FadeInAnimation(
                                        child: widget,
                                      ),
                                    ),
                                    children: [
                                      HistoryAbsensiSekarang(
                                        items: matchingAbsen,
                                        jamMasuk: DateFormat('HH:mm').format(jamMasuk),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Text(
                                  "Anda belum absen hari ini",
                                  style: TextStyle(fontSize: 20, color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold),
                                );
                              }
                            } else {
                              return SizedBox(
                                height: Get.height - 250,
                                child: const SingleChildScrollView(
                                  child: Column(
                                    children: [],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Text(
                          '$_currentDate',
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Divider(),
                        ),
                        const SizedBox(height: 10,),
                        const Text('Jam kerja', style: TextStyle(fontWeight: FontWeight.bold,),),
                        const SizedBox(height: 10,),
                        const Text('07:00 AM - 15:30 PM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        const SizedBox(height: 20,),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder(
                                future: API.AbsenHistoryID(idkaryawan: idkaryawan),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.connectionState != ConnectionState.waiting &&
                                      snapshot.data != null) {
                                    AbsenHistory getDataAcc = snapshot.data!;
                                    final currentTime = DateTime.now();
                                    HistoryAbsen? matchingAbsen;

                                    if (getDataAcc.historyAbsen != null && getDataAcc.historyAbsen!.isNotEmpty) {
                                      for (var e in getDataAcc.historyAbsen!) {
                                        if (e.jamMasuk != null && e.tglAbsen != null) {
                                          final dateStr = e.tglAbsen!;
                                          final timeStr = e.jamMasuk!;
                                          final dateTimeStr = '$dateStr $timeStr';
                                          try {
                                            final jamMasuk = DateFormat('yyyy-MM-dd HH:mm').parse(dateTimeStr);
                                            final isSameDay = jamMasuk.year == currentTime.year &&
                                                jamMasuk.month == currentTime.month &&
                                                jamMasuk.day == currentTime.day;

                                            if (isSameDay && (jamMasuk.hour == currentTime.hour || jamMasuk.isBefore(currentTime))) {
                                              matchingAbsen = e;
                                              break;
                                            }
                                          } catch (e) {
                                          }
                                        }
                                      }
                                    }

                                    if (matchingAbsen != null) {
                                      final timeStr = matchingAbsen.jamMasuk!;
                                      final jamMasuk = DateFormat('HH:mm').parse(timeStr);
                                      return Column(
                                        children: AnimationConfiguration.toStaggeredList(
                                          duration: const Duration(milliseconds: 475),
                                          childAnimationBuilder: (widget) => SlideAnimation(
                                            child: FadeInAnimation(
                                              child: widget,
                                            ),
                                          ),
                                          children: [
                                            HistoryAbsensiTombol(
                                              items: matchingAbsen,
                                              jamMasuk: DateFormat('HH:mm').format(jamMasuk),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: isButtonDisabled || isLoading ? null : () async {
                                                setState(() {
                                                  isLoading = true; // Tampilkan loading
                                                });
                                                try {
                                                  _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                                                  print('response latitude : ${_currentPosition?.latitude.toString() ?? ''}');
                                                  print('response longitude : ${_currentPosition?.longitude.toString() ?? ''}');

                                                  // Lakukan postmeridian fake GPS
                                                  if (await _checkFakeGPS(_currentPosition!)) {
                                                    Get.snackbar(
                                                      'Warning',
                                                      'Fake GPS detected! Cannot proceed with Absen Masuk.',
                                                      snackPosition: SnackPosition.TOP,
                                                      backgroundColor: Colors.red,
                                                      colorText: Colors.white,
                                                    );
                                                    setState(() {
                                                      isButtonDisabled = true;
                                                    });
                                                    return;
                                                  }
                                                  var response = await API.AbsenMasukID(
                                                    idkaryawan: idkaryawan,
                                                    latitude: _currentPosition?.latitude.toStringAsFixed(8) ?? '',
                                                    longitude: _currentPosition?.longitude.toStringAsFixed(8) ?? '',
                                                  );
                                                  if (response.status == 'success') {
                                                    setState(() {
                                                      isButtonDisabled = true;
                                                    });
                                                    QuickAlert.show(
                                                      context: context,
                                                      type: QuickAlertType.success,
                                                      text: 'Berhasil Absen',
                                                      onConfirmBtnTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                    _initializeButtonState();
                                                  } else {
                                                    QuickAlert.show(
                                                      context: context,
                                                      type: QuickAlertType.error,
                                                      text: response.message,
                                                    );
                                                  }
                                                } catch (e) {
                                                  print('Error getting current location or processing request: $e');
                                                  Get.snackbar(
                                                    'Absen ada tidak berhasil',
                                                    'Jangankauwan Absen anda jauh dari Lokasi',
                                                    snackPosition: SnackPosition.TOP,
                                                    colorText: Colors.white,
                                                    backgroundColor: Colors.red,
                                                  );
                                                } finally {
                                                  setState(() {
                                                    isLoading = false; // Sembunyikan loading
                                                  });
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: isButtonDisabled ? Colors.grey : MyColors.appPrimaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: const Text(
                                                'Absen Masuk',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            if (isLoading)
                                              Positioned(
                                                child: CircularProgressIndicator(
                                                  color: MyColors.appPrimaryColor,
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    }
                                  } else {
                                    return SizedBox(
                                      height: Get.height - 250,
                                      child: const SingleChildScrollView(
                                        child: Column(
                                          children: [],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              FutureBuilder(
                                future: API.AbsenHistoryID(idkaryawan: idkaryawan),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.connectionState != ConnectionState.waiting &&
                                      snapshot.data != null) {
                                    AbsenHistory getDataAcc = snapshot.data!;
                                    final currentTime = DateTime.now();
                                    HistoryAbsen? matchingAbsen;

                                    if (getDataAcc.historyAbsen != null && getDataAcc.historyAbsen!.isNotEmpty) {
                                      for (var e in getDataAcc.historyAbsen!) {
                                        if (e.jamKeluar != null && e.tglAbsen != null) {
                                          final dateStr = e.tglAbsen!;
                                          final timeStr = e.jamKeluar!;
                                          final dateTimeStr = '$dateStr $timeStr';
                                          try {
                                            final jamMasuk = DateFormat('yyyy-MM-dd HH:mm').parse(dateTimeStr);

                                            final isSameDay = jamMasuk.year == currentTime.year &&
                                                jamMasuk.month == currentTime.month &&
                                                jamMasuk.day == currentTime.day;

                                            if (isSameDay && (jamMasuk.hour == currentTime.hour || jamMasuk.isBefore(currentTime))) {
                                              matchingAbsen = e;
                                              break;
                                            }
                                          } catch (e) {
                                          }
                                        }
                                      }
                                    }

                                    if (matchingAbsen != null) {
                                      final timeStr = matchingAbsen.jamKeluar!;
                                      final jamMasuk = DateFormat('HH:mm').parse(timeStr);
                                      return Column(
                                        children: AnimationConfiguration.toStaggeredList(
                                          duration: const Duration(milliseconds: 475),
                                          childAnimationBuilder: (widget) => SlideAnimation(
                                            child: FadeInAnimation(
                                              child: widget,
                                            ),
                                          ),
                                          children: [
                                            HistoryAbsensiTombolPulang(
                                              items: matchingAbsen,
                                              jamMasuk: DateFormat('HH:mm').format(jamMasuk),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: FutureBuilder(
                                          future: API.AbsenHistoryID(idkaryawan: idkaryawan),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return ElevatedButton(
                                                onPressed: () async {},
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.grey.shade200,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Absen Pulang',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: MyColors.appPrimaryColor,
                                                  ),
                                                ),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text('Error: ${snapshot.error}');
                                            } else if (!snapshot.hasData || snapshot.data == null) {
                                              return SizedBox(
                                                height: Get.height - 250,
                                                child: const SingleChildScrollView(
                                                  child: Column(
                                                    children: [],
                                                  ),
                                                ),
                                              );
                                            } else {
                                              AbsenHistory getDataAcc = snapshot.data!;
                                              if (getDataAcc.historyAbsen == null || getDataAcc.historyAbsen!.isEmpty) {
                                                return ElevatedButton(
                                                  onPressed: () async {},
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: MyColors.appPrimaryColor,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Absen Pulang',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                );
                                              }
                                              var itemId = getDataAcc.historyAbsen!.first.id; // Example: getting the first item's id
                                              return ElevatedButton(
                                                onPressed: isButtonDisabledpulang || itemId == null ? null : () async {
                                                  QuickAlert.show(
                                                    context: context,
                                                    type: QuickAlertType.warning,
                                                    barrierDismissible: true,
                                                    title: 'Absen pulang untuk hari ini',
                                                    confirmBtnText: 'Absen Pulang',
                                                    confirmBtnColor: MyColors.appPrimaryColor,
                                                    widget: TextFormField(
                                                      controller: controller.catatan,
                                                      decoration: const InputDecoration(
                                                        alignLabelWithHint: true,
                                                        hintText: 'catatan',
                                                        prefixIcon: Icon(
                                                          Icons.mail_lock_rounded,
                                                        ),
                                                      ),
                                                      textInputAction: TextInputAction.next,
                                                    ),
                                                    onConfirmBtnTap: () async {
                                                      Navigator.pop(Get.context!);
                                                      if (itemId == null) {
                                                        // Handle the case where itemId is null
                                                        QuickAlert.show(
                                                          context: Get.context!,
                                                          type: QuickAlertType.error,
                                                          text: 'ID not available',
                                                        );
                                                        return;
                                                      }

                                                      var response = await API.AbsenPulangID(
                                                        id: itemId.toString(),
                                                        keterangan: controller.catatan.text,
                                                      );

                                                      if (response.status == 'success') {
                                                        setState(() {
                                                          isButtonDisabledpulang = true;
                                                        });
                                                        QuickAlert.show(
                                                          context: Get.context!,
                                                          type: QuickAlertType.success,
                                                          text: 'Berhasil Absen Pulang',
                                                        );
                                                      } else {
                                                        QuickAlert.show(
                                                          context: Get.context!,
                                                          type: QuickAlertType.error,
                                                          text: response.message,
                                                        );
                                                      }
                                                      _initializeButtonpulangState();
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: MyColors.appPrimaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Absen Pulang',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      );
                                    }
                                  } else {
                                    return SizedBox(
                                      height: Get.height - 250,
                                      child: const SingleChildScrollView(
                                        child: Column(
                                          children: [],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Divider(),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/user-clock.svg', width: 26),
                              const SizedBox(width: 10,),
                              const Text('Riwayat Kehadiran', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        FutureBuilder(
                          future: API.AbsenHistoryID(idkaryawan: idkaryawan),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState != ConnectionState.waiting &&
                                snapshot.data != null) {
                              AbsenHistory getDataAcc = snapshot.data!;
                              return Column(
                                children: AnimationConfiguration.toStaggeredList(
                                  duration: const Duration(milliseconds: 475),
                                  childAnimationBuilder: (widget) => SlideAnimation(
                                    child: FadeInAnimation(
                                      child: widget,
                                    ),
                                  ),
                                  children: getDataAcc.historyAbsen != null
                                      ? getDataAcc.historyAbsen!
                                      .map((e) {
                                    return HistoryAbsensi(items: e);
                                  }).toList()
                                      : [Container()],
                                ),
                              );
                            } else {
                              return SizedBox(
                                  height: Get.height - 250,
                                  child: const SingleChildScrollView(
                                    child: Column(
                                      children: [],
                                    ),
                                  ));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLoading() {
    _refreshController.loadComplete();
  }

  void _onRefresh() async {
    HapticFeedback.lightImpact();
    setState(() {
      const AbsenView(); // if you only want to refresh the list you can place this, so the two can be inside setState
      _initializeButtonState(); // Refresh button state after pull to refresh
      _refreshController.refreshCompleted();
    });
  }
}

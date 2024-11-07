import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mekanik/app/componen/color.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/endpoint.dart';
import '../../approve/componen/emergency_card.dart';
import 'package:http/http.dart' as http;

class EmergencyView extends StatefulWidget {
  const EmergencyView({Key? key}) : super(key: key);

  @override
  State<EmergencyView> createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView> {
  late GoogleMapController _controller;
  Position? _currentPosition;
  List<Marker> _markers = [];
  List<Polyline> _polylines = [];
  final PanelController _panelController = PanelController();
  String _currentAddress = 'Mengambil lokasi...';
  String _estimatedTime = 'Menghitung estimasi waktu...';
  BitmapDescriptor? _customIcon;
  List<LatLng> polylineCoordinates = [];
  bool isMenujuLokasi = true;
  bool isLoading = false;
  bool isTibaDiLokasi = false;
  bool isMenujuLokasiLoading = false;
  bool isTibaDiLokasiLoading = false;
  final PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyBnpeMnuqtwrUplZNVpWiUtZAmyYa0w6VM";
  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _loadCustomIcon();
    _loadButtonState();
  }

  Future<void> _loadCustomIcon() async {
    _customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(30, 30)),
      'assets/drop.png',
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('Current position: $_currentPosition');
      _getAddressFromLatLng();
      setState(() {});
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.subAdministrativeArea}";
      });
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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Permission denied'),
        ));
      }
    }
  }
  Future<void> _getPolyline(double startLatitude, double startLongitude, double endLatitude, double endLongitude) async {
    print('Getting polyline...');

    final PolylineRequest request = PolylineRequest(
      origin: PointLatLng(startLatitude, startLongitude),
      destination: PointLatLng(endLatitude, endLongitude),
      mode: TravelMode.driving,
    );

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: googleAPiKey,
        request: request
    );

    if (result.status == 'OK') {
      polylineCoordinates.clear();
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines = [
          Polyline(
            polylineId: const PolylineId('polyline_id'),
            color: MyColors.appPrimaryColor,
            points: polylineCoordinates,
            width: 5,
          ),
        ];
      });

      _moveCameraToPolyline();
    } else {
      print('Error: ${result.errorMessage}');
    }
  }




  void _moveCameraToPolyline() {
    if (polylineCoordinates.isNotEmpty) {
      LatLngBounds bounds;
      if (polylineCoordinates.length == 1) {
        bounds = LatLngBounds(
          southwest: polylineCoordinates.first,
          northeast: polylineCoordinates.first,
        );
      } else {
        bounds = LatLngBounds(
          southwest: LatLng(
            polylineCoordinates.map((p) => p.latitude).reduce((a, b) => a < b ? a : b),
            polylineCoordinates.map((p) => p.longitude).reduce((a, b) => a < b ? a : b),
          ),
          northeast: LatLng(
            polylineCoordinates.map((p) => p.latitude).reduce((a, b) => a > b ? a : b),
            polylineCoordinates.map((p) => p.longitude).reduce((a, b) => a > b ? a : b),
          ),
        );
      }
      _controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    }
  }

  Future<void> _updateEstimatedTime(double destinationLat, double destinationLng) async {
    if (_currentPosition != null) {
      final originLat = _currentPosition!.latitude;
      final originLng = _currentPosition!.longitude;

      double distanceInKilometers = _calculateDistanceInKilometers(
        originLat,
        originLng,
        destinationLat,
        destinationLng,
      );

      final url = 'https://maps.googleapis.com/maps/api/directions/json?origin=$originLat,$originLng&destination=$destinationLat,$destinationLng&key=$googleAPiKey';

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final routes = data['routes'] as List;
          if (routes.isNotEmpty) {
            final duration = routes[0]['legs'][0]['duration']['text'];
            setState(() {
              _estimatedTime = '$duration (${distanceInKilometers.toStringAsFixed(2)} km)';
            });
          } else {
            setState(() {
              _estimatedTime = 'Gagal mendapatkan estimasi waktu';
            });
          }
        } else {
          setState(() {
            _estimatedTime = 'Gagal mendapatkan estimasi waktu';
          });
        }
      } catch (e) {
        setState(() {
          _estimatedTime = 'Terjadi kesalahan: $e';
        });
      }
    } else {
      setState(() {
        _estimatedTime = 'Gagal menghitung estimasi waktu';
      });
    }
  }

  String _calculateTravelTime(double distanceInMeters) {
    const averageSpeed = 50000.0;
    double timeInHours = distanceInMeters / averageSpeed;
    int hours = timeInHours.floor();
    int minutes = ((timeInHours - hours) * 60).round();
    return '${minutes} mnt';
  }

  double _calculateDistanceInKilometers(double startLat, double startLng, double endLat, double endLng) {
    const double earthRadius = 6371000;

    double dLat = _degreesToRadians(endLat - startLat);
    double dLng = _degreesToRadians(endLng - startLng);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(startLat)) * cos(_degreesToRadians(endLat)) *
            sin(dLng / 2) * sin(dLng / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distanceInMeters = earthRadius * c;
    return distanceInMeters / 1000;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  void _moveCamera(double latitude, double longitude) {
    _controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(latitude, longitude),
      ),
    );
  }



  void _saveButtonState() {
    final Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;
    final String kodeBooking = arguments?['kode_booking'] ?? '';
    GetStorage().write(kodeBooking, {
      'isTibaDiLokasi': isTibaDiLokasi,
      'isMenujuLokasi': isMenujuLokasi,
    });
  }

  void _loadButtonState() {
    final Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;
    final String kodeBooking = arguments?['kode_booking'] ?? '';
    final savedState = GetStorage().read<Map<String, dynamic>>(kodeBooking);

    if (savedState != null) {
      setState(() {
        isTibaDiLokasi = savedState['isTibaDiLokasi'] ?? false;
        isMenujuLokasi = savedState['isMenujuLokasi'] ?? true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;
    final String location = arguments?['location'] ?? '';
    final String locationname = arguments?['location_name'] ?? '';
    final String hp = arguments?['hp'] ?? '';

    List<String> coordinates = location.isEmpty ? [] : location.split(',');
    double latitude = coordinates.isNotEmpty ? double.parse(coordinates[0]) : 0.0;
    double longitude = coordinates.length > 1 ? double.parse(coordinates[1]) : 0.0;

    _updateEstimatedTime(latitude, longitude);
    final Map args = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        title: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lokasi Saat ini', style: GoogleFonts.nunito(fontSize: 12)),
                Text(_currentAddress, style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
      body: _currentPosition == null
          ? const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.blue,
            ),
            SizedBox(height: 10,),
            Text('Sedang memuat lokasi...')
          ],
        ),
      )
          : Stack(
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            zoomGesturesEnabled: true,
            mapToolbarEnabled: true,
            compassEnabled: true,
            zoomControlsEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            polylines: Set<Polyline>.of(_polylines),
            onMapCreated: (controller) {
              _controller = controller;

              setState(() {
                _markers.add(
                  Marker(
                    markerId: const MarkerId('apiLocation'),
                    position: LatLng(latitude, longitude),
                    icon: _customIcon ?? BitmapDescriptor.defaultMarker,
                  ),
                );
              });
              _getPolyline(
                _currentPosition!.latitude,
                _currentPosition!.longitude,
                latitude,
                longitude,
              );
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(latitude, longitude),
              zoom: 14,
            ),
            markers: Set<Marker>.of(_markers),
            padding: const EdgeInsets.only(bottom: 240),
          ),
          SlidingUpPanel(
            controller: _panelController,
            panel: _buildSlidingPanel(),
            minHeight: 230,
            maxHeight: MediaQuery.of(context).size.height * 0.9,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            parallaxEnabled: true,
            parallaxOffset: 0.5,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomAppBar(
              height: 65,
              elevation: 0,
              color: Colors.white,
              shape: const CircularNotchedRectangle(),
              child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: isMenujuLokasi && !isMenujuLokasiLoading
                            ? () async {
                          setState(() {
                            isMenujuLokasiLoading = true;
                          });
                          final Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;
                          String idKaryawan = GetStorage().read('idKaryawan') ?? '';
                          var response = await API.MenujudiLokasiID(
                            idkaryawan: idKaryawan,
                            kodebooking: arguments?['kode_booking'] ?? '',
                            kodepelanggan: arguments?['tipe_svc'] ?? '',
                            kodekendaraan: arguments?['kode_kendaraan'] ?? '',
                          );

                          if (response.success == true) {
                            setState(() {
                              isMenujuLokasi = false;
                              isTibaDiLokasi = true;
                            });
                            _saveButtonState();

                            double startLatitude = latitude;
                          double startLongitude =  longitude;
                          double endLatitude = _currentPosition!.latitude;
                          double endLongitude = _currentPosition!.longitude;
                          await _getPolyline(startLatitude, startLongitude, endLatitude, endLongitude);
                          }

                          setState(() {
                          isMenujuLokasiLoading = false;
                          });
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isMenujuLokasi ? Colors.blue : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: isMenujuLokasiLoading
                            ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: Colors.white),
                            SizedBox(width: 10),
                            Text('Loading...', style: TextStyle(color: Colors.white)),
                          ],
                        )
                            : const Text('Menuju lokasi', style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 10,),
                      ElevatedButton(
                        onPressed: isTibaDiLokasi && !isTibaDiLokasiLoading
                            ? () async {
                          setState(() {
                            isTibaDiLokasiLoading = true;
                          });
                          final Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;
                          String idKaryawan = GetStorage().read('idKaryawan') ?? '';
                          var response = await API.TibadiLokasiID(
                            idkaryawan: idKaryawan,
                            kodebooking: arguments?['kode_booking'] ?? '',
                            kodepelanggan: arguments?['tipe_svc'] ?? '',
                            kodekendaraan: arguments?['kode_kendaraan'] ?? '',
                          );
                          if (response.success == true) {
                            setState(() {
                              isTibaDiLokasi = false;
                            });
                            _saveButtonState();
                          }
                          setState(() {
                            isTibaDiLokasiLoading = false;
                          });
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isTibaDiLokasi ? Colors.green : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: isTibaDiLokasiLoading
                            ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: Colors.white),
                            SizedBox(width: 10),
                            Text('Loading...', style: TextStyle(color: Colors.white)),
                          ],
                        )
                            : const Text('Tiba Di Lokasi', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  )
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSlidingPanel() {
    final Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;
    final String hp = arguments?['hp'] ?? '';
    final String location = arguments?['location'] ?? '';
    final String locationname = arguments?['location_name'] ?? '';

    List<String> coordinates = location.isEmpty ? [] : location.split(',');
    double latitude = coordinates.isNotEmpty ? double.parse(coordinates[0]) : 0.0;
    double longitude = coordinates.length > 1 ? double.parse(coordinates[1]) : 0.0;

    String directionsUrl = '';
    if (location.isNotEmpty) {
      directionsUrl = "https://www.google.com/maps/dir/?api=1&destination=$location&travelmode=driving";
    } else if (locationname.isNotEmpty) {
      directionsUrl = "https://www.google.com/maps/dir/?api=1&destination=$locationname&travelmode=driving";
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double containerMargin = constraints.maxWidth * 0.15;
        double buttonMargin = constraints.maxWidth * 0.2;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 180),
              height: 5,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            GestureDetector(
              onTap: () {
                _moveCamera(latitude, longitude);
                _panelController.close();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _estimatedTime,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        if (directionsUrl.isNotEmpty) {
                          if (await canLaunch(directionsUrl)) {
                            await launch(directionsUrl);
                          } else {
                            throw 'Could not launch $directionsUrl';
                          }
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: buttonMargin),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(' Directions', style: GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.directions),
                              onPressed: () async {
                                if (directionsUrl.isNotEmpty) {
                                  if (await canLaunch(directionsUrl)) {
                                    await launch(directionsUrl);
                                  } else {
                                    throw 'Could not launch $directionsUrl';
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const CardEmergencyPKB(),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

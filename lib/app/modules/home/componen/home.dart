import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mekanik/app/modules/home/componen/stats_grid.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../componen/color.dart';
import '../../../data/data_endpoint/absenhistory.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';
import '../absen/listhistory/indikator.dart';
import '../controllers/home_controller.dart';
import 'bar_chart.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final controller = Get.put(HomeController());
  late RefreshController _refreshController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String idkaryawan = '';
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _fetchidkaryawan();
    _refreshController = RefreshController();
    _initializeNotifications();
    _scheduleDailyNotifications();
  }

  void _initializeNotifications() {
    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _scheduleDailyNotifications() {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'daily_channel_id',
      'Daily Notifications',
      channelDescription: 'Waktunya untuk mengikatkan absen pada jam 15 : 30!',
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker',
      sound: RawResourceAndroidNotificationSound('sounds'),
    );
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    const startTime = 15;
    const endTime = 16;
    Timer.periodic(Duration(minutes: 10), (timer) {
      final now = DateTime.now();
      final currentHour = now.hour;
      if (currentHour >= startTime && currentHour < endTime) {
        flutterLocalNotificationsPlugin.show(
          0,
          'Reminder',
          'Waktunya untuk mengikatkan absen pada jam 15 : 30!',
          platformChannelSpecifics,
          payload: 'item x',
        );
      } else if (currentHour >= endTime) {
        timer.cancel();
      }
    });
  }
  void _fetchidkaryawan() async {
    try {
      final idkaryawan2 = await API.profileiD();
      setState(() {
        idkaryawan = idkaryawan2?.data?.id.toString() ?? '';
        print('$idkaryawan');
      });
    } catch (e) {
      print('Error fetching absen info: $e');
    }
  }

  void _checkAbsenAndNavigate() async {
    try {
      final getDataAcc = await API.AbsenHistoryID(idkaryawan: idkaryawan);
      final currentTime = DateTime.now();

      if (getDataAcc != null && getDataAcc.historyAbsen != null && getDataAcc.historyAbsen!.isNotEmpty) {
        final yesterday = currentTime.subtract(const Duration(days: 1));
        final yesterdayStr = DateFormat('yyyy-MM-dd').format(yesterday);
        print('Checking absensi for yesterday: $yesterdayStr');

        bool hasMissingCheckout = false;

        for (var e in getDataAcc.historyAbsen!) {
          print('Entry: ${e.tglAbsen}, Jam Keluar: ${e.jamKeluar}');
          if (e.tglAbsen == yesterdayStr && e.jamKeluar == null) {
            hasMissingCheckout = true;
            break;
          }
        }

        if (hasMissingCheckout) {
          print('Displaying dialog');
          // Show dialog if jamKeluar is null
          Get.defaultDialog(
            title: 'Perhatian!',
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 60,
                ),
                SizedBox(height: 16),
                Text(
                  'Sepertinya Anda belum melakukan absen pulang kemarin. '
                      'Mohon segera hubungi admin untuk menyelesaikan masalah ini.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Tutup'),
            ),
            barrierDismissible: false,
            titlePadding: const EdgeInsets.all(16),
            contentPadding: const EdgeInsets.all(16),
            radius: 10,
          );
        } else {
          // If no issues, navigate to the AbsenView
          Get.toNamed(Routes.AbsenView);
        }
      } else {
        // Handle case where there's no data or historyAbsen is empty
        print('No absen history data available.');
      }
    } catch (e) {
      print('Error checking absen history: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    controller.checkForUpdate();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: MyColors.appPrimaryDarkmod,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: MyColors.appPrimaryDarkmod,
        ),
        centerTitle: false,
        actions: [
          InkWell(
            onTap: _checkAbsenAndNavigate,
            child: FutureBuilder(
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

                          // Compare date and hours
                          final isSameDay = jamMasuk.year == currentTime.year &&
                              jamMasuk.month == currentTime.month &&
                              jamMasuk.day == currentTime.day;

                          if (isSameDay && (jamMasuk.hour == currentTime.hour || jamMasuk.isBefore(currentTime))) {
                            matchingAbsen = e;
                            break;
                          }
                        } catch (e) {
                          // Handle parsing error if necessary
                        }
                      }
                    }
                  }

                  if (matchingAbsen != null) {
                    final timeStr = matchingAbsen.jamMasuk!;
                    final jamMasuk = DateFormat('HH:mm').parse(timeStr); // Parse without date

                    return Column(
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 475),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: [
                          const SizedBox(height: 10,),
                          HistoryAbsensiIndikator(
                            items: matchingAbsen,
                            jamMasuk: DateFormat('HH:mm').format(jamMasuk),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Row(
                        children: [
                          Text('Anda Belum Absen', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
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
          ),
          const SizedBox(width: 10),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/logo_tech.png',
              height: 45,
            ),
          ],
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: const WaterDropHeader(),
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              sliver: SliverToBoxAdapter(
                child: StatsGrid(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 20.0),
              sliver: SliverToBoxAdapter(
                child: BarChartSample2(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onLoading() {
    _refreshController.loadComplete();
  }

  _onRefresh() {
    HapticFeedback.lightImpact();
    setState(() {
      const StatsScreen();
      _refreshController.refreshCompleted();
    });
  }
}

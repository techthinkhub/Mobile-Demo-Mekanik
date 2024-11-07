import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info/package_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../componen/color.dart';

class BokingController extends GetxController {
  //TODO: Implement BokingController
  //TODO: Implement ApproveController
  late String id;
  late String tglBooking;
  late String jamBooking;
  late String nama;
  late String namaJenissvc;
  late String noPolisi;
  late String namaMerk;
  late String namaTipe;
  late String status;

  void setData({
    required String id,
    required String tglBooking,
    required String jamBooking,
    required String nama,
    required String namaJenissvc,
    required String noPolisi,
    required String namaMerk,
    required String namaTipe,
    required String status,
  }) {
    this.id = id;
    this.tglBooking = tglBooking;
    this.jamBooking = jamBooking;
    this.nama = nama;
    this.namaJenissvc = namaJenissvc;
    this.noPolisi = noPolisi;
    this.namaMerk = namaMerk;
    this.namaTipe = namaTipe;
    this.status = status;
  }
  final count = 0.obs;
  late TextEditingController idController;
  late TextEditingController tglBookingController;
  late TextEditingController jamBookingController;
  late TextEditingController namaController;
  late TextEditingController namaJenissvcController;
  late TextEditingController noPolisiController;
  late TextEditingController namaMerkController;
  late TextEditingController namaTipeController;
  late TextEditingController statusController;
  late TextEditingController tanggalController;
  late TextEditingController jamController;

  @override
  void onInit() {
    super.onInit();
    idController = TextEditingController();
    tglBookingController = TextEditingController();
    jamBookingController = TextEditingController();
    namaController = TextEditingController();
    namaJenissvcController = TextEditingController();
    noPolisiController = TextEditingController();
    namaMerkController = TextEditingController();
    namaTipeController = TextEditingController();
    statusController = TextEditingController();
    tanggalController = TextEditingController();
    jamController = TextEditingController();
  }

  @override
  void onClose() {
    idController.dispose();
    tglBookingController.dispose();
    jamBookingController.dispose();
    namaController.dispose();
    namaJenissvcController.dispose();
    noPolisiController.dispose();
    namaMerkController.dispose();
    namaTipeController.dispose();
    statusController.dispose();
    super.onClose();
  }
  var isBookingApproved = false.obs;

  void setBookingApproved(bool value) {
    isBookingApproved.value = value;
  }
  List<RefreshController> refreshControllers = [];

  void refresh() {
    for (var controller in refreshControllers) {
      controller.refreshCompleted();
    }
  }

  final InAppUpdate inAppUpdate = InAppUpdate();

  get updateAvailable => null;

  Future<void> checkForUpdate() async {
    final packageInfo = (GetPlatform.isAndroid)
        ? await PackageInfo.fromPlatform()
        : PackageInfo(
      appName: '',
      packageName: '',
      version: '',
      buildNumber: '',
    );
    final currentVersion = packageInfo.version;

    try {
      final updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.flexibleUpdateAllowed) {
        final latestVersion = updateInfo.availableVersionCode.toString();
        if (currentVersion != latestVersion) {
          showUpdateDialog();
        }
      }
    } catch (e) {
      print('Error checking for updates: $e');
    }
  }

  void showUpdateDialog() {
    Get.defaultDialog(
      title: 'Pembaruan Tersedia',
      content: Column(
        children: [
          Image.asset(
            "assets/logo_update.png",
            gaplessPlayback: true,
            fit: BoxFit.fitHeight,
            height: 200,
          ),
          const Text(
              'Versi baru aplikasi tersedia. Apakah Anda ingin mengunduh pembaruan sekarang?',
              textAlign: TextAlign.center),
        ],
      ),

      confirm: InkWell(
        onTap: () async {
          await InAppUpdate.performImmediateUpdate();
          Get.back();
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.appPrimaryColor),
          child: const Center(
            child: Text('Unduh Sekarang',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),

    );
  }
  var selectedBooking = {}.obs;
  void setSelectedBooking(Map<String, dynamic> booking) {
    selectedBooking.value = booking;
  }

  void incrementCounter() {
    count.value++;
  }

  void resetCounter() {
    count.value = 0;
  }
  void increment() => count.value++;
}

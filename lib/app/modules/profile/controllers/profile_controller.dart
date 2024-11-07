import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info/package_info.dart';

import '../../../componen/color.dart';
import '../../../data/localstorage.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
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
  final _packageName = ''.obs;
  String get packageName => _packageName.value;

  late final DeviceInfoPlugin deviceInfo;


  final count = 0.obs;
  @override
  void onInit()async{
    super.onInit();

    deviceInfo = DeviceInfoPlugin();
    final androidInfo = (GetPlatform.isAndroid)
        ? await deviceInfo.androidInfo
        : AndroidDeviceInfo;
    final packageInfo = (GetPlatform.isAndroid)
    ? await PackageInfo.fromPlatform()
        : PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    );
    _packageName.value = packageInfo.version;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  void logout() async {await LocalStorages.deleteToken; Get.offAllNamed(Routes.SIGNIN);}
}

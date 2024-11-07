import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:launch_review/launch_review.dart';
import 'package:mekanik/app/componen/color.dart';
import 'package:package_info/package_info.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/localstorage.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  final PageController pageController = PageController();
  final TextEditingController catatan = TextEditingController();
  void changeTabIndex(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);

  }
  void refreshData() {
    // Perform data fetching or state updating operations here
    // For example:
    // fetchData();
    // updateState();
    print('Refreshing data in HomeView');
  }
  var isBookingApproved = false.obs;

  void setBookingApproved(bool value) {
    isBookingApproved.value = value;
  }

  final count = 0.obs;

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
          LaunchReview.launch(
            androidAppId: "com.tech.mekanik.demo",
            // iOSAppId: "585027354",
          );
          // await InAppUpdate.performImmediateUpdate();
          Get.back();
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.appPrimaryColor,
          ),
          child: const Center(
            child: Text(
              'Unduh Sekarang',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void logout() async {
    await LocalStorages.deleteToken;
    Get.offAllNamed(Routes.SIGNIN);
  }

  void increment() => count.value++;
}

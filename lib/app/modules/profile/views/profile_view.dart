import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mekanik/app/data/data_endpoint/profile.dart';
import 'package:mekanik/app/data/endpoint.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../componen/ButtonSubmitWidget.dart';
import '../../../componen/color.dart';
import '../../../componen/loading_cabang_shimmer.dart';
import '../../../data/localstorage.dart';
import '../../../routes/app_pages.dart';
import '../../signin/screens/forget_password.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileViewState();
  }
}

class _ProfileViewState extends State<ProfileView> {
  final controller = Get.put(ProfileController());
  Color theme1 = Colors.white;
  Color theme2 = const Color(0xff2E324F);
  Color black = Colors.black;
  late RefreshController _refreshController;
  @override
  void initState() {
    _refreshController =
        RefreshController();
    super.initState();
  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

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
        android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    controller.checkForUpdate();
    return
      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 0,
          elevation: 0.0,
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          header: const WaterDropHeader(),
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _profilePic(),
                FutureBuilder<Profile>(
                  future: API.profileiD(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                            child: loadcabang(),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                            child: loadcabang(),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                            child: loadcabang(),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                            child: loadcabang(),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                            child: loadcabang(),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                            child: loadcabang(),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                            child: loadcabang(),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                            child: loadcabang(),
                          ),
                        ],
                      );
                    } else {
                      if (snapshot.data != null) {
                        final nama = snapshot.data!.data?.namaKaryawan ?? "";
                        final cabang = snapshot.data!.data?.cabang ?? "";
                        final email = snapshot.data!.data?.email ?? "";
                        final hp = snapshot.data!.data?.hp ?? "";
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                              child: Text(
                                nama ?? "",
                                style: TextStyle(
                                  color: MyColors.appPrimaryColor,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                              child: Text(
                                cabang ?? "",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              email ?? "",
                              style: TextStyle(
                                color: black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              hp ?? "",
                              style: const TextStyle(
                                fontSize: 15.0,
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
                const Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 8.0, 40.0, 0.0),
                  child: Divider(
                    color: Color(0xff78909c),
                    height: 50.0,
                  ),
                ),
                InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    AppSettings.openAppSettings(
                        type: AppSettingsType.notification);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Notifikasi'),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Get.to(const ForgetPasswordPage());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ubah Password'),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor: Colors.transparent,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(30),
                          height: 245,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Continue To Logout?",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Are you sure to logout from this device?",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonSubmitWidget1(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    title: "No, cancel",
                                    bgColor: Colors.white,
                                    textColor: MyColors.appPrimaryColor,
                                    fontWeight: FontWeight.normal,
                                    width: 70,
                                    height: 50,
                                    borderSide: Colors.transparent,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ButtonSubmitWidget2(
                                    onPressed: () {
                                      logout();
                                    },
                                    title: "Yes, Continue",
                                    bgColor: MyColors.appPrimaryColor,
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    width: 100,
                                    height: 50,
                                    borderSide: Colors.transparent,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                Text('Aplikasi Versi ${controller.packageName}', style: TextStyle(color: MyColors.appPrimaryColor),),
              ],
            ),
          ),
        ),
      );
  }

  Padding _profilePic() => Padding(
    padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 15.0),
    child: Stack(
      alignment: const Alignment(0.9, 0.9),
      children: <Widget>[
        const CircleAvatar(
          backgroundImage: AssetImage("assets/avatar.png"),
          radius: 50.0,
        ),
        Container(
          height: 30.0,
          width: 30.0,
          alignment: Alignment.bottomRight,
          child: Image.asset("assets/success_logo.png"),
        ),
      ],
    ),
  );

  _onLoading() {
    _refreshController
        .loadComplete();
  }

  _onRefresh() {
    HapticFeedback.lightImpact();
    setState(() {
      const ProfileView();
      _refreshController
          .refreshCompleted();
    });
  }

  void logout() {
    LocalStorages.deleteToken();
    Get.offAllNamed(Routes.SIGNIN);
  }
}

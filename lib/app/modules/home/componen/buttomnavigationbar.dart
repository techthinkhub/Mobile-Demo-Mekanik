import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mekanik/app/componen/color.dart';
import 'package:mekanik/app/modules/history/views/history_view.dart';
import 'package:mekanik/app/modules/profile/views/profile_view.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../data/data_endpoint/boking.dart';
import '../../boking/views/boking_view.dart';
import '../../promek/views/view.dart';
import '../views/home_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Boking? _cachedBoking;
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void clearCachedBoking() {
    setState(() {
      _cachedBoking = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.width > 600;
    return WillPopScope(
      onWillPop: () async {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.warning,
          title: 'Apakah Anda ingin keluar ?',
          onConfirmBtnTap: () {
            SystemNavigator.pop();
          },
        );
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: isTablet
            ? null
            : CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _page,
          items: const [
            CurvedNavigationBarItem(
              child: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              label: 'Home',
              labelStyle: TextStyle(color: Colors.white),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.timer,
                color: Colors.white,
              ),
              label: 'PKB',
              labelStyle: TextStyle(color: Colors.white),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.calendar_month_rounded,
                color: Colors.white,
              ),
              label: 'Booking',
              labelStyle: TextStyle(color: Colors.white),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.history,
                color: Colors.white,
              ),
              label: 'History',
              labelStyle: TextStyle(color: Colors.white),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.portrait_outlined,
                color: Colors.white,
              ),
              label: 'Profile',
              labelStyle: TextStyle(color: Colors.white),
            ),
          ],
          color: MyColors.appPrimaryColor,
          buttonBackgroundColor: MyColors.appPrimaryColor,
          backgroundColor: Colors.white,
          animationCurve: Curves.linear,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            HapticFeedback.lightImpact();
            setState(() {
              _page = index;
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isTablet)
              Container(
                width: 80,
                color: MyColors.appPrimaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    bool isSelected = _page == index;
                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          _page = index;
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : MyColors.appPrimaryColor, // Background color
                          borderRadius: BorderRadius.circular(12), // Radius rounded
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getIcon(index),
                              color: isSelected ? MyColors.appPrimaryColor : Colors.white, // Icon color
                            ),
                            SizedBox(height: 4),
                            Text(
                              _getTitle(index),
                              style: TextStyle(
                                color: isSelected ? MyColors.appPrimaryColor : Colors.white, // Text color
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            Expanded(
              flex: 1,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _page = index;
                  });
                },
                children: <Widget>[
                  HomePage(),
                  StackOver(),
                  BokingView(),
                  HistoryView2(clearCachedBooking: clearCachedBoking),
                  ProfileView(),
                ],
              ),
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: MyColors.appPrimaryColor,
          ),
        ),
      ),
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home_outlined;
      case 1:
        return Icons.timer;
      case 2:
        return Icons.calendar_month_rounded;
      case 3:
        return Icons.history;
      case 4:
        return Icons.portrait_outlined;
      default:
        return Icons.home_outlined;
    }
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'PKB';
      case 2:
        return 'Booking';
      case 3:
        return 'History';
      case 4:
        return 'Profile';
      default:
        return 'Home';
    }
  }
}

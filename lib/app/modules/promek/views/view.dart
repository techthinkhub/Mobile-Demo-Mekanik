import 'package:flutter/material.dart';
import 'package:mekanik/app/modules/promek/views/pkb.dart';

import '../../../componen/color.dart';
import '../../../componen/loading_cabang_shimmer.dart';
import '../../../data/data_endpoint/profile.dart';
import '../../../data/endpoint.dart';
import 'listupdloadsperpart.dart';
const double borderRadius = 25.0;
class StackOver extends StatefulWidget {
  @override
  _StackOverState createState() => _StackOverState();
}

class _StackOverState extends State<StackOver>
    with SingleTickerProviderStateMixin {

  late PageController _pageController;
  int activePageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/logo_tech.png',
                height: 45,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: _menuBar(context),
                  ),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pageController,
                      physics: const ClampingScrollPhysics(),
                      onPageChanged: (int i) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          activePageIndex = i;
                        });
                      },
                      children: <Widget>[
                        PKBlist(),
                        PKBUploadlist(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _menuBar(BuildContext context) {
    return Container(
     margin: EdgeInsets.symmetric(horizontal: 10),
      height: 40.0,
      decoration: const BoxDecoration(
        color: Color(0XFFE0E0E0),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              onTap: _onPlaceBidButtonPress,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 0),
                alignment: Alignment.center,
                decoration: (activePageIndex == 0) ? BoxDecoration(
                  color:  MyColors.appPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),

                ) : null,
                child: Text(
                  "PKB Service",
                  style: (activePageIndex == 0) ? TextStyle(color: Colors.white) : TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              onTap: _onBuyNowButtonPress,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 0),
                alignment: Alignment.center,
                decoration: (activePageIndex == 1) ? BoxDecoration(
                  color:  MyColors.appPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                ) : null,
                child: Text(
                  "Upload Foto Sparepart",
                  style: (activePageIndex == 1) ? TextStyle(color: Colors.white, fontWeight: FontWeight.bold) : TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPlaceBidButtonPress() {
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onBuyNowButtonPress() {
    _pageController.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

}
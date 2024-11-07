import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mekanik/app/routes/app_pages.dart';
import '../../../componen/color.dart';
import 'card_detailpkb.dart';
import '../controllers/promek_controller.dart';

class DetailPKBView extends StatefulWidget {
  const DetailPKBView({super.key});

  @override
  State<DetailPKBView> createState() => _DetailPKBViewState();
}

class _DetailPKBViewState extends State<DetailPKBView> {
  final PromekController controller = Get.put(PromekController());

  @override
  void initState() {
    super.initState();
    final Map args = Get.arguments;
    controller.setInitialValues(args);
  }

  @override
  Widget build(BuildContext context) {
    final Map args = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Detail PKB',
          style: TextStyle(color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const SingleChildScrollView(
        child:  Padding(
          padding: EdgeInsets.all(10),
          child: CardDetailPKB(),
        ),
      ),
    );
  }
}

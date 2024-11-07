import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mekanik/app/routes/app_pages.dart';
import '../../../componen/color.dart';
import 'card_detailpkb.dart';
import '../controllers/promek_controller.dart';

class DetailPKB extends StatefulWidget {
  const DetailPKB({super.key});

  @override
  State<DetailPKB> createState() => _DetailPKBState();
}

class _DetailPKBState extends State<DetailPKB> {
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.STARTSTOPPKB, arguments: {
                    'kode_svc': args['kode_svc'] ?? '',
                    'kode_booking': args['kode_booking'] ?? '', // Assuming selectedItemJasa contains the selected kode_jasa
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Mekanik',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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

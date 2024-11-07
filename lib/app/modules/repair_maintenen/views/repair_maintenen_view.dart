import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mekanik/app/routes/app_pages.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../componen/color.dart';
import '../../../data/endpoint.dart';
import '../componen/card_consument.dart';
import '../componen/card_repair.dart';
import '../controllers/repair_maintenen_controller.dart';

class RepairMaintenenView extends GetView<RepairMaintenenController> {
  const RepairMaintenenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        Get.arguments as Map<String, dynamic>?;
    final String kodeBooking = arguments?['kode_booking'] ?? '';
    final String kodepelanggan = arguments?['kode_pelanggan'] ?? '';
    final String kodekendaraan = arguments?['kode_kendaraan'] ?? '';
    final String tglBooking = arguments?['tgl_booking'] ?? '';
    final String jamBooking = arguments?['jam_booking'] ?? '';
    final String odometer = arguments?['odometer'] ?? '';
    final String pic = arguments?['pic'] ?? '';
    final String hpPic = arguments?['hp_pic'] ?? '';
    final String kategorikendaraan = arguments?['kategori_kendaraan'] ?? '';
    final String kodeMembership = arguments?['kode_membership'] ?? '';
    final String kodePaketmember = arguments?['kode_paketmember'] ?? '';
    final String tipeSvc = arguments?['nama_jenissvc'] ?? '';
    final String tipePelanggan = arguments?['tipe_pelanggan'] ?? '';
    final String referensi = arguments?['referensi'] ?? '';
    final String referensiTmn = arguments?['referensi_teman'] ?? '';
    final String paketSvc = arguments?['paket_svc'] ?? '';
    final String keluhan = arguments?['keluhan'] ?? '';
    final String catatan = arguments?['catatan'] ?? '';
    final String perintahKerja = arguments?['perintah_kerja'] ?? '';
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 125,
        color: MyColors.appPrimaryColor,
        shape: const CircularNotchedRectangle(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Penting !!',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              'Periksa lagi data Pelanggan sebelum buat Estimasi',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.warning,
                    headerBackgroundColor: Colors.yellow,
                    text: 'Pastikan Kembali data Booking sudah sesuai, untuk Lanjut ke Estimasi',
                    confirmBtnText: 'Konfirmasi',
                    cancelBtnText: 'Kembali',
                    confirmBtnColor: Colors.blue,
                    onConfirmBtnTap: () async {
                      Navigator.pop(Get.context!);
                      try {
                        // Tampilkan indikator loading
                        QuickAlert.show(
                          barrierDismissible: false,
                          context: Get.context!,
                          type: QuickAlertType.loading,
                          headerBackgroundColor: Colors.yellow,
                          text: 'Buat Estimasi......',
                        );

                        // Panggil API untuk menyetujui booking
                        final response = await API.estimasiId(
                          idkaryawan: '',
                          kodeBooking: kodeBooking,
                          kodepelanggan: kodepelanggan,
                          kodekendaraan: kodekendaraan,
                          kategorikendaraan: kategorikendaraan,
                          tglBooking: controller.tanggal.text,
                          jamBooking: controller.jam.text,
                          odometer: controller.odometer.text,
                          pic: controller.pic.text,
                          hpPic: controller.hppic.text,
                          kodeMembership: kodeMembership,
                          kodePaketmember: kodePaketmember,
                          tipeSvc: tipeSvc,
                          tipePelanggan: tipePelanggan,
                          referensi: referensi,
                          referensiTmn: referensiTmn,
                          paketSvc: paketSvc,
                          keluhan: controller.keluhan.text,
                          perintahKerja: controller.perintah.text,
                          ppn: 10,
                        );

                        Navigator.pop(Get.context!);

                        if (response.message == 200) {
                          QuickAlert.show(
                            barrierDismissible: false,
                            context: Get.context!,
                            type: QuickAlertType.success,
                            headerBackgroundColor: Colors.yellow,
                            text: 'Estimasi Telah diBuat',
                            confirmBtnText: 'Kembali',
                            confirmBtnColor: Colors.green,
                            onConfirmBtnTap: () {
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            },
                          );
                        } else {
                          Get.toNamed(Routes.BOKING2);
                          QuickAlert.show(
                            barrierDismissible: false,
                            context: Get.context!,
                            type: QuickAlertType.success,
                            headerBackgroundColor: Colors.yellow,
                            text: 'Estimasi Telah diBuat',
                            confirmBtnText: 'Kembali',
                            confirmBtnColor: Colors.green,
                            onConfirmBtnTap: () {
                              Navigator.pop(Get.context!);
                            },
                          );
                        }
                      } catch (e) {
                        Navigator.pop(Get.context!);
                        QuickAlert.show(
                          barrierDismissible: false,
                          context: Get.context!,
                          type: QuickAlertType.error,
                          headerBackgroundColor: Colors.yellow,
                          text: 'Terjadi kesalahan saat membuat estimasi',
                          confirmBtnText: 'Kembali',
                          confirmBtnColor: Colors.red,
                          onConfirmBtnTap: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Buat Estimasi',
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
        title: Text(tipeSvc??'', style: TextStyle(
          fontWeight: FontWeight.bold,
          color: MyColors.appPrimaryColor,
        ),),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: MyColors.appPrimaryColor,
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              DetailRepair(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

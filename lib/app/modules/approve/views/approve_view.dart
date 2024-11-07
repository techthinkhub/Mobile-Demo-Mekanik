import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mekanik/app/componen/color.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';
import '../../repair_maintenen/componen/card_consument.dart';
import '../componen/card_approve.dart';
import '../componen/card_consument.dart';
import '../controllers/approve_controller.dart';

class ApproveView extends GetView<ApproveController> {
  ApproveView({super.key});
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
    Get.arguments as Map<String, dynamic>?;
    final String kodeBooking = arguments?['kode_booking'] ?? '';
    final String tglBooking = arguments?['tgl_booking'] ?? '';
    final String jamBooking = arguments?['jam_booking'] ?? '';
    final String kodeMembership = arguments?['kode_membership'] ?? '';
    final String kodePaketmember = arguments?['kode_paketmember'] ?? '';
    final String tipeSvc = arguments?['nama_jenissvc'] ?? '';
    final String tipePelanggan = arguments?['tipe_pelanggan'] ?? '';
    final String referensi = arguments?['referensi'] ?? '';
    final String referensiTmn = arguments?['referensi_teman'] ?? '';
    final String paketSvc = arguments?['paket_svc'] ?? '';
    final String hppic = arguments?['hp_pic'] ?? '';
    final String pic = arguments?['pic'] ?? '';
    final String kategorikendaraan = arguments?['kategori_kendaraan'] ?? '';
    final String kodepelanggan = arguments?['kode_pelanggan'] ?? '';
    final String kodekendaraan = arguments?['kode_kendaraan'] ?? '';

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 125,
        elevation: 0,
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
              'Periksa lagi data Pelanggan sebelum Approve',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    String idKaryawan = GetStorage().read('idKaryawan') ?? '';
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.warning,
                      barrierDismissible: true,
                      text: 'Periksa kembali data Pelanggan',
                      confirmBtnText: 'Konfirmasi',
                      onConfirmBtnTap: () async {
                        try {
                          Navigator.pop(Get.context!);
                          QuickAlert.show(
                            barrierDismissible: false,
                            context: Get.context!,
                            type: QuickAlertType.loading,
                            headerBackgroundColor: Colors.yellow,
                            text: 'Approve......',
                          );
                          Navigator.pop(Get.context!);
                          await API.approveId(
                            idkaryawan: idKaryawan ?? '',
                            kodeBooking: kodeBooking ??'',
                            kodepelanggan: kodepelanggan ??'',
                            kodekendaraan: kodekendaraan ??'',
                            kategorikendaraan: kategorikendaraan ??'',
                            tglBooking: tglBooking ??'',
                            jamBooking: jamBooking ??'',
                            odometer: controller.odometer.text,
                            pic: pic??'',
                            hpPic: hppic??'',
                            kodeMembership: kodeMembership??'',
                            kodePaketmember: kodePaketmember??'',
                            tipeSvc: tipeSvc??'',
                            tipePelanggan: tipePelanggan??'',
                            referensi: referensi??'',
                            referensiTmn: referensiTmn??'',
                            paketSvc: paketSvc??'',
                            keluhan: controller.keluhan.text,
                            perintahKerja: controller.perintah.text,
                            ppn: 10,
                          );
                          print('id karyawan : ${idKaryawan}');
                          Navigator.pop(Get.context!);
                        } catch (e) {
                          Navigator.pop(context, true);
                          Get.toNamed(Routes.BOKING2);
                          QuickAlert.show(
                            barrierDismissible: false,
                            context: Get.context!,
                            type: QuickAlertType.success,
                            headerBackgroundColor: Colors.yellow,
                            text: 'Estimasi Telah diBuat',
                            confirmBtnText: 'Kembali',
                            cancelBtnText: 'Kembali',
                            confirmBtnColor: Colors.green,  
                          );
                        }
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 4.0,
                  ),
                  child: const Text(
                    'Approve',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    var message = '';
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.warning,
                        barrierDismissible: true,
                        text: 'catatan kenapa anda Unapprove',
                        confirmBtnText: 'Konfirmasi',
                        widget: TextFormField(
                          controller: controller.catatan,
                          decoration: const InputDecoration(
                            alignLabelWithHint: true,
                            hintText: 'catatan',
                            prefixIcon: Icon(
                              Icons.mail_lock_rounded,
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          onChanged: (value) => message = value,
                        ),
                        onConfirmBtnTap: () async {
                          Navigator.pop(Get.context!);
                          try {
                            if (kDebugMode) {
                              print('kode_booking: $kodeBooking');
                            }
                            QuickAlert.show(
                              context: Get.context!,
                              type: QuickAlertType.loading,
                              headerBackgroundColor: Colors.yellow,
                              text: 'Unapproving...',
                              confirmBtnText: '',
                            );
                            await API.unapproveId(
                              catatan: controller.catatan.text,
                              kodeBooking: kodeBooking,
                            );
                            Get.toNamed(Routes.BOKING2);
                            QuickAlert.show(
                              barrierDismissible: false,
                              context: Get.context!,
                              type: QuickAlertType.success,
                              headerBackgroundColor: Colors.yellow,
                              text: 'Booking has been Unapproving',
                              confirmBtnText: 'Kembali',
                              cancelBtnText: 'Kembali',
                              confirmBtnColor: Colors.green,
                            );
                          } catch (e) {
                            Get.toNamed(Routes.BOKING2);
                            QuickAlert.show(
                              barrierDismissible: false,
                              context: Get.context!,
                              type: QuickAlertType.success,
                              headerBackgroundColor: Colors.yellow,
                              text: 'Booking has been Unapproving',
                              confirmBtnText: 'Kembali',
                              cancelBtnText: 'Kembali',
                              confirmBtnColor: Colors.green,
                            );
                          }
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    enableFeedback: true,
                    foregroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 4.0,
                  ),
                  child: const Text(
                    'Unapprove',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Approve',
          style: TextStyle(
              color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: MyColors.appPrimaryColor,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              DetailApprove(),
              SizedBox(
                width: 10,
              ),
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mekanik/app/modules/repair_maintenen/componen/card_consument.dart';

import '../../approve/componen/card_detail.dart';
import '../controllers/repair_maintenen_controller.dart';

class DetailBooking extends GetView<RepairMaintenenController> {
  const DetailBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;
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
    final String status = arguments?['status'] ?? '';
    final String perintahKerja = arguments?['perintah_kerja'] ?? '';

    Color statusColor = StatusColor.getColor(status);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(children: [
            const Text(
              'Status Booking ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            )
          ],),
        ),
        centerTitle: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: const [
              DetailCard(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusColor {
  static Color getColor(String status) {
    switch (status.toLowerCase()) {
      case 'booking':
        return Colors.blue;
      case 'approve':
        return Colors.green;
      case 'diproses':
        return Colors.orange;
      case 'estimasi':
        return Colors.green;
      case 'selesai dikerjakan':
        return Colors.blue;
      case 'pkb':
        return Colors.green;
      case 'pkb tutup':
        return Colors.redAccent;
      case 'invoice':
        return Colors.blue;
      case 'lunas':
        return Colors.green;
      case 'ditolak by sistem':
        return Colors.red;
      case 'cancel booking':
        return Colors.red;
      case 'ditolak':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }
}
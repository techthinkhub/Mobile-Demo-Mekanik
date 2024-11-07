import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../componen/color.dart';
import '../../../data/data_endpoint/detailhistory.dart';
import '../../../data/data_endpoint/mekanik_pkb.dart';
import '../../../data/endpoint.dart';
import '../../repair_maintenen/controllers/repair_maintenen_controller.dart';

class DetailCard extends StatefulWidget {
  const DetailCard({Key? key}) : super(key: key);

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
  }

  void _launchPhoneCall(String phoneNumber) async {
    final Uri phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (await canLaunch(phoneLaunchUri.toString())) {
        await launch(phoneLaunchUri.toString());
      } else {
        final AndroidIntent intent = AndroidIntent(
          action: 'action_view',
          data: phoneLaunchUri.toString(),
        );
        await intent.launch();
      }
    } catch (e) {
      print('Error launching phone call: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map args = Get.arguments;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalMargin = screenWidth * 0.03;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(horizontalMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Booking',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.appPrimaryColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
             _buildInfoRow('Nomor Lambung:', args['vin_number'] ?? ''),
            _buildInfoRow('Tanggal Booking:', args['tgl_booking'] ?? ''),
            _buildInfoRow('Jam Booking :', args['jam_booking'] ?? ''),
            _buildInfoRow('Kode Booking:', args['kode_booking'] ?? '', color: Colors.green),
            _buildInfoRow('Tipe Order:', args['type_order'] ?? ''),
            const SizedBox(height: 10),
            Text(
              'Detail PIC',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.appPrimaryColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            _buildInfoRow('PIC :', args['pic'] ?? '-'),
            _buildInfoRow('HP PIC :', args['hp_pic'] ?? '-'),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            Text(
              'Detail Pelanggan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.appPrimaryColor,
                fontSize: 16,
              ),
            ),
            _buildInfoRow('Nama:', args['nama'] ?? ''),
            _buildInfoRow('No Handphone:', args['hp'] ?? ''),
            _buildInfoRow('Alamat:', args['alamat'] ?? ''),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            Text(
              'Kendaraan Pelanggan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.appPrimaryColor,
                fontSize: 16,
              ),
            ),
            _buildInfoRow('Merk:', args['nama_merk'] ?? ''),
            _buildInfoRow('Tipe:', args['nama_tipe'] ?? ''),
            _buildInfoRow('Tahun:', args['tahun'] ?? '-'),
            _buildInfoRow('Warna:', args['warna'] ?? '-'),
            _buildInfoRow('Kategori Kendaraan:', args['kategori_kendaraan'] ?? '-'),
            _buildInfoRow('Transmisi:', args['transmisi'] ?? '-'),
            _buildInfoRow('No Polisi:', args['no_polisi'] ?? '-'),
            const Divider(color: Colors.grey),
            Text(
              'Keluhan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.appPrimaryColor,
                fontSize: 16,
              ),
            ),
            _buildDetailSection(args['keluhan'] ?? '-', ''),
            const Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }

  String formatCurrency(int? amount) {
    if (amount == null) {
      return 'Rp. -';
    }
    var format = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
    return format.format(amount);
  }

  Widget _buildInfoRow(String title, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color ?? Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailText(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildDetailSection(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}

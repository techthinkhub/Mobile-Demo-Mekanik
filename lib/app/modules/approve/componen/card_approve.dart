import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../componen/color.dart';
import '../../../data/data_endpoint/kategory.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';

class DetailApprove extends StatefulWidget {
  const DetailApprove({Key? key}) : super(key: key);

  @override
  State<DetailApprove> createState() => _DetailApproveState();
}

class _DetailApproveState extends State<DetailApprove> {
  String? kodeBooking;
  String? tglBooking;
  String? jamBooking;
  String? kodeMembership;
  String? kodePaketmember;
  String? tipeSvc;
  String? tipePelanggan;
  String? referensi;
  String? referensiTmn;
  String? paketSvc;
  String? kategorikendaraan;
  String? kodepelanggan;
  String? kodekendaraan;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        'Detail Booking',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.appPrimaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        print('kodeBooking: $kodeBooking');
                        print('tglBooking: $tglBooking');
                        final generalData = await API.kategoriID();
                        String? kategoriKendaraanId = args['kategori_kendaraan'] ?? '-';
                        if (generalData != null) {
                          final matchingKategori = generalData.dataKategoriKendaraan?.firstWhere(
                                (kategori) => kategori.kategoriKendaraan == (args['kategori_kendaraan'] ?? '-'),
                            orElse: () => DataKategoriKendaraan(kategoriKendaraanId: '', kategoriKendaraan: ''),
                          );
                          if (matchingKategori != null) {
                            kategoriKendaraanId = matchingKategori.kategoriKendaraanId;
                          }
                        }
                        Get.toNamed(
                          Routes.APPROVEEDIT,
                          arguments: {
                            'nama': args['nama'] ?? '-',
                            'kode_kendaraan': args['kode_kendaraan'] ?? '-',
                            'kode_pelanggan': args['kode_pelanggan'] ?? '-',
                            'kode_booking': args['kode_booking'] ?? '-',
                            'nama_jenissvc': args['nama_jenissvc'] ?? '-',
                            'no_polisi': args['no_polisi'] ?? '-',
                            'tahun': args['tahun'] ?? '-',
                            'keluhan': args['keluhan'] ?? '-',
                            'type_order': args['type_order'] ?? '-',
                            'kategori_kendaraan': args['kategori_kendaraan'] ?? '-',
                            'warna': args['warna'] ?? '-',
                            'hp': args['hp'] ?? '-',
                            'vin_number': args['vin_number'] ?? '-',
                            'nama_merk': args['nama_merk'] ?? '-',
                            'transmisi': args['transmisi'] ?? '-',
                            'nama_tipe': args['nama_tipe'] ?? '-',
                            'alamat': args['alamat'] ?? '-',
                            'booking_id': args['booking_id'] ?? '-',
                            'status': args['status'] ?? '-',

                            'kode_booking': args['kode_booking'] ?? '-',
                            'tgl_booking': args['tgl_booking'] ?? '-',
                            'jam_booking': args['jam_booking'] ?? '-',
                            'kode_membership': args['kode_membership'] ?? '-',
                            'kode_paketmember': args['kode_paketmember'] ?? '-',
                            'tipe_svc': args['tipe_svc'] ?? '-',
                            'tipe_pelanggan': args['tipe_pelanggan'] ?? '-',
                            'referensi': args['referensi'] ?? '-',
                            'referensi_tmn': args['referensi_tmn'] ?? '-',
                            'paket_svc': args['paket_svc'] ?? '-',
                            'kategori_kendaraan': kategoriKendaraanId,  // Gunakan kategoriKendaraanId yang diperbarui
                            'kode_pelanggan': args['kode_pelanggan'] ?? '-',
                            'kode_kendaraan': args['kode_kendaraan'] ?? '-',
                          },
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.edit_calendar, size: 20),
                          SizedBox(width: 10),
                          Text('Edit'),
                        ],
                      ),
                    ),

                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildInfoRow('Jenis Service :', args['nama_jenissvc'] ?? '-'),
            _buildInfoRow('Nomor Lambung :', args['vin_number'] ?? '-'),
            _buildInfoRow('Tanggal Booking :', args['tgl_booking'] ?? '-'),
            _buildInfoRow('Jam Booking :', args['jam_booking'] ?? '-'),
            _buildInfoRow('Kode Booking :', args['kode_booking'] ?? '-', color: Colors.green),
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
            _buildInfoRow('Odometer:', args['Odometer'] ?? '-'),
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

  Widget _buildInfoRow(String title, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: TextStyle(
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
          style: TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}

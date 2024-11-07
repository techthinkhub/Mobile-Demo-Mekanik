import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mekanik/app/componen/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../data/data_endpoint/detailhistory.dart';
import '../../../data/data_endpoint/detailsperpart.dart';
import '../../../data/data_endpoint/mekanik_pkb.dart';
import '../../../data/endpoint.dart';
import '../controllers/promek_controller.dart';

class CardDetailPKB extends StatefulWidget {
  const CardDetailPKB({Key? key}) : super(key: key);

  @override
  State<CardDetailPKB> createState() => _CardDetailPKBState();
}

class _CardDetailPKBState extends State<CardDetailPKB> {
  final PromekController controller = Get.put(PromekController());
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map args = Get.arguments;

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            args['tipe_svc'] ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.appPrimaryColor, // Example color
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          _buildInfoRow('Tanggal & Jam PKB:', args['tgl_pkb'] ?? ''),
          _buildInfoRow('Jam Selesai:', args['jam_selesai'] ?? '-'),
          _buildInfoRow('Cabang:', args['nama_cabang'] ?? ''),
          _buildInfoRow('Kode PKB:', args['kode_pkb'] ?? '',
              color: Colors.green),
          _buildInfoRow('Tipe Pelanggan:', args['tipe_pelanggan'] ?? ''),
          const Divider(color: Colors.grey),
          const SizedBox(height: 10),
          Text(
            'Detail Pelanggan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.appPrimaryColor, // Example color
              fontSize: 16,
            ),
          ),
          _buildDetailText('Nama:', args['nama'] ?? ''),
          _buildDetailText('No Handphone:', args['telp'] ?? ''),
          _buildDetailText('Alamat:', args['alamat'] ?? ''),
          const Divider(color: Colors.grey),
          const SizedBox(height: 10),
          Text(
            'Kendaraan Pelanggan',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.appPrimaryColor, // Example color
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
          _buildInfoRow('Vin Number:', args['vin_number'] ?? 'belum ada Vin Number'),
          const Divider(color: Colors.grey),
          _buildDetailSection('Keluhan:', args['keluhan'] ?? '-'),
          const Divider(color: Colors.grey),
          const SizedBox(height: 10),
          Text(
            'Sparepart',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.appPrimaryColor, // Example color
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder<DetailSpertpart>(
            future: API.DetailSpertpartID(kodesvc: args['kode_svc'] ?? ''),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final SpertList = snapshot.data?.dataPhotosparepart?.detailSparepart ?? [];
                if (SpertList.isEmpty) {
                  return Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: Text(
                      'Belum ada Jasa',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red, // Example color
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: SpertList.length,
                  itemBuilder: (context, index) {
                    final jasa = SpertList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jasa.namaSparepart ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text('Harga Jasa:  ${formatCurrency(jasa.hargaSparepart).toString()}',
                            style: TextStyle(
                              fontSize: 14,
                            )),
                        SizedBox(height: 5),
                        Text('Kode Sparepart:  ${jasa.kodeSparepart.toString()}',
                            style: TextStyle(
                              fontSize: 14,
                            )),
                        SizedBox(height: 5),
                        Text('QTY:  ${jasa.qtySparepart.toString()}',
                            style: TextStyle(
                              fontSize: 14,
                            )),

                        const Divider(),
                      ],
                    );
                  },
                );
              }
            },
          ),
          const Divider(color: Colors.grey),
          const SizedBox(height: 10),
          Text(
            'Jasa',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color:MyColors.appPrimaryColor, // Example color
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder<MekanikPKB>(
            future: API.MeknaikPKBID(kodesvc: args['kode_svc'] ?? ''),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final jasaList = snapshot.data?.dataJasaMekanik?.jasa ?? [];
                if (jasaList.isEmpty) {
                  return Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: Text(
                      'Belum ada Jasa',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red, // Example color
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: jasaList.length,
                  itemBuilder: (context, index) {
                    final jasa = jasaList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jasa.namaJasa ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text('Harga Jasa:  ${formatCurrency(jasa.hargaJasa)}',
                            style: TextStyle(
                              fontSize: 14,
                            )),
                        SizedBox(height: 5),
                        Text('Kode Jasa:  ${jasa.kodeJasa??''}',
                            style: TextStyle(
                              fontSize: 14,
                            )),
                        SizedBox(height: 5),
                        Text('QTY:  ${jasa.qtyJasa??''}',
                            style: TextStyle(
                              fontSize: 14,
                            )),
                        const Divider(),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
  String formatCurrency(int? amount) {
    if (amount == null) {
      return 'Rp. -'; // or any default value you prefer for null case
    }
    var format = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ');
    return format.format(amount);
  }

  Widget _buildInfoRow(String title, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis, // Ensures the text does not overflow
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color ?? Colors.black,
              overflow: TextOverflow.ellipsis, // Ensures the text does not overflow
            ),
            textAlign: TextAlign.right, // Aligns the text to the right
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
            fontWeight: FontWeight.normal,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[100],
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

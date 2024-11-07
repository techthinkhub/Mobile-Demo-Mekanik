import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mekanik/app/componen/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:search_page/search_page.dart';
import '../../../componen/loading_cabang_shimmer.dart';
import '../../../componen/loading_search_shimmer.dart';
import '../../../componen/loading_search_shimmerpkb.dart';
import '../../../componen/loading_shammer_booking.dart';
import '../../../componen/loading_shammer_history.dart';
import '../../../data/data_endpoint/pkb.dart';
import '../../../data/data_endpoint/profile.dart';
import '../../../data/data_endpoint/uploadperpart.dart';
import '../../../data/endpoint.dart';
import '../../../data/localstorage.dart';
import '../../../routes/app_pages.dart';
import '../componen/card_pkb.dart';
import '../componen/card_uploadperpart.dart';

class PKBUploadlist extends StatefulWidget {
  const PKBUploadlist({Key? key}) : super(key: key);

  @override
  State<PKBUploadlist> createState() => _PKBUploadlistState();
}

class _PKBUploadlistState extends State<PKBUploadlist>
    with AutomaticKeepAliveClientMixin<PKBUploadlist> {
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> handleBookingTap(DataPhotosparepart e) async {
    Get.toNamed(
      Routes.CardDetailPKBSperepart,
      arguments: {
        'id': e.id ?? '',
        'kode_booking': e.kodeBooking ?? '',
        'cabang_id': e.cabangId ?? '',
        'kode_svc': e.kodeSvc ?? '',
        'kode_estimasi': e.kodeEstimasi ?? '',
        'kode_pkb': e.kodePkb ?? '',
        'kode_pelanggan': e.kodePelanggan ?? '',
        'kode_kendaraan': e.kodeKendaraan ?? '',
        'odometer': e.odometer ?? '',
        'pic': e.pic ?? '',
        'hp_pic': e.hpPic ?? '',
        'kode_membership': e.kodeMembership ?? '',
        'kode_paketmember': e.kodePaketmember ?? '',
        'tipe_svc': e.tipeSvc ?? '',
        'tipe_pelanggan': e.tipePelanggan ?? '',
        'referensi': e.referensi ?? '',
        'referensi_teman': e.referensiTeman ?? '',
        'po_number': e.poNumber ?? '',
        'paket_svc': e.paketSvc ?? '',
        'tgl_keluar': e.tglKeluar ?? '',
        'tgl_kembali': e.tglKembali ?? '',
        'km_keluar': e.kmKeluar ?? '',
        'km_kembali': e.kmKembali ?? '',
        'keluhan': e.keluhan ?? '',
        'perintah_kerja': e.perintahKerja ?? '',
        'pergantian_part': e.pergantianPart ?? '',
        'saran': e.saran ?? '',
        'ppn': e.ppn ?? '',
        'penanggung_jawab': e.penanggungJawab ?? '',
        'tgl_estimasi': e.tglEstimasi ?? '',
        'tgl_pkb': e.tglPkb ?? '',
        'tgl_tutup': e.tglTutup ?? '',
        'jam_estimasi_selesai': e.jamEstimasiSelesai ?? '',
        'jam_selesai': e.jamSelesai ?? '',
        'pkb': e.pkb ?? '',
        'tutup': e.tutup ?? '',
        'faktur': e.faktur ?? '',
        'deleted': e.deleted ?? '',
        'notab': e.notab ?? '',
        'status_approval': e.statusApproval ?? '',
        'created_by': e.createdBy ?? '',
        'created_by_pkb': e.createdByPkb ?? '',
        'created_at': e.createdAt ?? '',
        'updated_by': e.updatedBy ?? '',
        'updated_at': e.updatedAt ?? '',
        'kode': e.kode ?? '',
        'no_polisi': e.noPolisi ?? '',
        'id_merk': e.idMerk ?? '',
        'id_tipe': e.idTipe ?? '',
        'tahun': e.tahun ?? '',
        'warna': e.warna ?? '',
        'transmisi': e.transmisi ?? '',
        'no_rangka': e.noRangka ?? '',
        'no_mesin': e.noMesin ?? '',
        'model_karoseri': e.modelKaroseri ?? '',
        'driving_mode': e.drivingMode ?? '',
        'power': e.power ?? '',
        'kategori_kendaraan': e.kategoriKendaraan ?? '',
        'jenis_kontrak': e.jenisKontrak ?? '',
        'jenis_unit': e.jenisUnit ?? '',
        'id_pic_perusahaan': e.idPicPerusahaan ?? '',
        'pic_id_pelanggan': e.picIdPelanggan ?? '',
        'id_customer': e.idCustomer ?? '',
        'nama': e.nama ?? '',
        'alamat': e.alamat ?? '',
        'telp': e.telp ?? '',
        'hp': e.hp ?? '',
        'email': e.email ?? '',
        'kontak': e.kontak ?? '',
        'due': e.due ?? '',
        'jenis_kontrak_x': e.jenisKontrakX ?? '',
        'nama_tagihan': e.namaTagihan ?? '',
        'alamat_tagihan': e.alamatTagihan ?? '',
        'telp_tagihan': e.telpTagihan ?? '',
        'npwp_tagihan': e.npwpTagihan ?? '',
        'pic_tagihan': e.picTagihan ?? '',
        'password': e.password ?? '',
        'remember_token': e.rememberToken ?? '',
        'email_verified_at': e.emailVerifiedAt ?? '',
        'otp': e.otp ?? '',
        'otp_expiry': e.otpExpiry ?? '',
        'gambar': e.gambar ?? '',
        'nama_cabang': e.namaCabang ?? '',
        // 'nama_merk': e.namaMerk ?? '',
        // 'nama_tipe': e.namaTipe ?? '',
        // 'status': e.status ?? '',
        // 'jasa': e.jasa?.map((j) => {
        //   'nama_jasa': j.namaJasa ?? '',
        //   'kode_jasa': j.kodeJasa ?? '',
        //   'harga': j.hargaJasa ?? 0,
        // }).toList() ?? [],
        // 'parts': e.parts ?? [],
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          title: FutureBuilder(
            future: API.ListSperpartID(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  padding: EdgeInsets.symmetric(vertical: 10),
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
                  child: Row(children: [
                    SizedBox(width: 10,),
                    Icon(Icons.search_rounded, color: MyColors.appPrimaryColor,),
                    SizedBox(width: 10,),
                    Text('Pencarian List Sperepart',  style: TextStyle(fontSize: 14, color: MyColors.appPrimaryColor),)
                  ],),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                final data = snapshot.data!.dataPhotosparepart;

                if (data != null && data.isNotEmpty) {
                  return InkWell(
                    onTap: () => showSearch(
                      context: context,
                      delegate: SearchPage<DataPhotosparepart>(
                        items: data,
                        searchLabel: 'Pencarian List Sperepart',
                        searchStyle: GoogleFonts.nunito(color: Colors.black),
                        showItemsOnEmpty: true,
                        failure: Center(
                          child: Text(
                            'Pencarian List Sperepart Tidak Dtemukan :(',
                            style: GoogleFonts.nunito(),
                          ),
                        ),
                        filter: (booking) => [
                          booking.nama,
                          booking.noPolisi,
                          booking.createdByPkb,
                          booking.createdBy,
                          booking.tglEstimasi,
                          booking.tipeSvc,
                          booking.kodePkb,
                          booking.kodePelanggan,
                        ],
                        builder: (items) => pkblistSperpart(
                          items: items,
                          onTap: () {
                            handleBookingTap(items);
                          },
                        ),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      padding: EdgeInsets.symmetric(vertical: 10),
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
                      child: Row(children: [
                        SizedBox(width: 10,),
                        Icon(Icons.search_rounded, color: MyColors.appPrimaryColor,),
                        SizedBox(width: 10,),
                        Text('Pencarian List Sperepart',  style: TextStyle(fontSize: 14, color: Colors.black54),)
                      ],),
                    ),
                  );
                } else {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    padding: EdgeInsets.symmetric(vertical: 10),
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
                    child: Row(children: [
                      SizedBox(width: 10,),
                      Icon(Icons.search_rounded, color: MyColors.appPrimaryColor,),
                      SizedBox(width: 10,),
                      Text('Pencarian List Sperepart',  style: TextStyle(fontSize: 14, color: Colors.black54),)
                    ],),
                  );
                }
              } else {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  padding: EdgeInsets.symmetric(vertical: 10),
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
                  child: Row(children: [
                    SizedBox(width: 10,),
                    Icon(Icons.search_rounded, color: MyColors.appPrimaryColor,),
                    SizedBox(width: 10,),
                    Text('Pencarian List Sperepart',  style: TextStyle(fontSize: 14, color: MyColors.appPrimaryColor),)
                  ],),
                );
              }
            },
          ),
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          header: const WaterDropHeader(),
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                  future: API.ListSperpartID(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Loadingshammer());
                    } else if (snapshot.hasError) {
                      return Center(child: Loadingshammer());
                    } else if (!snapshot.hasData ||
                        (snapshot.data as UploadSpertpart).dataPhotosparepart == null ||
                        (snapshot.data as UploadSpertpart).dataPhotosparepart!.isEmpty) {
                      return Container(
                        height: 500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/booking.png',
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Belum ada data Foto Sperepart',
                              style: TextStyle(
                                  color: MyColors.appPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      );
                    } else {
                      UploadSpertpart getDataAcc = snapshot.data as UploadSpertpart;
                      List<DataPhotosparepart> sortedDataPKB =
                      getDataAcc.dataPhotosparepart!.toList();
                      sortedDataPKB.sort((a, b) {
                        int extractNumber(String kodePkb) {
                          RegExp regex = RegExp(r'(\d+)$');
                          Match? match = regex.firstMatch(kodePkb);
                          return match != null ? int.parse(match.group(0)!) : 0;
                        }

                        int aNumber = extractNumber(a.kodePkb ?? '');
                        int bNumber = extractNumber(b.kodePkb ?? '');
                        return bNumber.compareTo(aNumber);
                      });

                      return Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 475),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: sortedDataPKB.map((e) {
                            return pkblistSperpart(
                              items: e,
                              onTap: () {
                                handleBookingTap(e);
                              },
                            );
                          }).toList(),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 170,)
              ],
            ),
          ),
        ),
      );
  }

  _onLoading() {
    _refreshController.loadComplete();
  }

  _onRefresh() {
    HapticFeedback.lightImpact();
    setState(() {
      // Reload data here if needed
      _refreshController.refreshCompleted();
    });
  }

  void logout() {
    LocalStorages.deleteToken();
    Get.offAllNamed(Routes.SIGNIN);
  }
}


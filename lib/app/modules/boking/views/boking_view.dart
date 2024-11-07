import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mekanik/app/componen/color.dart';
import 'package:mekanik/app/data/data_endpoint/kategory.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:search_page/search_page.dart';

import '../../../componen/loading_cabang_shimmer.dart';
import '../../../componen/loading_search_shimmer.dart';
import '../../../componen/loading_shammer_booking.dart';
import '../../../data/data_endpoint/boking.dart';
import '../../../data/data_endpoint/profile.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';
import '../../../tester/tester_kategori.dart';
import '../componen/card_booking.dart';
import '../controllers/boking_controller.dart';

class BokingView extends StatefulWidget {
  const BokingView({super.key});

  @override
  State<BokingView> createState() => _BokingViewState();
}

class _BokingViewState extends State<BokingView> {
  void clearCachedBoking() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BokingView2(
      clearCachedBoking: clearCachedBoking,
    );
  }
}

class BokingView2 extends StatefulWidget {
  final VoidCallback
  clearCachedBoking; // Menggunakan VoidCallback untuk tipe fungsi tanpa parameter

  const BokingView2({super.key, required this.clearCachedBoking});

  @override
  State<BokingView2> createState() => _BokingView2State();
}

class _BokingView2State extends State<BokingView2> {
  late List<RefreshController> _refreshControllers;
  final controller = Get.put(BokingController());
  @override
  void initState() {
    _refreshControllers = List.generate(14, (index) => RefreshController());
    super.initState();
  }
  Future<void> handleBookingTap(DataBooking e) async {
    HapticFeedback.lightImpact();
    if (kDebugMode) {
      print('Nilai e.namaJenissvc: ${e.namaService ?? ''}');
    }
    if (e.bookingStatus != null && e.namaService != null) {
      if (e.bookingStatus!.toLowerCase() == 'booking' &&
          e.namaService!.toLowerCase() != 'repair & maintenance') {
        Get.toNamed(
          Routes.APPROVE,
          arguments: {
            'tgl_booking': e.tglBooking ?? '',
            'jam_booking': e.jamBooking ?? '',
            'nama': e.nama ?? '',
            'kode_kendaraan': e.kodeKendaraan ?? '',
            'kode_pelanggan': e.kodePelanggan ?? '',
            'kode_booking': e.kodeBooking ?? '',
            'nama_jenissvc': e.namaService ?? '',
            'no_polisi': e.noPolisi ?? '',
            'nama_merk': e.namaMerk ?? '',
            'keluhan': e.keluhan ?? '',
            'tahun': e.tahun ?? '',
            'vin_number': e.vinNumber ?? '',
            'warna': e.warna ?? '',
            'booking_id': e.tglBooking ?? '',
            'nama_tipe': e.namaTipe ?? '',
            'alamat': e.alamat ?? '',
            'hp': e.hp ?? '',
            'hp_pic': e.hpPic ?? '',
            'kode_pelanggan': e.kodePelanggan ?? '',
            'kategori_kendaraan': e.kategoriKendaraan ?? '',
          },
        );
      } else if (e.bookingStatus!.toLowerCase() == 'booking' &&
          e.namaService!.toLowerCase() != 'general check up/p2h') {
        Get.toNamed(
          Routes.APPROVE,
          arguments: {
            'tgl_booking': e.tglBooking ?? '',
            'booking_id': e.tglBooking ?? '',
            'jam_booking': e.jamBooking ?? '',
            'nama': e.nama ?? '',
            'keluhan': e.keluhan ?? '',
            'kode_kendaraan': e.kodeKendaraan ?? '',
            'kode_pelanggan': e.kodePelanggan ?? '',
            'nama_jenissvc': e.namaService ?? '',
            'no_polisi': e.noPolisi ?? '',
            'kode_booking': e.kodeBooking ?? '',
            'tahun': e.tahun ?? '',
            'warna': e.warna ?? '',
            'ho': e.hp ?? '',
            'vin_number': e.vinNumber ?? '',
            'kode_booking': e.kodeBooking ?? '',
            'nama_merk': e.namaMerk ?? '',
            'transmisi': e.transmisi ?? '',
            'nama_tipe': e.namaTipe ?? '',
            'alamat': e.alamat ?? '',
            'status': e.bookingStatus ?? '',
          },
        );
      }
    } else {
      print('Status atau namaJenissvc bernilai null');
    }

    if (e.bookingStatus != null && e.namaService != null) {
      if (e.bookingStatus!.toLowerCase() == 'approve' &&
          e.namaService!.toLowerCase() != 'repair & maintenance') {
        final generalData = await API.kategoriID();
        String kategoriKendaraanId = '';
        if (generalData != null) {
          final matchingKategori = generalData
              .dataKategoriKendaraan
              ?.where((kategori) =>
          kategori.kategoriKendaraan == e.kategoriKendaraan)
              .firstOrNull;
          if (matchingKategori != null &&
              matchingKategori is DataKategoriKendaraan) {
            kategoriKendaraanId =
                matchingKategori.kategoriKendaraanId ?? '';
          }
        }
        Get.toNamed(
          Routes.GENERAL_CHECKUP,
          arguments: {
            'tgl_booking': e.tglBooking ?? '',
            'booking_id': e.bookingId.toString(),
            'jam_booking': e.jamBooking ?? '',
            'nama': e.nama ?? '',
            'kode_booking': e.kodeBooking ?? '',
            'kode_kendaraan': e.kodeKendaraan ?? '',
            'kode_pelanggan': e.kodePelanggan ?? '',
            'nama_jenissvc': e.namaService ?? '',
            'no_polisi': e.noPolisi ?? '',
            'tahun': e.tahun ?? '',
            'keluhan': e.keluhan ?? '',
            'kategori_kendaraan': e.kategoriKendaraan ?? '',
            'kategori_kendaraan_id': kategoriKendaraanId,
            'warna': e.warna ?? '',
            'ho': e.hp ?? '',
            'vin_number': e.vinNumber ?? '',
            'kode_booking': e.kodeBooking ?? '',
            'nama_merk': e.namaMerk ?? '',
            'transmisi': e.transmisi ?? '',
            'nama_tipe': e.namaTipe ?? '',
            'alamat': e.alamat ?? '',
            'status': e.bookingStatus ?? '',
          },
        );
      } else if (e.bookingStatus!.toLowerCase() == 'approve' &&
          e.namaService!.toLowerCase() != 'general check up/p2h') {
        final generalData = await API.kategoriID();
        String kategoriKendaraanId = '';
        if (generalData != null) {
          final matchingKategori = generalData.dataKategoriKendaraan?.firstWhere(
                (kategori) => kategori.kategoriKendaraan == e.kategoriKendaraan,
            orElse: () => DataKategoriKendaraan(kategoriKendaraanId: '', kategoriKendaraan: ''),
          );
          if (matchingKategori != null && matchingKategori is DataKategoriKendaraan) {
            kategoriKendaraanId = matchingKategori.kategoriKendaraanId ?? '';
          }
        }
        Get.toNamed(
          Routes.REPAIR_MAINTENEN,
          arguments: {
            'tgl_booking': e.tglBooking ?? '',
            'booking_id': e.bookingId.toString(),
            'jam_booking': e.jamBooking ?? '',
            'nama': e.nama ?? '',
            'kategori_kendaraan_id': kategoriKendaraanId,
            'kategori_kendaraan': e.kategoriKendaraan ?? '',
            'kode_booking': e.kodeBooking ?? '',
            'nama_jenissvc': e.namaService ?? '',
            'no_polisi': e.noPolisi ?? '',
            'tahun': e.tahun ?? '',
            'warna': e.warna ?? '',
            'keluhan': e.keluhan ?? '',
            'kode_kendaraan': e.kodeKendaraan ?? '',
            'kode_pelanggan': e.kodePelanggan ?? '',
            'ho': e.nama ?? '',
            'vin_number': e.vinNumber ?? '',
            'kode_booking': e.kodeBooking ?? '',
            'nama_merk': e.namaMerk ?? '',
            'transmisi': e.transmisi ?? '',
            'nama_tipe': e.namaTipe ?? '',
            'alamat': e.alamat ?? '',
            'status': e.bookingStatus ?? '',
          },
        );
      }
    } else {
      print('Status atau namaJenissvc bernilai null');
    }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 12,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          toolbarHeight: 60,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking',
                style: TextStyle(
                    color: MyColors.appPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
              FutureBuilder<Profile>(
                future: API.profileiD(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const loadcabang();
                  } else if (snapshot.hasError) {
                    return const Text(
                      'tidak ada koneksi',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    if (snapshot.data != null) {
                      final cabang = snapshot.data!.data?.cabang ?? "";
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cabang,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const loadcabang();
                    }
                  }
                },
              ),
            ],
          ),
          actions: [
            FutureBuilder(
              future: API.bokingid(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: loadsearch(),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  final data = snapshot.data!.dataBooking;

                  if (data != null && data.isNotEmpty) {
                    return InkWell(
                        onTap: () => showSearch(
                          context: context,
                          delegate: SearchPage<DataBooking>(
                            items: data,
                            searchLabel: 'Cari Booking',
                            searchStyle: GoogleFonts.nunito(color: Colors.black),
                            showItemsOnEmpty: true,
                            failure: Center(
                              child: Text(
                                'Booking Tidak Ditemukan :(',
                                style: GoogleFonts.nunito(),
                              ),
                            ),
                            filter: (booking) => [
                              booking.nama,
                              booking.noPolisi,
                              booking.bookingStatus,
                              booking.namaMerk,
                              booking.alamat,
                              booking.bookingStatus,
                              booking.namaService,
                              booking.namaCabang,
                              booking.jamBooking,
                              booking.kodeKendaraan,
                              booking.namaTipe,
                              booking.vinNumber,
                              booking.transmisi,
                            ],
                            builder: (booking) => BokingList(
                              items: booking,
                              onTap: () {
                                handleBookingTap(booking);
                              },
                            ),
                          ),
                        ),
                        child: Container(
                            padding: EdgeInsets.all(5),
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
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search_rounded,
                                  color: MyColors.appPrimaryColor,
                                ),
                                SizedBox(width: 10,),
                                Text('Pencarian')
                              ],
                            )
                        )
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Pencarian',
                        style: GoogleFonts.nunito(fontSize: 16),
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: loadsearch(),
                  );
                }
              },
            ),
            const SizedBox(width: 20)
          ],
          bottom: TabBar(
            isScrollable: true,
            labelColor:
            MyColors.appPrimaryColor, // Change label color as needed
            unselectedLabelColor:
            Colors.grey, // Change unselected label color as needed
            indicatorColor: MyColors.appPrimaryColor,
            tabs: const [
              Tab(text: 'Semua'),
              Tab(text: 'Booking'),
              Tab(text: 'Approve'),
              Tab(text: 'Diproses'),
              Tab(text: 'Estimasi'),
              Tab(text: 'PKB'),
              Tab(text: 'PKB tutup'),
              Tab(text: 'Selesai Dikerjakan'),
              Tab(text: 'Invoice'),
              Tab(text: 'Lunas'),
              Tab(text: 'Ditolak'),
              Tab(text: 'Cancel Booking'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent(null),
            _buildTabContent('booking'),

            _buildTabContent('approve'),
            _buildTabContent('diproses'),
            _buildTabContent('estimasi'),
            _buildTabContent('pkb'),
            _buildTabContent('pkb tutup'),
            _buildTabContent('selesai dikerjakan'),
            _buildTabContent('invoice'),
            _buildTabContent('lunas'),
            _buildTabContent('ditolak'),
            _buildTabContent('cancel booking'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String? status) {
    DataBooking? selectedData;
    return SmartRefresher(
      controller: _refreshControllers[_getStatusIndex(status)],
      enablePullDown: true,
      header: const WaterDropHeader(),
      onRefresh: () => _onRefresh(status),
      onLoading: () => _onLoading(status),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<Boking>(
              future: API.bokingid(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SingleChildScrollView(
                    child: Loadingshammer(),
                  );
                } else if (snapshot.hasError) {
                  return SingleChildScrollView(
                    child: Loadingshammer(),
                  );
                } else if (snapshot.hasData) {
                  Boking getDataAcc = snapshot.data!;
                  if (getDataAcc.status == false) {
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
                            'Belum ada data Booking',
                            style: TextStyle(
                                color: MyColors.appPrimaryColor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    );
                  } else if (getDataAcc.message == 'Invalid token: Expired') {
                    Get.offAllNamed(Routes.SIGNIN);
                    return const SizedBox.shrink();
                  }

                  // Filter data berdasarkan status
                  List<DataBooking> filteredList = status != null
                      ? getDataAcc.dataBooking!
                      .where((item) => item.bookingStatus!.toLowerCase() == status)
                      .toList()
                      : getDataAcc.dataBooking!;

                  // Sort data berdasarkan tgl_booking dan jam_booking dari terbaru ke terlama
                  filteredList.sort((a, b) {
                    DateTime? aDateTime;
                    DateTime? bDateTime;

                    try {
                      aDateTime = DateTime.parse('${a.tglBooking} ${a.jamBooking}');
                    } catch (e) {
                      aDateTime = null;
                    }

                    try {
                      bDateTime = DateTime.parse('${b.tglBooking} ${b.jamBooking}');
                    } catch (e) {
                      bDateTime = null;
                    }

                    // Handle cases where parsing fails
                    if (aDateTime == null && bDateTime == null) {
                      return 0;
                    } else if (aDateTime == null) {
                      return 1;
                    } else if (bDateTime == null) {
                      return -1;
                    } else {
                      return bDateTime.compareTo(aDateTime);
                    }
                  });

                  if (filteredList.isEmpty) {
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
                            'Belum ada data Booking',
                            style: TextStyle(
                                color: MyColors.appPrimaryColor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    );
                  }
                  return Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 475),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: filteredList.map(
                            (e) => BokingList(
                          items: e,
                                onTap: () async {
                                  HapticFeedback.lightImpact();
                                  if (kDebugMode) {
                                    print('Nilai e.namaService: ${e.namaService ?? ''}');
                                  }

                                  if (e.bookingStatus != null && e.namaService != null) {
                                    String kategoriKendaraanId = '';
                                    final generalData = await API.kategoriID();
                                    if (generalData != null) {
                                      final matchingKategori = generalData.dataKategoriKendaraan?.firstWhere(
                                            (kategori) => kategori.kategoriKendaraan == e.kategoriKendaraan,
                                        orElse: () => DataKategoriKendaraan(kategoriKendaraanId: '', kategoriKendaraan: ''),
                                      );

                                      if (matchingKategori != null && matchingKategori is DataKategoriKendaraan) {
                                        kategoriKendaraanId = matchingKategori.kategoriKendaraanId ?? '';
                                      }
                                    }

                                    final arguments = {
                                      'tgl_booking': e.tglBooking ?? '',
                                      'jam_booking': e.jamBooking ?? '',
                                      'nama': e.nama ?? '',
                                      'kode_kendaraan': e.kodeKendaraan ?? '',
                                      'kode_pelanggan': e.kodePelanggan ?? '',
                                      'kode_booking': e.kodeBooking ?? '',
                                      'nama_jenissvc': e.namaService ?? '',
                                      'no_polisi': e.noPolisi ?? '',
                                      'tahun': e.tahun ?? '',
                                      'keluhan': e.keluhan ?? '',
                                      'pm_opt': e.pmopt ?? '',
                                      'type_order': e.typeOrder ?? '',
                                      'kategori_kendaraan': e.kategoriKendaraan ?? '',
                                      'kategori_kendaraan_id': kategoriKendaraanId,
                                      'warna': e.warna ?? '',
                                      'hp': e.hp ?? '',
                                      'vin_number': e.vinNumber ?? '',
                                      'nama_merk': e.namaMerk ?? '',
                                      'transmisi': e.transmisi ?? '',
                                      'nama_tipe': e.namaTipe ?? '',
                                      'alamat': e.alamat ?? '',
                                      'booking_id': e.bookingId ?? '',
                                      'status': e.bookingStatus ?? '',
                                    };

                                    if (e.bookingStatus!.toLowerCase() == 'booking') {
                                      Get.toNamed(Routes.APPROVE, arguments: arguments);
                                    } else if (e.bookingStatus!.toLowerCase() == 'approve') {
                                      if (e.typeOrder != null && e.typeOrder!.toLowerCase() == 'emergency service') {
                                        arguments['location'] = e.location ?? '';
                                        arguments['location_name'] = e.locationname ?? '';
                                        Get.toNamed(Routes.EmergencyView, arguments: arguments);
                                      } else {
                                        if (e.namaService!.toLowerCase() == 'repair & maintenance') {
                                          Get.toNamed(Routes.REPAIR_MAINTENEN, arguments: arguments);
                                        } else if (e.namaService!.toLowerCase() == 'periodical maintenance') {
                                          Get.toNamed(Routes.StarStopProdical, arguments: arguments);
                                        } else if (e.namaService!.toLowerCase() == 'tire/ ban') {
                                          Get.toNamed(Routes.REPAIR_MAINTENEN, arguments: arguments);
                                        } else if (e.namaService!.toLowerCase() == 'general check up/p2h') {
                                          Get.toNamed(Routes.GENERAL_CHECKUP, arguments: arguments);
                                        }
                                      }
                                    } else if (e.bookingStatus!.toLowerCase() == 'diproses') {
                                      if (e.namaService!.toLowerCase() == 'general check up/p2h') {
                                        Get.toNamed(Routes.GENERAL_CHECKUP, arguments: arguments);
                                      } else if (e.namaService!.toLowerCase() == 'periodical maintenance') {
                                        Get.toNamed(Routes.StarStopProdical,
                                          arguments: {
                                            'tgl_booking': e.tglBooking ?? '',
                                            'booking_id': e.bookingId.toString(),
                                            'jam_booking': e.jamBooking ?? '',
                                            'nama': e.nama ?? '',
                                            'kode_booking': e.kodeBooking ?? '',
                                            'kode_kendaraan': e.kodeKendaraan ?? '',
                                            'kode_pelanggan': e.kodePelanggan ?? '',
                                            'nama_jenissvc': e.namaService ?? '',
                                            'no_polisi': e.noPolisi ?? '',
                                            'tahun': e.tahun ?? '',
                                            'keluhan': e.keluhan ?? '',
                                            'kategori_kendaraan': e.kategoriKendaraan ?? '',
                                            'kategori_kendaraan_id': kategoriKendaraanId,
                                            'warna': e.warna ?? '',
                                            'ho': e.hp ?? '',
                                            'pm_opt': e.pmopt ?? '',
                                            'vin_number': e.vinNumber ?? '',
                                            'kode_booking': e.kodeBooking ?? '',
                                            'nama_merk': e.namaMerk ?? '',
                                            'transmisi': e.transmisi ?? '',
                                            'nama_tipe': e.namaTipe ?? '',
                                            'alamat': e.alamat ?? '',
                                            'status': e.bookingStatus ?? '',
                                          },
                                        );
                                      } else {
                                        // handle other namaService cases if needed
                                      }
                                    } else {
                                      Get.toNamed(
                                        Routes.DetailBooking,
                                        arguments: arguments,
                                      );
                                    }
                                  } else {
                                    print('Booking status atau namaService bernilai null');
                                  }
                                }
                            ),
                      ).toList(),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('No data'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onLoading(String? status) {
    _refreshControllers[_getStatusIndex(status)].loadComplete();
  }

  void _onRefresh(String? status) {
    HapticFeedback.lightImpact();
    API.bokingid();
    widget.clearCachedBoking();
    _refreshControllers[_getStatusIndex(status)].refreshCompleted();
  }

  int _getStatusIndex(String? status) {
    switch (status) {
      case 'booking':
        return 1;
      case 'approve':
        return 2;
      case 'diproses':
        return 3;
      case 'estimasi':
        return 4;
      case 'selesai dikerjakan':
        return 5;
      case 'pkb':
        return 6;
      case 'pkb tutup':
        return 7;
      case 'invoice':
        return 8;
      case 'lunas':
        return 9;
      case 'ditolak':
        return 10;
      default:
        return 0; // Semua
    }
  }
}
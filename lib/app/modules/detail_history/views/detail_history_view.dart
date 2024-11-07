import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mekanik/app/componen/color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../data/data_endpoint/detailhistory.dart';
import '../../../data/endpoint.dart';

class DetailHistoryView extends StatefulWidget {
  const DetailHistoryView({super.key});

  @override
  State<DetailHistoryView> createState() => _DetailHistoryViewState();
}

class _DetailHistoryViewState extends State<DetailHistoryView> {
  late RefreshController _refreshController;
  @override
  void initState() {
    _refreshController =
        RefreshController(); // we have to use initState because this part of the app have to restart
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
    Get.arguments as Map<String, dynamic>?;
    final String kodeSvc = arguments?['kode_svc'] ?? '';
    print(arguments);

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        title: Text('Detail', style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.appPrimaryColor)),
        centerTitle: false,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: const WaterDropHeader(),
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child:
        SingleChildScrollView(
          child: FutureBuilder<DetailHistory>(
            future: API.DetailhistoryID(kodesvc: kodeSvc),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final dataSvc = snapshot.data!.dataSvc;
                final dataSvcDtlJasa = snapshot.data!.dataSvcDtlJasa;
                return
                  Container(
                      width: double.infinity,
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
                            Text('${dataSvc?.tipeSvc}', style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.appPrimaryColor, fontSize: 15),),
                            Container(
                                width: double.infinity,
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
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const Text('Tanggal & Jam Estimasi :'),
                                                Text('${dataSvc?.tglEstimasi}', style: const TextStyle(fontWeight: FontWeight.bold),),
                                              ]),
                                          Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const Text('Jam Selesai'),
                                                Text('${dataSvc?.jamSelesai??'-'}', style: const TextStyle(fontWeight: FontWeight.bold),),
                                              ]),
                                        ],),
                                    ])),
                            const SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Cabang'),
                                      Text('${dataSvc?.namaCabang}', style: const TextStyle(fontWeight: FontWeight.bold,),),
                                    ]),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Text('Kode Estimasi'),
                                      Text('${dataSvc?.kodeEstimasi}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),),
                                    ]),
                              ],),
                            const SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Tipe Pelanggan :'),
                                      Text('${dataSvc?.tipePelanggan??'-'}', style: const TextStyle(fontWeight: FontWeight.bold,),),
                                    ]),
                              ],),
                            const Divider(color: Colors.grey,),
                            const SizedBox(height: 10,),
                            Text('Detail Pelanggan', style: TextStyle(fontWeight: FontWeight.bold,color: MyColors.appPrimaryColor),),
                            const SizedBox(height: 10,),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Nama :'),
                                  Text('${dataSvc?.nama}', style: const TextStyle(fontWeight: FontWeight.bold,),),
                                  const SizedBox(height: 5,),
                                  const Text('No Handphone :'),
                                  Text('${dataSvc?.hp}', style: const TextStyle(fontWeight: FontWeight.bold,),),
                                  const SizedBox(height: 5,),
                                  const Text('Alamat :'),
                                  Text('${dataSvc?.alamat}', style: const TextStyle(fontWeight: FontWeight.bold,),),
                                ]),
                            const Divider(color: Colors.grey,),
                            const SizedBox(height: 10,),
                            Text('Kendaraan Pelanggan', style: TextStyle(fontWeight: FontWeight.bold,color: MyColors.appPrimaryColor),),
                            const SizedBox(height: 10,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Merk :'),
                                      Text('${dataSvc?.namaMerk}', style: const TextStyle(fontWeight: FontWeight.bold,),),
                                    ]),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text('Tipe :'),
                                      Text('${dataSvc?.namaTipe}', style: const TextStyle(fontWeight: FontWeight.bold,),),
                                    ]),
                              ],),
                            const SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Tahun :'),
                                      Text('${dataSvc?.tahun}', style: const TextStyle(fontWeight: FontWeight.bold,),),
                                    ]),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text('Warna :'),
                                      Text('${dataSvc?.warna}', style: const TextStyle(fontWeight: FontWeight.bold,),),
                                    ]),
                              ],),
                            const SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Kategori Kendaraan :'),
                                      Text('${dataSvc?.kategoriKendaraan}', style: const TextStyle(fontWeight: FontWeight.bold,),),
                                    ]),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text('Transmisi :'),
                                      Text('${dataSvc?.transmisi}', style: const TextStyle(fontWeight: FontWeight.bold,),),
                                    ]),
                              ],),
                            const SizedBox(height: 5,),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('No Polisi :'),
                                  Text('${dataSvc?.noPolisi}', style: const TextStyle(fontWeight: FontWeight.bold,),),
                                ]),
                            const SizedBox(height: 5,),
                            const Divider(color: Colors.grey,),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Keluhan :', style: const TextStyle(fontWeight: FontWeight.bold,),),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        border: Border.all(color: Colors.grey)
                                    ),
                                    child:  Text('${dataSvc?.keluhan?? '-'}', style: const TextStyle(fontWeight: FontWeight.normal,),),)


                                ]),
                            const Divider(color: Colors.grey,),
                            const SizedBox(height: 10,),
                            Text('Paket', style: TextStyle(fontWeight: FontWeight.bold,color: MyColors.appPrimaryColor),),
                      FutureBuilder<DetailHistory>(
                        future: API.DetailhistoryID(kodesvc: kodeSvc),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            final dataSvcDtlJasa = snapshot.data!.dataSvcDtlJasa;
                            return Column(
                              children: [
                                for (var jasa in dataSvcDtlJasa ?? [])
                                  Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Nama Jasa :'),
                                                Text(
                                                  '${jasa.namaJasa}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              const Text('Harga :'),
                                              Text(
                                                '${formatCurrency(jasa.hargaJasa).toString()}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              const Text('Diskon :'),
                                              Text(
                                                '${formatCurrency(jasa.diskonJasa)}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Divider(color: Colors.grey),
                                      const SizedBox(height: 10),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'TOTAL',
                                                style: TextStyle(
                                                  color: MyColors.appPrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '${formatCurrency(jasa.biaya)}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Divider(color: Colors.transparent),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                              ],
                            );
                          } else {
                            return const Center(child: Text('No data available'));
                          }
                        },
                      ),
                      ]));
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
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
  _onLoading() {
    _refreshController
        .loadComplete(); // after data returned,set the //footer state to idle
  }

  _onRefresh() {
    HapticFeedback.lightImpact();
    setState(() {
// so whatever you want to refresh it must be inside the setState
      const DetailHistoryView(); // if you only want to refresh the list you can place this, so the two can be inside setState
      _refreshController
          .refreshCompleted(); // request complete,the header will enter complete state,
// resetFooterState : it will set the footer state from noData to idle
    });
  }
}

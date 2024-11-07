import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mekanik/app/routes/app_pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../componen/color.dart';
import '../../../../data/data_endpoint/mekanikp2h.dart';
import '../../../../data/data_endpoint/mekanikpromekid.dart';
import '../../../../data/data_endpoint/proses_promax.dart';
import '../../../../data/data_endpoint/prosesspromaxpkb.dart';
import '../../../../data/endpoint.dart';
import '../../controllers/general_checkup_controller.dart';


class StarStopProdical extends StatefulWidget {
  const StarStopProdical({Key? key});

  @override
  State<StarStopProdical> createState() => _StarStopProdicalState();
}

class _StarStopProdicalState extends State<StarStopProdical> with AutomaticKeepAliveClientMixin<StarStopProdical> {
  String? selectedItemJasa;
  String? selectedItemKodeJasa;
  Mekanik? selectedMechanic;
  bool showDetails = false;
  TextEditingController textFieldController = TextEditingController();
  Map<String, String> selectedItems = {};
  Map<String, bool> isStartedMap = {};
  Map<String, TextEditingController> additionalInputControllers = {};
  final GeneralCheckupController controller = Get.put(GeneralCheckupController     ());
  Map<String, List<DataPromek>> historyData = {};
  Timer? _timer;
  late Map args;
  List<String> idmekanikList = [];
  bool isLayoutVisible = true;
  late RefreshController _refreshController;
  String? kodeBooking;
  int? BookingId;
  String? nama;
  late String pmopt;
  String? nama_jenissvc;
  String? kategoriKendaraanId;
  String? kendaraan;

  String? nama_tipe;
  @override
  void initState() {
    super.initState();
    args = Get.arguments;
    kodeBooking = args['kode_booking'];
    BookingId = int.tryParse(args['booking_id'].toString());
    nama = args['nama'];
    pmopt = args['pm_opt'] ?? '';
    kategoriKendaraanId = args['kategori_kendaraan_id'] ?? '';
    kendaraan = args['kategori_kendaraan'];
    nama_jenissvc = args['nama_jenissvc'];
    nama_tipe = args['nama_tipe'];

    _refreshController = RefreshController();
    additionalInputControllers.values.forEach((controller) => controller.dispose());
    _timer?.cancel();

    controller.setInitialValues(args);
    _loadSelectedMechanics();
  }


  @override
  bool get wantKeepAlive => true;

  Future<void> fetchPromekData(String kodejasa, String idmekanik, String id) async {
    try {
      var response = await API.PromekProsesID(
          kodebooking: args['kode_booking'] ?? '',
          kodejasa: kodejasa,
          idmekanik: idmekanik
      );
      if (response.status == 200) {
        setState(() {
          historyData[idmekanik] = response.dataPromek ?? [];
        });
      }
    } catch (e) {
      print('Error fetching promek data: $e');
    }
  }

  Future<void> _saveSelectedMechanic(String id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ids = prefs.getStringList('selectedMechanicIds') ?? [];
    if (!ids.contains(id)) {
      ids.add(id);
      await prefs.setStringList('selectedMechanicIds', ids);
      setState(() {
        idmekanikList = ids;
      });
    }
  }

  Future<void> _loadSelectedMechanics() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? ids = prefs.getStringList('selectedMechanicIds');
    if (ids != null) {
      setState(() {
        idmekanikList = ids;
      });
      for (String id in ids) {
        await fetchPromekData(args['kode_svc'] ?? '', selectedItemKodeJasa ?? '', id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        title: Text(
          nama_jenissvc ??"",
          style: TextStyle(color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body:  SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: const WaterDropHeader(),
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child:
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: FutureBuilder<MekanikP2H>(
                  future: API.MekanikID(
                      kodebooking: args['kode_booking'] ?? ''
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final jasaList = snapshot.data?.jasaPromek?.jasa ?? [];
                      final mechanics = snapshot.data?.jasaPromek?.mekanik ?? [];
                      if (jasaList.isEmpty) {
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
                                'Belum ada Jasa',
                                style: TextStyle(
                                    color: MyColors.appPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Pilih Jasa', style: TextStyle(fontWeight: FontWeight.bold)),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: jasaList.length,
                            itemBuilder: (context, index) {
                              final jasa = jasaList[index];
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedItemJasa = jasa.namaJasa;
                                    selectedItemKodeJasa = jasa.kodeJasa;
                                    showDetails = true;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.15),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    color: selectedItemKodeJasa == jasa.kodeJasa ? MyColors.appPrimaryColor : Colors.white,
                                    border: Border.all(
                                      color: selectedItemKodeJasa == jasa.kodeJasa ? MyColors.appPrimaryColor : Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    jasa.namaJasa ?? '',
                                    style: TextStyle(
                                      color: selectedItemKodeJasa == jasa.kodeJasa ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          if (showDetails) ...[
                            const SizedBox(height: 10),
                            const Text('Pilih Mekanik', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Container(
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
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton<String>(
                                    value: selectedMechanic?.id.toString(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedMechanic = mechanics.firstWhere((mechanic) => mechanic.id.toString() == newValue) as Mekanik?;
                                        textFieldController.text = newValue ?? '';
                                      });
                                    },
                                    items: mechanics.map<DropdownMenuItem<String>>((mechanic) {
                                      return DropdownMenuItem<String>(
                                        value: mechanic.id.toString(),
                                        child: Text(mechanic.nama ?? ''),
                                      );
                                    }).toList(),
                                    isExpanded: true,
                                    hint: selectedMechanic == null
                                        ? const Text("Mekanik belum dipilih", style: TextStyle(color: Colors.grey))
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                if (selectedMechanic != null) {
                                  String kodejasa = selectedItemKodeJasa ?? '';
                                  String kodesvc = args['kode_svc'] ?? '';
                                  String idmekanik = selectedMechanic!.id.toString();
                                  await _saveSelectedMechanic(idmekanik);
                                  await fetchPromekData(kodesvc, kodejasa, idmekanik);
                                  setState(() {
                                    final mechanicId = selectedMechanic!.id.toString();
                                    final mechanicName = selectedMechanic!.nama!;
                                    selectedItems[mechanicId] = mechanicName;
                                    isStartedMap[mechanicName] = false;
                                    additionalInputControllers[mechanicName] = TextEditingController();
                                    mechanics.removeWhere((mechanic) => mechanic.id.toString() == mechanicId);
                                    selectedMechanic = null;
                                  });
                                } else {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.warning,
                                    title: 'Pilih Mekanik',
                                    text: 'Silakan pilih mekanik terlebih dahulu.',
                                    confirmBtnText: 'Oke',
                                    confirmBtnColor: Colors.green,
                                  );
                                }
                              },
                              child: const Text('Tambah', style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 10,),
                            if (showDetails)
                              const Text('Mekanik yang dipilih', style: TextStyle(fontWeight: FontWeight.bold)),
                            ...selectedItems.keys.map((item) => buildMechanicCard(item)).toList(),
                          ]
                        ],
                      );
                    }
                  },
                ),
              ),
              if (showDetails)
                Column(
                  children: idmekanikList.map((id) {
                    if (!additionalInputControllers.containsKey(id)) {
                      additionalInputControllers[id] = TextEditingController();
                    }
                    return FutureBuilder(
                      future: API.PromekProsesID(
                          kodebooking: args['kode_booking'] ?? '',
                          kodejasa: selectedItemKodeJasa ?? '',
                          idmekanik: id
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox();
                        } else if (snapshot.hasData && snapshot.data != null) {
                          PromekProses getDataAcc = snapshot.data ?? PromekProses();
                          List<DataPromek> prosesList = getDataAcc.dataPromek ?? [];

                          if (prosesList.isEmpty) {
                            return SizedBox(height: 10);
                          }

                          DataPromek specificItem = prosesList[0];
                          bool isStopped = specificItem.stopPromek == null || specificItem.stopPromek == 'N/A';
                          String promekId = specificItem.promekId.toString();

                          return Column(children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: EdgeInsets.only(right: 20, left: 20, bottom: 5),
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
                                  HistoryPKBStartStart(items: specificItem),
                                  ...prosesList.map((e) {
                                    return HistoryPKBStartStopDetails(items: e);
                                  }).toList(),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: !isStopped
                                        ? SizedBox()
                                        : TextField(
                                      controller: additionalInputControllers[id],
                                      decoration: const InputDecoration(
                                        labelText: 'Isi keterangan tambahan',
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        String role = isStopped ? 'stop' : 'start';
                                        String kodejasa = selectedItemKodeJasa ?? '';
                                        String idmekanik = id;
                                        String kodebooking = args['kode_booking'] ?? '';
                                        String keterangan = additionalInputControllers[id]?.text ?? '';

                                        print("Sending data to API:");
                                        print("kodebooking: $kodebooking, kodejasa: $kodejasa, idmekanik: $id, keterangan: $keterangan");

                                        if (isStopped && keterangan.isEmpty) {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.warning,
                                            title: 'Warning !!',
                                            text: 'Keterangan tambahan tidak boleh kosong.',
                                            confirmBtnText: 'Oke',
                                            confirmBtnColor: Colors.orange,
                                          );
                                          return;
                                        }

                                        try {
                                          if (isStopped) {
                                            var updateResponse = await API.updateketeranganID(
                                              promekid: promekId,
                                              keteranganpromek: keterangan,
                                            );
                                            if (updateResponse.status != 200) {}
                                          }
                                          var response = await API.promekID(
                                            role: role,
                                            kodebooking: args['kode_booking'] ?? '',
                                            kodejasa: kodejasa,
                                            idmekanik: idmekanik,
                                          );
                                          Get.toNamed(
                                            Routes.ListPeriodical,
                                            arguments: {
                                              'booking_id': BookingId.toString(),
                                              'kode_booking': kodeBooking,
                                              'nama': nama,
                                              'pm_opt': pmopt,
                                              'id_mekanik': idmekanik,
                                              'kategori_kendaraan_id': kategoriKendaraanId,
                                              'kategori_kendaraan': kendaraan,
                                              'nama_jenissvc': nama_jenissvc,
                                              'nama_tipe': nama_tipe,
                                            },
                                          );
                                          if (response.status == 200) {
                                            setState(() {
                                              isStopped = !isStopped;
                                              isStartedMap[id] = !isStopped;
                                              if (!isStopped) {
                                                additionalInputControllers[id]?.clear();
                                              }
                                            });
                                            await fetchPromekData(kodebooking, kodejasa, idmekanik);
                                          } else {
                                            HapticFeedback.lightImpact();
                                            setState(() {
                                              const StarStopProdical();
                                              _refreshController.refreshCompleted();
                                            });
                                          }
                                        } catch (e) {
                                          HapticFeedback.lightImpact();
                                          setState(() {
                                            const StarStopProdical();
                                            _refreshController.refreshCompleted();
                                          });
                                        }
                                      },
                                      child: Text(isStopped ? 'Stop' : 'Start'),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: isStopped ? Colors.red : Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                String idmekanik = id;
                                Get.toNamed(
                                  Routes.ListPeriodical,
                                  arguments: {
                                    'booking_id': BookingId.toString(),
                                    'kode_booking': kodeBooking,
                                    'nama': nama,
                                    'pm_opt': pmopt,
                                    'id_mekanik': idmekanik,
                                    'kategori_kendaraan_id': kategoriKendaraanId,
                                    'kategori_kendaraan': kendaraan,
                                    'nama_jenissvc': nama_jenissvc,
                                    'nama_tipe': nama_tipe,
                                  },
                                );
                              },
                              child: Text('Cek General Check Up'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: MyColors.appPrimaryColor,
                              ),
                            ),
                          ],
                          );
                        } else {
                          return Center(
                            child: Text("Error loading data"),
                          );
                        }
                      },
                    );

                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMechanicCard(String id) {
    return Column(children: [
      FutureBuilder(
        future: API.PromekProsesID(
          kodebooking: args['kode_booking'] ?? '',
          kodejasa: selectedItemKodeJasa ?? '',
          idmekanik: id,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            PromekProses getDataAcc = snapshot.data ?? PromekProses();
            bool isStopped = getDataAcc.dataPromek!.any((proses) => proses.stopPromek == null || proses.stopPromek == 'N/A');
            return Column(children: [ if (isLayoutVisible)
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 5),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    Text(selectedItems[id] ?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10),
                    const Text('History :', style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    if (isStartedMap[id] == true)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: TextField(
                          controller: additionalInputControllers[id],
                          decoration: const InputDecoration(
                            labelText: 'Isi keterangan tambahan',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            additionalInputControllers[id]?.text = value;
                          },
                        ),
                      ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (!selectedItems.containsKey(id)) {
                          QuickAlert.show(
                            context: Get.context!,
                            type: QuickAlertType.warning,
                            title: 'Penting !!',
                            text: 'Pilih mekanik terlebih dahulu',
                            confirmBtnText: 'Oke',
                            confirmBtnColor: Colors.green,
                          );
                          return;
                        }
                        bool isStop = isStartedMap[id] ?? false;
                        if (isStop && additionalInputControllers[id]?.text.isEmpty == true) {
                          QuickAlert.show(
                            context: Get.context!,
                            type: QuickAlertType.warning,
                            title: 'Penting !!',
                            text: 'Isi keterangan terlebih dahulu sebelum menghentikan',
                            confirmBtnText: 'Oke',
                            confirmBtnColor: Colors.green,
                          );
                          return;
                        }
                        String role = isStop ? 'stop' : 'start';
                        String kodejasa = selectedItemKodeJasa ?? '';
                        String idmekanik = id;
                        String kodebooking = args['kode_booking'] ?? '';

                        try {
                          var response = await API.promekID(
                            role: role,
                            kodebooking: kodebooking,
                            kodejasa: kodejasa,
                            idmekanik: idmekanik,

                          );
                          Get.toNamed(
                            Routes.ListPeriodical,
                            arguments: {
                              'booking_id': BookingId.toString(),
                              'kode_booking': kodeBooking,
                              'nama': nama,
                              'pm_opt': pmopt,
                              'id_mekanik': idmekanik,
                              'kategori_kendaraan_id': kategoriKendaraanId,
                              'kategori_kendaraan': kendaraan,
                              'nama_jenissvc': nama_jenissvc,
                              'nama_tipe': nama_tipe,
                            },
                          );
                          if (response.status == 200) {
                            setState(() {
                              isStartedMap[id] = !isStop;
                              isLayoutVisible = false;
                            });
                            await fetchPromekData(kodebooking, kodejasa, idmekanik);
                            if (isStop) {
                              await API.updateketeranganPKBID(
                                kodesvc: args['kode_svc'] ?? '',
                                kodejasa:  selectedItemKodeJasa ?? '',
                                idmekanik: id,
                                keteranganpromek: additionalInputControllers[id]?.text ?? '',
                              );
                            } else {
                              await fetchPromekData(kodebooking, kodejasa, idmekanik);
                            }
                          } else {
                            HapticFeedback.lightImpact();
                            setState(() {
                              const StarStopProdical();
                              _refreshController.refreshCompleted();
                            });
                          }
                        } catch (e) {
                          HapticFeedback.lightImpact();
                          setState(() {
                            const StarStopProdical();
                            _refreshController.refreshCompleted();
                          });
                        }
                      },
                      child: Text(isStartedMap[id] == true ? 'Stop' : 'Start'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: isStartedMap[id] == true ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ]);
          } else {
            return Center(child: Text("Error loading data"));
          }
        },
      )
    ]);
  }
  _onLoading() {
    _refreshController.loadComplete();
  }

  _onRefresh() {
    HapticFeedback.lightImpact();
    setState(() {
      const StarStopProdical();
      _refreshController.refreshCompleted();
    });
  }

}

class HistoryPKBStartStart extends StatelessWidget {
  final DataPromek items;

  const HistoryPKBStartStart({Key? key, required this.items});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${items.nama ?? 'N/A'}', style: TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 10),
            const Text('History :', style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}

class HistoryPKBStartStopDetails extends StatelessWidget {
  final DataPromek items;

  const HistoryPKBStartStopDetails({Key? key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text('Start ',style: TextStyle(color: Colors.green),),
            Text('${items.startPromek ?? 'N/A'}',),
          ],),
          Row(children: [
            Text('Stop ',style: TextStyle(color: Colors.red),),
            Text('${items.stopPromek ?? 'N/A'}',),
          ],),
          Text('Keterangan: ${items.keterangan ?? 'kosong'}', style: TextStyle(color: Colors.black),),
          Divider()
        ],
      ),
    );
  }
}
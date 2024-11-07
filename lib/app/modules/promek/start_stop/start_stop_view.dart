import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../componen/color.dart';
import '../../../data/data_endpoint/mekanik_pkb.dart';
import '../../../data/data_endpoint/prosesspromaxpkb.dart';
import '../../../data/endpoint.dart';
import '../controllers/promek_controller.dart';

class StartStopView extends StatefulWidget {
  const StartStopView({Key? key});

  @override
  State<StartStopView> createState() => _StartStopViewState();
}

class _StartStopViewState extends State<StartStopView> with AutomaticKeepAliveClientMixin<StartStopView> {
  String? selectedItemJasa;
  String? selectedItemKodeJasa;
  Mekanikpkb? selectedMechanic;
  bool showDetails = false;
  TextEditingController textFieldController = TextEditingController();
  Map<String, String> selectedItems = {};
  Map<String, bool> isStartedMap = {};
  Map<String, TextEditingController> additionalInputControllers = {};
  final PromekController controller = Get.put(PromekController());
  Map<String, List<Proses>> historyData = {};
  Timer? _timer;
  late Map args;
  List<String> idmekanikList = [];
  bool isLayoutVisible = true;
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    additionalInputControllers.values.forEach((controller) => controller.dispose());
    _timer?.cancel();
    args = Get.arguments;
    controller.setInitialValues(args);
    _loadSelectedMechanics();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> fetchPromekData(String kodesvc, String kodejasa, String idmekanik) async {
    try {
      var response = await API.PromekProsesPKBID(
        kodesvc: kodesvc,
        kodejasa: kodejasa,
        idmekanik: idmekanik,
      );
      if (response.status == 200) {
        setState(() {
          historyData[idmekanik] = response.dataProsesMekanik?.proses ?? [];
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
          'Mekanik',
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
                child: FutureBuilder<MekanikPKB>(
                  future: API.MeknaikPKBID(kodesvc: args['kode_svc'] ?? ''),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final jasaList = snapshot.data?.dataJasaMekanik?.jasa ?? [];
                      final mechanics = snapshot.data?.dataJasaMekanik?.mekanik ?? [];
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
                                        selectedMechanic = mechanics.firstWhere((mechanic) => mechanic.id.toString() == newValue);
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
                                  isLayoutVisible = true;
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
                      future: API.PromekProsesPKBID(
                        kodesvc: args['kode_svc'] ?? '',
                        kodejasa: selectedItemKodeJasa ?? '',
                        idmekanik: id,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox();
                        } else if (snapshot.hasData && snapshot.data != null) {
                          ProsesPromex getDataAcc = snapshot.data ?? ProsesPromex();
                          List<Proses> prosesList = getDataAcc.dataProsesMekanik?.proses ?? [];

                          if (prosesList.isEmpty) {
                            return SizedBox(height: 10);
                          }

                          Proses specificItem = prosesList[0];  // Use the first item for displaying the mechanic name and history header
                          bool isStopped = specificItem.stopPromek == null || specificItem.stopPromek == 'N/A';

                          return
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
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
                                        String kodesvc = args['kode_svc'] ?? '';
                                        String keterangan = additionalInputControllers[id]?.text ?? '';

                                        print("Sending data to API:");
                                        print("kodesvc: $kodesvc, kodejasa: $kodejasa, idmekanik: $id, keterangan: $keterangan");

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
                                            var updateResponse = await API.updateketeranganPKBID(
                                              kodesvc: kodesvc,
                                              kodejasa: kodejasa,
                                              idmekanik: id,
                                              keteranganpromek: keterangan,
                                            );
                                            if (updateResponse.status != 200) {}
                                          }
                                          var response = await API.InsertPromexoPKBID(
                                            role: role,
                                            kodejasa: kodejasa,
                                            idmekanik: idmekanik,
                                            kodesvc: kodesvc,
                                          );
                                          if (response.status == 200) {
                                            setState(() {
                                              isStopped = !isStopped;
                                              isStartedMap[id] = !isStopped;
                                              if (!isStopped) {
                                                additionalInputControllers[id]?.clear();
                                              }
                                            });
                                            await fetchPromekData(kodesvc, kodejasa, idmekanik);
                                          } else {
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.error,
                                              title: 'Error !!',
                                              text: 'Gagal memperbarui status. Silakan coba lagi.',
                                              confirmBtnText: 'Oke',
                                              confirmBtnColor: Colors.red,
                                            );
                                          }
                                        } catch (e) {
                                          print("Error: $e");
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Error !!',
                                            text: 'Terjadi kesalahan. Silakan coba lagi.',
                                            confirmBtnText: 'Oke',
                                            confirmBtnColor: Colors.red,
                                          );
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
        future: API.PromekProsesPKBID(
          kodesvc: args['kode_svc'] ?? '',
          kodejasa: selectedItemKodeJasa ?? '',
          idmekanik: id,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            ProsesPromex getDataAcc = snapshot.data ?? ProsesPromex();
            bool isStopped = getDataAcc.dataProsesMekanik!.proses!.any((proses) => proses.stopPromek == null || proses.stopPromek == 'N/A');
            bool isStarted = isStartedMap[id] ?? false;

            return Column(children: [
              if (isLayoutVisible)
                isStarted ? buildStopContainer(id) : buildStartContainer(id),
            ]);
          } else {
            return Center(child: Text("Error loading data"));
          }
        },
      )
    ]);
  }

  Widget buildStartContainer(String id) {
    return Container(
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
          if (historyData.containsKey(id))
            const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () async {
              await handleMechanicAction(id, 'start');
            },
            child: const Text('Start'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStopContainer(String id) {
    return Container(
      height: 0,
        decoration: BoxDecoration(
        ),
        child: null);
  }

  Future<void> handleMechanicAction(String id, String role) async {
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

    bool isStop = role == 'stop';
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

    String kodejasa = selectedItemKodeJasa ?? '';
    String idmekanik = id;
    String kodesvc = args['kode_svc'] ?? '';

    try {
      var response = await API.InsertPromexoPKBID(
        role: role,
        kodejasa: kodejasa,
        idmekanik: idmekanik,
        kodesvc: kodesvc,
      );
      if (response.status == 200) {
        setState(() {
          isStartedMap[id] = !isStop;
          isLayoutVisible = false;
        });
        await fetchPromekData(kodesvc, kodejasa, idmekanik);
        if (isStop) {
          await API.updateketeranganPKBID(
            kodesvc: args['kode_svc'] ?? '',
            kodejasa: selectedItemKodeJasa ?? '',
            idmekanik: id,
            keteranganpromek: additionalInputControllers[id]?.text ?? '',
          );
        } else {
          await fetchPromekData(kodesvc, kodejasa, idmekanik);
        }
      } else {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          title: 'Error !!',
          text: 'Gagal memperbarui status. Silakan coba lagi.',
          confirmBtnText: 'Oke',
          confirmBtnColor: Colors.red,
        );
      }
    } catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Warning',
        text: 'Mekanik yang anda tambah kan sudah selesai mengerjakan jasa yang anda select',
        confirmBtnText: 'Oke',
        confirmBtnColor: Colors.red,
      );
    }
  }

  _onLoading() {
    _refreshController.loadComplete();
  }

  _onRefresh() {
    HapticFeedback.lightImpact();
    setState(() {
      const StartStopView();
      _refreshController.refreshCompleted();
    });
  }

}

class HistoryPKBStartStart extends StatelessWidget {
  final Proses items;

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
  final Proses items;

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
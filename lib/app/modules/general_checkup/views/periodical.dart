import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../componen/color.dart';
import '../../../data/data_endpoint/lisperiodical.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';

class PeriodicalList extends StatefulWidget {
  const PeriodicalList({
    Key? key,
  }) : super(key: key);

  @override
  _PeriodicalListState createState() => _PeriodicalListState();

  Widget buildGcuItem({
    required Gcus gcu,
    required String? dropdownValue,
    required TextEditingController deskripsiController,
    required ValueChanged<String?> onDropdownChanged,
    required ValueChanged<String?> onDescriptionChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GcuItem(
          gcu: gcu,
          dropdownValue: dropdownValue,
          deskripsiController: deskripsiController,
          onDropdownChanged: onDropdownChanged,
          onDescriptionChanged: onDescriptionChanged,
        ),
      ],
    );
  }
}

class _PeriodicalListState extends State<PeriodicalList>
    with TickerProviderStateMixin {

  late TabController _tabController;
  int currentStep = 0;
  bool isSubmitting = false;
  late String kodeBooking;
  late String BookingId;
  late String idmekanik;
  late String kategoriKendaraanId;
  late String pmopt;
  String? nama;
  String? namajenissvc;
  String? kendaraan;
  String? namatipe;
  List<Map<String, dynamic>> generalCheckupData = [];

  Map<int, String?> dropdownValues = {};
  late Map<int, TextEditingController> deskripsiControllers;
  late Map args;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    dropdownValues = {};
    deskripsiControllers = {};
    args = Get.arguments;
    kodeBooking = args?['kode_booking'];
    BookingId = args?['booking_id'] ?? '';
    pmopt = args?['pm_opt'] ?? '';
    idmekanik = args?['id_mekanik'] ?? '';
    kategoriKendaraanId = args?['kategori_kendaraan_id'] ?? '';
    print('Booking ID: $BookingId');
    print('ID mekanik: $idmekanik');
    print('kategori_kendaraan_id : $kategoriKendaraanId');
    nama = args?['nama'];
    kategoriKendaraanId = args?['kategori_kendaraan_id'] ?? '';
    kendaraan = args?['kategori_kendaraan'];
    namajenissvc = args?['nama_jenissvc'];
    namatipe = args?['nama_tipe'];
  }

  @override
  void dispose() {
    _tabController.dispose();
    deskripsiControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  late DateTime? startTime;
  DateTime? stopTime;

  void startTimer() {
    setState(() {
      startTime = DateTime.now();
    });
  }

  void stopTimer() {
    setState(() {
      stopTime = DateTime.now();
    });
  }

  String getStartTime() {
    if (startTime != null) {
      return DateFormat('HH:mm').format(startTime!);
    } else {
      return 'Start';
    }
  }

  String getStopTime() {
    if (stopTime != null) {
      return DateFormat('HH:mm').format(stopTime!);
    } else {
      return 'Stop';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute
        .of(context)
        ?.settings
        .arguments as Map<String, dynamic>?;
    final String bookingId = args?['booking_id'] ?? '';
    final String kodeBooking = args?['kode_booking'];
    final String BookingId = args?['booking_id'] ?? '';
    final String idmekanik = args?['id_mekanik'] ?? '';
    final String kategoriKendaraanId = args?['kategori_kendaraan_id'] ?? '';
    final String nama = args?['nama'];
    final String pmopt = args?['pm_opt'];
    final String kendaraan = args?['kategori_kendaraan'];
    final String namajenissvc = args?['nama_jenissvc'];
    final String namatipe = args?['nama_tipe'];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          background: Colors.white,
          onBackground: Colors.white,
          primary: MyColors.appPrimaryColor,
          onPrimary: Colors.white,
        ),
      ),
      home: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.white,
          ),
          title: Container(
            child: Column(
              children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Edit ',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${namajenissvc??''}',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nama :',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          nama ?? '',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Kendaraan :',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          namatipe ?? '',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Jenis Service :',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          namajenissvc ?? '',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Kode Boking :',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          kodeBooking ?? '',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Get.toNamed(
                        Routes.StarStopProdical,
                        arguments: {
                          'booking_id': BookingId,
                          'kode_booking': kodeBooking,
                          'nama': nama,
                          'pm_opt': pmopt,
                          'kategori_kendaraan_id': kategoriKendaraanId,
                          'kategori_kendaraan': kendaraan,
                          'nama_jenissvc': namajenissvc,
                          'nama_tipe': namatipe,
                        },
                      );
                    },
                    child: const Text('Mekanik'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          toolbarHeight: 170,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () {
              QuickAlert.show(
                barrierDismissible: false,
                context: Get.context!,
                type: QuickAlertType.confirm,
                headerBackgroundColor: Colors.yellow,
                text: 'Anda Harus Selesaikan dahulu Periodical Maintenance untuk keluar dari Edit Periodical Maintenance',
                confirmBtnText: 'Kembali',
                title: 'Penting !!',
                cancelBtnText: 'Keluar',
                onCancelBtnTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                confirmBtnColor: Colors.green,
              );
            },
          ),
          centerTitle: false,
          actions: const [],
        ),
        body:FutureBuilder<ListPeriodical>(
          future: API.ListPeriodicalID(
              kategoriKendaraanId: kategoriKendaraanId, pmopt: pmopt),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.dataPeriodicalMaintenance!.isEmpty) {
              return Center(child: Text('No data available.'));
            }
            final data = snapshot.data!;
            final int stepsCount = data.dataPeriodicalMaintenance!.length;

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Stepper(
                    currentStep: currentStep,
                    physics: NeverScrollableScrollPhysics(),
                    onStepContinue: () {
                      submitForm(context).then((_) {
                        setState(() {
                          if (currentStep < stepsCount - 1) {
                            currentStep += 1;
                          } else {
                            _showConfirmationDialog();
                          }
                        });
                      });
                    },
                    steps: data.dataPeriodicalMaintenance!.map((periodical) {
                      return Step(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${periodical.subHeading}'),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: MyColors.appPrimaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  currentStep = data.dataPeriodicalMaintenance!.indexOf(periodical);
                                });
                              },
                              child: Text('Lihat'),
                            ),
                          ],
                        ),
                        content: Column(
                          children: [
                            ...?periodical.gcus?.map((gcu) {
                              final int? nullableGcuId = gcu.gcuId;
                              if (nullableGcuId != null) {
                                final int gcuId = nullableGcuId;
                                if (!deskripsiControllers.containsKey(gcuId)) {
                                  deskripsiControllers[gcuId] = TextEditingController();
                                }
                                return GcuItem(
                                  key: ValueKey(gcuId),
                                  gcu: gcu,
                                  dropdownValue: dropdownValues[gcuId],
                                  deskripsiController: deskripsiControllers[gcuId]!,
                                  onDropdownChanged: (value) {
                                    setState(() {
                                      dropdownValues[gcuId] = value;
                                      if (value == 'OK') {
                                        deskripsiControllers[gcuId]?.text = '';
                                      }
                                    });
                                  },
                                  onDescriptionChanged: (description) {},
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            }).toList(),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  Future<void> submitForm(BuildContext context) async {
    setState(() {
      isSubmitting = true;
    });

    try {
      final generalData = await API.ListPeriodicalID(
        kategoriKendaraanId: kategoriKendaraanId,
        pmopt: pmopt,
      );

      if (generalData.dataPeriodicalMaintenance != null) {
        final stepData = generalData.dataPeriodicalMaintenance![currentStep];
        if (stepData.gcus != null && stepData.gcus!.isNotEmpty) {
          final gcusList = stepData.gcus!.map<Map<String, dynamic>>(
                (gcu) => {
              "gcu_id": gcu.gcuId.toString(),
              "status": dropdownValues[gcu.gcuId] ?? '',
              "description": deskripsiControllers[gcu.gcuId]?.text ?? '',
            },
          ).toList();
          final generalCheckupObj = {
            "sub_heading_id": stepData.subHeadingId,
            "gcus": gcusList,
          };

          final combinedData = {
            "booking_id": BookingId,
            "pm_opt": pmopt,
            "id_mekanik": idmekanik,
            "general_checkup": [generalCheckupObj],
          };

          print('Data yang disubmit: $combinedData');

          final submitResponse = await API.submitPerodicalID(
            generalCheckup: combinedData,
          );

          print('Response dari server: $submitResponse');

          setState(() {
            isSubmitting = false;
          });

          // Periksa kode status dari respons API
          if (submitResponse.status == 200 || submitResponse.status == 2001) {
            QuickAlert.show(
              barrierDismissible: false,
              context: Get.context!,
              type: QuickAlertType.success,
              headerBackgroundColor: Colors.yellow,
              text: 'General CheckUp berhasil dibuat',
              confirmBtnText: 'Kembali',
              cancelBtnText: 'Kembali',
              confirmBtnColor: Colors.green,
            );
          } else {
            QuickAlert.show(
              barrierDismissible: false,
              context: Get.context!,
              type: QuickAlertType.error,
              headerBackgroundColor: Colors.red,
              text: 'Terjadi kesalahan: ${submitResponse.message}',
              confirmBtnText: 'Kembali',
              cancelBtnText: 'Kembali',
              confirmBtnColor: Colors.red,
            );
          }
        } else {
          setState(() {
            isSubmitting = false;
          });
          QuickAlert.show(
            barrierDismissible: false,
            context: Get.context!,
            type: QuickAlertType.info,
            headerBackgroundColor: Colors.yellow,
            text: 'Data Periodical Maintenance kosong',
            confirmBtnText: 'Kembali',
            cancelBtnText: 'Kembali',
            confirmBtnColor: Colors.green,
          );
        }
      } else {
        setState(() {
          isSubmitting = false;
        });
        QuickAlert.show(
          barrierDismissible: false,
          context: Get.context!,
          type: QuickAlertType.info,
          headerBackgroundColor: Colors.yellow,
          text: 'Data Periodical Maintenance kosong',
          confirmBtnText: 'Kembali',
          cancelBtnText: 'Kembali',
          confirmBtnColor: Colors.green,
        );
      }
    } catch (fetchError) {
      setState(() {
        isSubmitting = false;
      });
      QuickAlert.show(
        barrierDismissible: false,
        context: Get.context!,
        type: QuickAlertType.success,
        headerBackgroundColor: Colors.yellow,
        text: 'Data Periodical Maintenance berhasil disubmit',
        confirmBtnText: 'Kembali',
        cancelBtnText: 'Kembali',
        confirmBtnColor: Colors.green,
      );
    }
  }

  Widget buildStepContent(String title) {
    return Column(
      children: [
        FutureBuilder(
          future: API.ListPeriodicalID(
            kategoriKendaraanId: kategoriKendaraanId,
            pmopt: pmopt,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              final generalData = snapshot.data;
              final getDataAcc = generalData?.dataPeriodicalMaintenance
                  ?.where((e) => e.subHeading == title)
                  .toList();
              if (getDataAcc != null && getDataAcc.isNotEmpty) {
                return Column(
                  children: [
                    ...getDataAcc.expand((e) => e.gcus ?? []).map(
                          (gcus) {
                        final int gcuId = gcus.gcuId;
                        if (!deskripsiControllers.containsKey(gcuId)) {
                          deskripsiControllers[gcuId] = TextEditingController();
                        }
                        return GcuItem(
                          key: ValueKey(gcuId),
                          gcu: gcus,
                          dropdownValue: dropdownValues[gcuId],
                          deskripsiController: deskripsiControllers[gcuId]!,
                          onDropdownChanged: (value) {
                            setState(() {
                              dropdownValues[gcuId] = value;
                              if (value == 'Oke') {
                                deskripsiControllers[gcuId]?.text = '';
                              }
                            });
                          },
                          onDescriptionChanged: (description) {},
                        );
                      },
                    ).toList(),
                  ],
                );
              } else {
                return Center(
                  child: Text('No data available for $title'),
                );
              }
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ],
    );
  }
  void _showConfirmationDialog() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      text: 'Simpan data Periodical Maintenance ke database Demo Indonesia',
      confirmBtnText: 'Submit',
      cancelBtnText: 'Exit',
      title: 'Submit Periodical Maintenance',
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () async {
        Navigator.pop(context);
        await submitForm(context);
        Get.toNamed(Routes.PPRODICAL_STOP,
          arguments: {
            'booking_id': BookingId,
            'kode_booking': kodeBooking,
            'nama': nama,
            'pm_opt': pmopt,
            'kategori_kendaraan_id': kategoriKendaraanId,
            'kategori_kendaraan': kendaraan,
            'nama_jenissvc': namajenissvc,
            'nama_tipe': namatipe,
          },
        );
      },
    );
  }
}

class GcuItem extends StatefulWidget {
  final Gcus gcu;
  final String? dropdownValue;
  final TextEditingController deskripsiController;
  final ValueChanged<String?> onDropdownChanged;
  final ValueChanged<String?> onDescriptionChanged;

  const GcuItem({
    Key? key,
    required this.gcu,
    required this.dropdownValue,
    required this.deskripsiController,
    required this.onDropdownChanged,
    required this.onDescriptionChanged,
  }) : super(key: key);

  @override
  _GcuItemState createState() => _GcuItemState();
}

class _GcuItemState extends State<GcuItem> {
  late String? dropdownValueLocal;

  @override
  void initState() {
    super.initState();
    dropdownValueLocal = widget.dropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                widget.gcu.gcu ?? '',
                textAlign: TextAlign.start,
                softWrap: true,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: DropdownButton<String>(
                value: dropdownValueLocal,
                hint: dropdownValueLocal == '' ? const Text('Pilih') : null,
                onChanged: (String? value) {
                  setState(() {
                    dropdownValueLocal = value;
                  });
                  widget.onDropdownChanged(value);
                },
                items: <String>['', 'OK', 'NOT_OK'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        if (dropdownValueLocal == 'NOT_OK')
          TextField(
            onChanged: (text) {
              widget.onDescriptionChanged(text);
            },
            controller: widget.deskripsiController,
            decoration: const InputDecoration(
              hintText: 'Keterangan',
            ),
          ),
      ],
    );
  }
}



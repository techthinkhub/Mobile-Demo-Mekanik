import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../componen/color.dart';
import '../../../data/data_endpoint/gc_mekanik.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';

class MyStepperPage extends StatefulWidget {
  const MyStepperPage({
    Key? key,
  }) : super(key: key);

  @override
  _MyStepperPageState createState() => _MyStepperPageState();

  Widget buildGcuItem({
    required Gcus gcu,
    required String? dropdownValue,
    required TextEditingController deskripsiController,
    required Function(String?) onDropdownChanged,
    required Function(String?) onDescriptionChanged,
  }) {
    return Column(
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

class _MyStepperPageState extends State<MyStepperPage>
    with TickerProviderStateMixin {
  final List<String> stepTitles = [
    'Mesin',
    'Mesin',
    'Brake',
    'Accel',
    'Interior',
    'Exterior',
    'Bawah Kendaraan',
    'Stall Test',
  ];
  late TabController _tabController;
  int currentStep = 0;
  bool isSubmitting = false;
  late String kodeBooking;
  late String BookingId;
  late String idmekanik;
  late String kategoriKendaraanId;
  String? nama;
  String? nama_jenissvc;
  String? kendaraan;
  String? nama_tipe;


  late Map<int, String?> dropdownValues;
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
    idmekanik = args?['id_mekanik'] ?? '';
    kategoriKendaraanId = args?['kategori_kendaraan_id'] ?? '';
    print('Booking ID: $BookingId');
    print('ID mekanik: $idmekanik');
    print('kategori_kendaraan_id : $kategoriKendaraanId');
    nama = args?['nama'];
    kategoriKendaraanId = args?['kategori_kendaraan_id'] ?? '';
    kendaraan = args?['kategori_kendaraan'];
    nama_jenissvc = args?['nama_jenissvc'];
    nama_tipe = args?['nama_tipe'];
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
    final Map<String, dynamic>? args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String bookingId = args?['booking_id'] ?? '';
    final String kodeBooking = args?['kode_booking'];
    final String BookingId = args?['booking_id'] ?? '';
    final String idmekanik = args?['id_mekanik'] ?? '';
    final String kategoriKendaraanId = args?['kategori_kendaraan_id'] ?? '';
    final String nama = args?['nama'];
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Edit General Check UP/P2H',
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                                nama_tipe ?? '',
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Jenis Service :',
                                style: TextStyle(fontSize: 13),
                              ),
                              Text(
                                nama_jenissvc ?? '',
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
                            ]),
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
                          backgroundColor: Colors.blue, // foreground
                        ),
                        onPressed: () {
                          Get.toNamed(
                            Routes.GENERAL_CHECKUP,
                            arguments: {
                              'booking_id': BookingId,
                              'kode_booking': kodeBooking,
                              'nama': nama,
                              'kategori_kendaraan_id': kategoriKendaraanId,
                              'kategori_kendaraan': kendaraan,
                              'nama_jenissvc': nama_jenissvc,
                              'nama_tipe': nama_tipe,
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
                    text:
                    'Anda Harus Selesaikan dahulu General Check Up untuk keluar dari Edit General Check Up',
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Stepper(
                    currentStep: currentStep,
                    physics: NeverScrollableScrollPhysics(),
                    onStepContinue: () {
                      setState(() {
                        submitForm(context);
                        if (currentStep < stepTitles.length - 1) {
                          currentStep += 1;
                        } else {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.confirm,
                            text:
                            'Simpan data General Check Up ke database Demo Indonesia',
                            confirmBtnText: 'Submit',
                            cancelBtnText: 'Exit',
                            title: 'Submit General Check Up',
                            confirmBtnColor: Colors.green,
                            onConfirmBtnTap: () async {
                              try {
                                if (kDebugMode) {
                                  print('kode_booking: $bookingId');
                                }
                                QuickAlert.show(
                                  context: Get.context!,
                                  barrierDismissible: false,
                                  type: QuickAlertType.loading,
                                  headerBackgroundColor: Colors.yellow,
                                  text: 'General CheckUp...',
                                  confirmBtnText: '',
                                );
                                print('kodeBooking: $kodeBooking');
                                print('BookingId: $BookingId');
                                print('kategoriKendaraanId: $kategoriKendaraanId');
                                print('nama: $nama');
                                print('kendaraan: $kendaraan');
                                print('namajenissvc: $namajenissvc');
                                print('namatipe: $namatipe');
                                await API.submitGCFinishId(
                                    bookingId: bookingId);
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
                              } catch (e) {
                                Navigator.pop(context, true);
                                Get.toNamed(Routes.BOKING2);
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
                              }
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
                              Get.toNamed(Routes.GENERAL_CHECKUP_STOP,
                                arguments: {
                                  'booking_id': BookingId,
                                  'kode_booking': kodeBooking,
                                  'nama': nama,
                                  'kategori_kendaraan_id': kategoriKendaraanId,
                                  'kategori_kendaraan': kendaraan,
                                  'nama_jenissvc': nama_jenissvc,
                                  'nama_tipe': nama_tipe,
                                },
                              );
                            },
                          );
                        }
                      });
                    },
                    steps: [
                      Step(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Mesin'),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                MyColors.appPrimaryColor, // foreground
                              ),
                              onPressed: () {
                                setState(() {
                                  currentStep = 0;
                                });
                              },
                              child: Text('Lihat'),
                            ),
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: buildStepContent("Mesin"),
                        ),
                        isActive: currentStep >= 0,
                      ),
                      Step(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Brake'),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                MyColors.appPrimaryColor, // foreground
                              ),
                              onPressed: () {
                                setState(() {
                                  currentStep = 1;
                                });
                              },
                              child: Text('Lihat'),
                            ),
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: buildStepContent("Brake"),
                        ),
                        isActive: currentStep >= 1,
                      ),
                      Step(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Accel'),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                MyColors.appPrimaryColor, // foreground
                              ),
                              onPressed: () {
                                setState(() {
                                  currentStep = 2;
                                });
                              },
                              child: Text('Lihat'),
                            ),
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: buildStepContent("Accel"),
                        ),
                        isActive: currentStep >= 2,
                      ),
                      Step(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Interior'),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                MyColors.appPrimaryColor, // foreground
                              ),
                              onPressed: () {
                                setState(() {
                                  currentStep = 3;
                                });
                              },
                              child: Text('Lihat'),
                            ),
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: buildStepContent("Interior"),
                        ),
                        isActive: currentStep >= 3,
                      ),
                      Step(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Exterior'),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                MyColors.appPrimaryColor, // foreground
                              ),
                              onPressed: () {
                                setState(() {
                                  currentStep = 4;
                                });
                              },
                              child: Text('Lihat'),
                            ),
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: buildStepContent("Exterior"),
                        ),
                        isActive: currentStep >= 4,
                      ),
                      Step(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Bawah Kendaraan'),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                MyColors.appPrimaryColor, // foreground
                              ),
                              onPressed: () {
                                setState(() {
                                  currentStep = 5;
                                });
                              },
                              child: Text('Lihat'),
                            ),
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: buildStepContent("Bawah Kendaraan"),
                        ),
                        isActive: currentStep >= 5,
                      ),
                      Step(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Stall Test'),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                MyColors.appPrimaryColor, // foreground
                              ),
                              onPressed: () {
                                setState(() {
                                  currentStep = 6;
                                });
                              },
                              child: Text('Lihat'),
                            ),
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: buildStepContent("Stall Test"),
                        ),
                        isActive: currentStep >= 6,
                      ),
                      Step(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Finish General Check UP'),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                MyColors.appPrimaryColor, // foreground
                              ),
                              onPressed: () {
                                setState(() {
                                  currentStep = 7;
                                });
                              },
                              child: Text('Lihat'),
                            ),
                          ],
                        ),
                        content: SingleChildScrollView(
                          child: Container(),
                        ),
                        isActive: currentStep >= 7,
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  Widget buildStepContent(String title) {
    return Column(
      children: [
        FutureBuilder(
          future: API.GCMekanikID(kategoriKendaraanId: kategoriKendaraanId),
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
              final getDataAcc = generalData?.dataGeneralCheckUp
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
                          onDescriptionChanged: (description) {
                          },
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

  void submitForm(BuildContext context) async {
    setState(() {
      isSubmitting = true;
    });

    try {
      final kategoriKendaraanId = this.kategoriKendaraanId ?? '';
      final generalData =
      await API.GCMekanikID(kategoriKendaraanId: kategoriKendaraanId);
      if (generalData.dataGeneralCheckUp != null) {
        final dataList = generalData.dataGeneralCheckUp!;
        List<Map<String, dynamic>> generalCheckupList = [];
        final title = stepTitles[currentStep];
        final getDataAcc = dataList.firstWhere((e) => e.subHeading == title,
            orElse: () => null as DataGeneralCheckUp);

        if (getDataAcc.gcus != null && getDataAcc.gcus!.isNotEmpty) {
          final gcusList = getDataAcc.gcus!
              .map<Map<String, dynamic>>(
                (gcu) => {
              "gcu_id": gcu.gcuId.toString(),
              "status": dropdownValues[gcu.gcuId],
              "description": deskripsiControllers[gcu.gcuId]?.text ??
                  '',
            },
          )
              .toList();

          final generalCheckupObj = {
            "sub_heading_id": getDataAcc.subHeadingId,
            "gcus": gcusList,
          };

          generalCheckupList.add(generalCheckupObj);
          final kodeBooking = this.kodeBooking ?? '';
          final BookingId = this.BookingId ?? '';
          final idmekanik = this.idmekanik ?? '';

          if (kodeBooking.isNotEmpty) {
            final combinedData = {
              "booking_id": BookingId,
              "id_mekanik": idmekanik,
              "general_checkup": [
                {
                  "sub_heading_id": getDataAcc.subHeadingId,
                  "gcus": gcusList,
                }
              ],
            };

            print('Data yang disubmit: $combinedData');

            final submitResponse = await API.submitGCID(
              generalCheckup: combinedData,
            );

            print('Response dari server: $submitResponse');

            setState(() {
              isSubmitting = false;
            });
          } else {
            setState(() {
              isSubmitting = false;
            });
            QuickAlert.show(
              barrierDismissible: false,
              context: Get.context!,
              type: QuickAlertType.info,
              headerBackgroundColor: Colors.yellow,
              text: 'Kode Booking tidak boleh kosong',
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
            text: 'Tidak ada data General Checkup yang ditemukan',
            confirmBtnText: 'Kembali',
            cancelBtnText: 'Kembali',
            confirmBtnColor: Colors.green,
          );
        }
      } else {
        setState(() {
          isSubmitting = false;
        });
      }
    } catch (fetchError) {
    }
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
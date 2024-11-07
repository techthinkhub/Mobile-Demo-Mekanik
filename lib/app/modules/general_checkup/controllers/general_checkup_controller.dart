import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GeneralCheckupController extends GetxController {
  var currentStep =0.obs;
  final TextEditingController mesin = TextEditingController();
  final TextEditingController interior = TextEditingController();
  final TextEditingController brake = TextEditingController();
  final TextEditingController accel = TextEditingController();
  final TextEditingController stell = TextEditingController();
  final TextEditingController exterior = TextEditingController();
  final TextEditingController kendaraab = TextEditingController();
  final TextEditingController deskripsi = TextEditingController();
  final TextEditingController status = TextEditingController();
  late String id;
  late String tglBooking;
  late String jamBooking;
  late String nama;
  late String namaJenissvc;
  late String noPolisi;
  late String namaMerk;
  late String namaTipe;
  // late String mesin;
  // late String interior;
  // late String brake;
  // late String accel;
  // late String stell;
  // late String exterior;
  late String kendaraan;
  final TextEditingController odometer = TextEditingController(text: '');
  final TextEditingController mekanik = TextEditingController();
  void setInitialValues(Map args) {
    mesin.text = args['no_mesin'] ?? '';
    odometer.text = args['odometer'] ?? '';
  }

  void setData({
    required String id,
    required String tglBooking,
    required String jamBooking,
    required String nama,
    required String namaJenissvc,
    required String noPolisi,
    required String namaMerk,
    required String namaTipe,
    required String catatan,
    required String mesin,
    required String interior,
    required String brake,
    required String accel,
    required String stell,
    required String exterior,
    required String kendaraab,
  }) {
    this.id = id;
    this.tglBooking = tglBooking;
    this.jamBooking = jamBooking;
    this.nama = nama;
    this.namaJenissvc = namaJenissvc;
    this.noPolisi = noPolisi;
    this.namaMerk = namaMerk;
    this.namaTipe = namaTipe;
    // this.mesin = mesin;
    // this.interior = interior;
    // this.brake = brake;
    // this.accel = accel;
    // this.stell = stell;
    // this.exterior = exterior;
    this.kendaraan = kendaraan;
  }
  final count = 0.obs;
  late TextEditingController idController;
  late TextEditingController tglBookingController;
  late TextEditingController jamBookingController;
  late TextEditingController namaController;
  late TextEditingController namaJenissvcController;
  late TextEditingController noPolisiController;
  late TextEditingController namaMerkController;
  late TextEditingController namaTipeController;
  late TextEditingController statusController;
  late TextEditingController tanggalController;
  late TextEditingController jamController;
  late TextEditingController catatanController;
  late TextEditingController mesinController;
  late TextEditingController interiorController;
  late TextEditingController brakeController;
  late TextEditingController accelController;
  late TextEditingController stellController;
  late TextEditingController exteriorController;
  late TextEditingController kendaraanController;
  late TextEditingController deskripsiController;

  @override
  void onInit() {
    super.onInit();
    idController = TextEditingController();
    tglBookingController = TextEditingController();
    jamBookingController = TextEditingController();
    namaController = TextEditingController();
    namaJenissvcController = TextEditingController();
    noPolisiController = TextEditingController();
    namaMerkController = TextEditingController();
    namaTipeController = TextEditingController();
    statusController = TextEditingController();
    tanggalController = TextEditingController();
    jamController = TextEditingController();
    deskripsiController = TextEditingController();
    mesinController = TextEditingController(text: '');
    interiorController = TextEditingController(text: '');
    brakeController = TextEditingController(text: '');
    accelController = TextEditingController(text: '');
    stellController = TextEditingController(text: '');
    exteriorController = TextEditingController(text: '');
    kendaraanController = TextEditingController(text: '');
  }
  @override
  void onClose() {
    idController.dispose();
    tglBookingController.dispose();
    jamBookingController.dispose();
    namaController.dispose();
    namaJenissvcController.dispose();
    noPolisiController.dispose();
    namaMerkController.dispose();
    namaTipeController.dispose();
    statusController.dispose();
    deskripsiController.dispose();
    super.onClose();
  }
  @override
  void dispose() {
    deskripsiController.dispose();
    super.dispose();
  }
  void increment() => count.value++;
}
class GcuItemState {
  late String dropdownValue;
  late TextEditingController textEditingController;
}
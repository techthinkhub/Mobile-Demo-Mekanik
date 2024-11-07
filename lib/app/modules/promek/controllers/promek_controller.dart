import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromekController extends GetxController {
  final TextEditingController odometer = TextEditingController();
  final TextEditingController catatan = TextEditingController();
  final TextEditingController mekanik = TextEditingController();
  final TextEditingController jam = TextEditingController();
  final TextEditingController tanggal = TextEditingController();
  final TextEditingController keluhan = TextEditingController();
  final TextEditingController perintah = TextEditingController();
  final TextEditingController rangka = TextEditingController();
  final TextEditingController mesin = TextEditingController();
  final TextEditingController pic = TextEditingController();
  final TextEditingController hppic = TextEditingController();
  final TextEditingController nomberlambung = TextEditingController();
  final TextEditingController nomesin = TextEditingController();

  void setInitialValues(Map args) {
    tanggal.text = args['tgl_booking'] ?? '';
    jam.text = args['jam_booking'] ?? '';
    rangka.text = args['no_rangka'] ?? '';
    mesin.text = args['no_mesin'] ?? '';
    odometer.text = args['odometer'] ?? '';
    pic.text = args['pic'] ?? '';
    hppic.text = args['hp_pic'] ?? '';
    keluhan.text = args['keluhan'] ?? '';
    perintah.text = args['perintah_kerja'] ?? '';
    nomberlambung.text = args['vin_number'] ?? '';
  }

  void printAllData() {
    print('Keluhan: ${keluhan.text}');
    print('Odometer: ${odometer.text}');
    print('PIC: ${pic.text}');
    print('HP PIC: ${hppic.text}');
    print('Tanggal: ${tanggal.text}');
    print('Jam: ${jam.text}');
    print('Perintah Kerja: ${perintah.text}');
  }

  var keluhanText = ''.obs;

  var selectedDate = DateTime.now().obs;
  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  void updateTime(TimeOfDay newTime) {
    selectedTime.value = newTime;
  }

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    catatan.dispose();
    keluhan.dispose();
    mekanik.dispose();
    jam.dispose();
    tanggal.dispose();
    rangka.dispose();
    mesin.dispose();
    pic.dispose();
    hppic.dispose();
    nomesin.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}

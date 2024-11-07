import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mekanik/app/componen/color.dart';
import '../../../data/data_endpoint/profile.dart';
import '../../../data/endpoint.dart';
import '../controllers/approve_controller.dart';

class CardConsuments2 extends StatefulWidget {
  const CardConsuments2({super.key});

  @override
  State<CardConsuments2> createState() => _CardConsuments2State();
}

class _CardConsuments2State extends State<CardConsuments2> {
  final ApproveController controller = Get.find<ApproveController>();

  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    // Set the initial values from arguments
    final Map args = Get.arguments;
    controller.setInitialValues(args);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        controller.tanggal.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        String formattedTime = "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00";
        controller.jam.text = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map args = Get.arguments;
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Kode Booking : ', style: TextStyle(fontWeight: FontWeight.normal)),
                Text(args['kode_booking'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Jenis Service'),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(left: 25, right: 20),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      label: Text(args['nama_jenissvc'] ?? '', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      hintStyle: const TextStyle(color: Colors.black),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Tanggal Booking (edit)'),
                      TextField(
                        controller: controller.tanggal,
                        readOnly: true,
                        onTap: () {
                          _selectDate(context);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.only(left: 25, right: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Jam Booking (edit)'),
                      TextField(
                        controller: controller.jam,
                        readOnly: true,
                        onTap: () {
                          _selectTime(context);
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.only(left: 25, right: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Detail Kendaraan
            const Divider(color: Colors.grey),
            Text('Detail Kendaraan', style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.appPrimaryColor,
              fontSize: 16,
              )
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Vin Number'),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(left: 25, right: 20),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      label: Text(args['vin_number'] ?? '-', style: const TextStyle(color: Colors.black)),
                      hintStyle: const TextStyle(color: Colors.black),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('No Polisi'),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.only(left: 25, right: 20),
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text(args['no_polisi'] ?? '-', style: const TextStyle(color: Colors.black)),
                            hintStyle: const TextStyle(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Merk'),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.only(left: 25, right: 20),
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text(args['nama_merk'] ?? '-', style: const TextStyle(color: Colors.black)),
                            border: InputBorder.none,
                            hintStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Tipe dan Tahun
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Tipe'),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(left: 25, right: 20),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      label: Text(args['nama_tipe'] ?? '-', style: const TextStyle(color: Colors.black)),
                      border: InputBorder.none,
                      hintStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Tahun'),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(left: 25, right: 20),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      label: Text(args['tahun'] ?? '-', style: const TextStyle(color: Colors.black)),
                      border: InputBorder.none,
                      hintStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Warna'),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.only(left: 25, right: 20),
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text(args['warna'] ?? '-', style: const TextStyle(color: Colors.black)),
                            border: InputBorder.none,
                            hintStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Transmisi'),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.only(left: 25, right: 20),
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text(args['transmisi'] ?? '-', style: const TextStyle(color: Colors.black)),
                            border: InputBorder.none,
                            hintStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // No Rangka dan No Mesin
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('No Rangka'),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.only(left: 25, right: 20),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.number,
                          controller: controller.rangka,
                          decoration: InputDecoration(
                            hintText: args['no_rangka'] ?? "-",
                            border: InputBorder.none,
                            hintStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('No Mesin'),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.only(left: 25, right: 20),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.number,
                          controller: controller.mesin,
                          decoration: InputDecoration(
                            label: Text(args['no_mesin'] ?? "-"),
                            border: InputBorder.none,
                            hintStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Odometer
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Odometer'),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: controller.odometer,
                    decoration: InputDecoration(
                      label: Text(args['odometer'] ?? ''),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            // Detail Pelanggan
            const Divider(color: Colors.grey),
             Text('Detail Pelangan', style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColors.appPrimaryColor,
            fontSize: 16,)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Nama Pelangan'),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.only(left: 25, right: 20),
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            label: Text(args['nama'] ?? '-', style: const TextStyle(color: Colors.black)),
                            border: InputBorder.none,
                            hintStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Alamat Pelangan'),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(left: 25, right: 20),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      label: Text(args['alamat'] ?? '-', style: const TextStyle(color: Colors.black)),
                      border: InputBorder.none,
                      hintStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('HP'),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(left: 25, right: 20),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: args['hp'] ?? "-",
                      border: InputBorder.none,
                      hintStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.grey),
            Text('PIC', style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.appPrimaryColor,
              fontSize: 16,)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('PIC'),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: controller.pic,
                          decoration: InputDecoration(
                            hintText: args['pic'] ?? '-',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // HP PIC
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('HP PIC'),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: controller.hppic,
                    decoration: InputDecoration(
                      hintText: '',
                      label: Text(args['hp_pic'] ?? ''),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Keluhan dan Perintah Kerja
            const Divider(color: Colors.grey),
            const Text('Keluhan', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(left: 25, right: 20),
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  label: Text(args['keluhan'] ?? '-', style: const TextStyle(color: Colors.black)),
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            const Text('Printah Kerja', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(left: 25, right: 20),
              child: TextField(
                enabled: false,
                controller: controller.perintah,
                decoration: InputDecoration(
                  label: Text(args['perintah_kerja'] ?? '-', style: const TextStyle(color: Colors.black)),
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      // Kontainer tambahan atau elemen lain jika ada
    ]);
  }
}

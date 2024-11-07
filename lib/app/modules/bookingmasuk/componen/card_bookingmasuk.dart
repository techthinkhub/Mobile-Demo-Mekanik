import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mekanik/app/componen/color.dart';

import '../../../data/data_endpoint/boking.dart';

class BokingListMasuk extends StatelessWidget {
  final DataBooking items;
  final VoidCallback onTap;

  const BokingListMasuk({Key? key, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color statusColor = StatusColor.getColor(items.bookingStatus??'');
    return InkWell(
      onTap: onTap, // Menggunakan onTap yang diterima dari luar
      child: Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(children: [
                  Text('Jenis Service'),
                  Text(items.namaService?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                ],),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        items.bookingStatus.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],),
            SizedBox(height: 10,),
            Divider(color: Colors.grey,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  const Text('Tanggal Booking' ,style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),),
                  Text(
                    items.tglBooking.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],),
                Column(children: [
                  const Text('Jam Booking' ,style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),),
                  Text(
                    items.jamBooking.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],),
              ],
            ),
            Divider(color: Colors.grey,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Pelanggan'),
                      Text(items.nama??'', style: const TextStyle(fontWeight: FontWeight.bold),),
                    ]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Kode Booking'),
                    Text(
                      items.kodeBooking.toString(),
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],),

          ],
        ),
      ),
    );
  }
}

class StatusColor {
  static Color getColor(String status) {
    switch (status.toLowerCase()) {
      case 'booking':
        return Colors.blue;
      case 'approve':
        return Colors.green;
      case 'diproses':
        return Colors.orange;
      case 'estimasi':
        return Colors.blue;
      case 'estimasi':
        return Colors.orange;
        case 'selesai dikerjakan':
        return Colors.blue;
      case 'pkb':
        return Colors.yellow;
        case 'pkb tutup':
        return Colors.yellow;
        case 'invoice':
        return Colors.yellow;
        case 'lunas':
        return Colors.yellow;
      case 'ditolak by sistem':
        return Colors.red;
      case 'ditolak':
        return Colors.red;
      case 'selesai dikerjakan':
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }
}
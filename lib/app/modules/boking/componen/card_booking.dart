import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mekanik/app/componen/color.dart';

import '../../../data/data_endpoint/boking.dart';

class BokingList extends StatelessWidget {
  final DataBooking items;
  final VoidCallback onTap;

  const BokingList({Key? key, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color statusColor = StatusColor.getColor(items.bookingStatus ?? '');
    return InkWell(
      onTap: onTap,
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 10, top: 10, right: 15, left: 15),
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Jenis Service'),
                          Text(
                            items.namaService ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          const Text('Vin Number'),
                          Text(
                            items.vinNumber ?? 'Vin Number kosong',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
                          const SizedBox(height: 10),
                          if (items.typeOrder == 'Emergency Service')
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    items.typeOrder.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.grey),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Tanggal Booking',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            items.tglBooking.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Jam Booking',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            items.jamBooking.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Pelanggan'),
                          Text(
                            items.nama ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
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
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Detail Kendaraaan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Merek :'),
                    Text(
                      items.namaMerk ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text('Warna :'),
                    Text(
                      items.warna ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Type :'),
                      Text(
                        items.namaTipe ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Text('NoPol :'),
                      Text(
                        items.noPolisi ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
        return Colors.green;
      case 'selesai dikerjakan':
        return Colors.blue;
      case 'pkb':
        return Colors.green;
      case 'pkb tutup':
        return Colors.redAccent;
      case 'invoice':
        return Colors.blue;
      case 'lunas':
        return Colors.green;
      case 'ditolak by sistem':
        return Colors.red;
      case 'cancel booking':
        return Colors.red;
      case 'ditolak':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }
}

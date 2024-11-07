import 'package:flutter/material.dart';
import '../../../data/data_endpoint/bookingmasuk.dart';
import '../../../data/data_endpoint/servicedikerjakan.dart';

class ListSelesaiDikerjakan extends StatelessWidget {
  final DataDikerjakan items;
  final VoidCallback onTap;

  const ListSelesaiDikerjakan({Key? key, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color statusColor = StatusColor.getColor(items.status??'');
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(children: [
                        Text('Kode Booking'),
                        Text(items.kodeBooking?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
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
                              items.status.toString(),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(children: [
                        Text('Tanggal Booking'),
                        Text(items.tglBooking?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                      ],),
                      Column(children: [
                        Text('Jam Booking'),
                        Text(items.jamBooking?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
                      ],),
                    ],),
                  Divider(color: Colors.grey,),
                  const SizedBox(height: 10),
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
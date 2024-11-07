import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mekanik/app/componen/color.dart';
import '../../../data/data_endpoint/history.dart';
import 'detail_sheet.dart';

class HistoryList extends StatelessWidget {
  final DataHistory items;
  final VoidCallback onTap;

  const HistoryList({Key? key, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color statusColor = StatusColor.getColor(items.status ?? '');

    return LayoutBuilder(
      builder: (context, constraints) {
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Tipe Service'),
                        Text(
                          items.tipeSvc ?? "-",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
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
                        const SizedBox(height: 10),

                      ],
                    ),
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
                      Text(
                        items.nama ?? "-",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      const Text('Kode estimasi'),
                      Text(
                        items.kodeEstimasi.toString(),
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],)
                  ],
                ),
                const SizedBox(height: 10),
                const Text('PIC Estimasi'),
                Text(
                  items.createdBy ?? "-",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const Text('Tgl estimasi :'),
                          Text(
                            items.tglEstimasi?.split(" ")[0] ?? "",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            useSafeArea: true,
                            backgroundColor: Colors.white,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            showDragHandle: true,
                            enableDrag: true,
                            builder: (BuildContext context) {
                              return MyBottomSheet(items: items);
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Detail",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StatusColor {
  static Color getColor(String status) {
    switch (status.toLowerCase()) {
      case 'diproses':
        return Colors.orange;
      case 'estimasi':
        return Colors.lime;
      case 'dikerjakan':
        return Colors.orange;
      case 'invoice':
        return Colors.blue;
      case 'pkb':
        return Colors.green;
      case 'ditolak':
        return Colors.red;
      case 'selesai dikerjakan':
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }
}
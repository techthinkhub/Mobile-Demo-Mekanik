import 'package:flutter/material.dart';
import 'package:mekanik/app/componen/color.dart';
import '../../../../data/data_endpoint/absenhistory.dart';

class HistoryAbsensiTombol extends StatelessWidget {
  final HistoryAbsen items;

  const HistoryAbsensiTombol({Key? key, required this.items,required String jamMasuk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Text(
                items.jamMasuk ?? '',
                style: TextStyle(fontSize: 0, color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: ()async {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Absen Masuk',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: MyColors.appPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mekanik/app/componen/color.dart';
import '../../../../data/data_endpoint/absenhistory.dart';

class HistoryAbsensiIndikator extends StatelessWidget {
  final HistoryAbsen items;

  const HistoryAbsensiIndikator({Key? key, required this.items,required String jamMasuk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Text(
                items.jamMasuk ?? '',
                style: TextStyle(fontSize: 0, color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold),
              ),
              Text('Anda Sudah Absen', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              SizedBox(width: 10,),
              Icon(Icons.celebration_rounded, color: Colors.yellow, size: 18,),
            ],
          ),
        );
      },
    );
  }
}
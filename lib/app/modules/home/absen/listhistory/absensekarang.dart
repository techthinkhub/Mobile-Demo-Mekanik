import 'package:flutter/material.dart';
import 'package:mekanik/app/componen/color.dart';
import '../../../../data/data_endpoint/absenhistory.dart';

class HistoryAbsensiSekarang extends StatelessWidget {
  final HistoryAbsen items;

  const HistoryAbsensiSekarang({Key? key, required this.items,required String jamMasuk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return  Text(
          items.jamMasuk ?? '',
          style: TextStyle(fontSize: 40, color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mekanik/app/componen/color.dart';
import '../../../../data/data_endpoint/absenhistory.dart';

class HistoryAbsensi extends StatelessWidget {
  final HistoryAbsen items;

  const HistoryAbsensi({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_month, color: MyColors.appPrimaryColor),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      items.tglAbsen ?? '',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Icon(Icons.access_time_filled_rounded,color: MyColors.appPrimaryColor),
                    SizedBox(width: 8.0),
                    Text(
                      items.jamMasuk ?? '',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                  ),
                  Icon(Icons.arrow_forward_rounded, color: MyColors.appPrimaryColor,),
                  Text(
                    items.jamKeluar ?? 'Belum Pulang',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                'Keterangan :',
                style: TextStyle(fontSize: 16.0, color: MyColors.appPrimaryColor),
              ),
              Text(
                items.keterangan ?? '',
                style: TextStyle(fontSize: 16.0),
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/data_endpoint/history.dart';

class MyBottomSheet extends StatelessWidget {
  final DataHistory items; // Ganti YourItemClass dengan kelas item Anda

  MyBottomSheet({required this.items});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:
      Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.all(10),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Detail Pelanggan',style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Pelanggan :'),
                  Text(items.nama??"-",style: TextStyle(fontWeight: FontWeight.bold),),
                ],),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Kode PKB :'),
                  Text(items.kodePkb??"-",style: TextStyle(fontWeight: FontWeight.bold),),
                ],),
            ],),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('No Polisi :'),
                  Text(items.noPolisi??"-",style: TextStyle(fontWeight: FontWeight.bold),),
                ],),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Odometer :'),
                  Text(items.odometer??"-",style: TextStyle(fontWeight: FontWeight.bold),),
                ],),
            ],),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('KM Keluar :'),
                  Text(items.kmKeluar??"-",style: TextStyle(fontWeight: FontWeight.bold),),
                ],),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('KM Kembali :'),
                  Text(items.kmKembali??"-",style: TextStyle(fontWeight: FontWeight.bold),),
                ],),
            ],),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Tgl Keluar :'),
                  Text(items.tglKeluar??"-",style: TextStyle(fontWeight: FontWeight.bold),),
                ],),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Tgl Kembali :'),
                  Text(items.tglKembali??"-",style: TextStyle(fontWeight: FontWeight.bold),),
                ],),
            ],),
          SizedBox(height: 10,),
          Divider(color: Colors.grey,),
          SizedBox(height: 10,),
          Text('Detail Mekanik',style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('PIC Estimasi :'),
                  Text(items.createdBy??"-",style: TextStyle(fontWeight: FontWeight.bold),),
                ],),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('PIC PKB :'),
                  Text(items.createdByPkb??"-",style: TextStyle(fontWeight: FontWeight.bold),),
                ],),
            ],),
        ],),),);
  }
}

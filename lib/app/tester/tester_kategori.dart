import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/data_endpoint/kategory.dart';

class Datakategori extends StatelessWidget {
  final DataKategoriKendaraan items;
  final VoidCallback onTap;

  const Datakategori({Key? key, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      child: Column(
        children: [
          Text(items.kategoriKendaraanId?? '', style:  TextStyle(fontWeight: FontWeight.bold,color: Colors.transparent),),
          Text(items.kategoriKendaraan?? '', style:  TextStyle(fontWeight: FontWeight.bold, color: Colors.transparent),),
    ],),);
  }}
import 'package:flutter/cupertino.dart';
import 'package:mekanik/app/data/data_endpoint/gc_mekanik.dart';

import '../data/data_endpoint/kategory.dart';

class Datakategori extends StatelessWidget {
  final Gcus items;
  final VoidCallback onTap;

  const Datakategori({Key? key, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(items.gcu?? '', style: const TextStyle(fontWeight: FontWeight.bold),),
    ],),);
  }}
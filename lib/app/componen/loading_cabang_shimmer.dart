import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class loadcabang extends StatefulWidget {
  const loadcabang({super.key});

  @override
  State<loadcabang> createState() => _loadcabangState();
}

class _loadcabangState extends State<loadcabang> {
  @override
  Widget build(BuildContext context) {
    return  Shimmer(
        child:
        Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10)
          ),
        ));
  }
}

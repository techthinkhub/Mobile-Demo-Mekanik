import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class loadsearchpkb extends StatefulWidget {
  const loadsearchpkb({super.key});

  @override
  State<loadsearchpkb> createState() => _loadsearchpkbState();
}

class _loadsearchpkbState extends State<loadsearchpkb> {
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

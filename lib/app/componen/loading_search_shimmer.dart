import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class loadsearch extends StatefulWidget {
  const loadsearch({super.key});

  @override
  State<loadsearch> createState() => _loadsearchState();
}

class _loadsearchState extends State<loadsearch> {
  @override
  Widget build(BuildContext context) {
    return  Shimmer(
        child:
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10)
          ),
        ));
  }
}

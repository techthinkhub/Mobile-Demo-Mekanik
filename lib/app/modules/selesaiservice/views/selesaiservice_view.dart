import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/selesaiservice_controller.dart';

class SelesaiserviceView extends GetView<SelesaiserviceController> {
  const SelesaiserviceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text('SelesaiserviceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SelesaiserviceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

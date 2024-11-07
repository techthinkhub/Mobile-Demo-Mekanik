import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../componen/color.dart';
import '../../../data/data_endpoint/servicedikerjakan.dart';
import '../../../data/endpoint.dart';
import '../componen/list_card_selesai_dikerjakan.dart';
import '../controllers/selesaidikerjakan_controller.dart';

class SelesaidikerjakanView extends StatefulWidget {
  const SelesaidikerjakanView({super.key});

  @override
  State<SelesaidikerjakanView> createState() => _SelesaidikerjakanViewState();
}

class _SelesaidikerjakanViewState extends State<SelesaidikerjakanView> {
  late RefreshController _refreshController; // the refresh controller
  @override
  void initState() {
    _refreshController =
        RefreshController(); // we have to use initState because this part of the app have to restart
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        title: Text('Service Dikerjakan',style: TextStyle(color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold),),
        centerTitle: false,
      ),
      body: SmartRefresher(
    controller: _refreshController,
    enablePullDown: true,
    header: const WaterDropHeader(),
    onLoading: _onLoading,
    onRefresh: _onRefresh,
    child:
      SingleChildScrollView(
        child: FutureBuilder(
          future: API.DikerjakanID(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              ServiceDikerjakan? data = snapshot.data as ServiceDikerjakan?;
              if (data != null) {
                // Anda dapat mengakses atribut status seperti ini jika telah didefinisikan dalam kelas MasukBooking
                int? status = data.countDikerjakan;
                if (status != null) {
                  if (data.countDikerjakan == 0) {
                    return Container(
                      height: 500,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/car.png',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10,),
                          Text('Belum ada Service yang Dikerjakan hari ini', style: TextStyle(color: MyColors.appPrimaryColor, fontWeight: FontWeight.bold),)
                        ],),
                    );
                  } else {
                    return Column(
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 475),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: data.dataDikerjakan != null
                            ? data.dataDikerjakan!.map((e) {
                          return ListSelesaiDikerjakan(
                            items: e,
                            onTap: () {
                              HapticFeedback.lightImpact();
                            },
                          );
                        }).toList()
                            : [],
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Text('Status is false'),
                  );
                }
              } else {
                return Center(
                  child: Text('Data is null'),
                );
              }
            } else {
              return SizedBox(
                height: Get.height - 250,
                child: SingleChildScrollView(
                  child: Column(
                    children: [],
                  ),
                ),
              );
            }
          },
        ),
      ),
      ),
    );
  }
  _onLoading() {
    _refreshController
        .loadComplete(); // after data returned,set the //footer state to idle
  }

  _onRefresh() {
    HapticFeedback.lightImpact();
    setState(() {
// so whatever you want to refresh it must be inside the setState
      const SelesaidikerjakanView(); // if you only want to refresh the list you can place this, so the two can be inside setState
      _refreshController
          .refreshCompleted(); // request complete,the header will enter complete state,
// resetFooterState : it will set the footer state from noData to idle
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:search_page/search_page.dart';

import '../../../componen/color.dart';
import '../../../componen/loading_search_shimmer.dart';
import '../../../componen/loading_shammer_history.dart';
import '../../../data/data_endpoint/history.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';
import '../componen/card_history.dart';
import '../controllers/history_controller.dart';

class HistoryView2 extends StatefulWidget {
  final VoidCallback clearCachedBooking;

  const HistoryView2({Key? key, required this.clearCachedBooking}) : super(key: key);

  @override
  _HistoryView2State createState() => _HistoryView2State();
}

class _HistoryView2State extends State<HistoryView2> with SingleTickerProviderStateMixin {
  final controller = Get.put(HistoryController());
  late TabController _tabController;
  String selectedService = 'Repair & Maintenance';
  String selectedServicegc = 'General Check UP/P2H';
  String selectedServicepm = 'Periodical Maintenance';
  String selectedServicewt = 'Warranty';
  String selectedServicetb = 'Tire/ Ban';
  late List<RefreshController> _refreshControllers;
  String selectedStatus = 'Semua';
  List<String> statusOptions = ['Semua', 'ESTIMASI', 'PKB', 'PKB TUTUP', 'INVOICE'];
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _refreshControllers = List.generate(
        5, (index) => RefreshController()); // Adjust the number of RefreshControllers according to the number of tabs
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _getTabService(int index) {
    switch (index) {
      case 0:
        return 'Repair & Maintenance';
      case 1:
        return 'General Check UP/P2H';
        case 2:
        return 'Periodical Maintenance';
        case 3:
        return 'Warranty';
        case 4:
        return 'Tire/ Ban';
      default:
        return 'Repair & Maintenance';
    }
  }

  void _handleTabSelection() {
    setState(() {
      selectedService = _getTabService(_tabController.index);
      selectedServicegc = _getTabService(_tabController.index);
      selectedServicepm = _getTabService(_tabController.index);
      selectedServicewt = _getTabService(_tabController.index);
      selectedServicetb = _getTabService(_tabController.index);
    });
  }

  Future<void> handleBookingTap(DataHistory e) async {
    Get.toNamed(
      Routes.DETAIL_HISTORY,
      arguments: {
        'kode_svc': e.kodeSvc ?? '',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.checkForUpdate();
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/logo_tech.png',
                height: 45,
              ),
            ],
          ),
          actions: [
            FutureBuilder(
              future: API.HistoryID(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: loadsearch(),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  final data = snapshot.data!.dataHistory;

                  if (data != null && data.isNotEmpty) {
                    return InkWell(
                      onTap: () => showSearch(
                        context: context,
                        delegate: SearchPage<DataHistory>(
                          items: data,
                          searchLabel: 'Search History Booking',
                          searchStyle: TextStyle(color: Colors.black),
                          showItemsOnEmpty: true,
                          failure: Center(
                            child: Text(
                              'History Not Found :(',
                              style: TextStyle(),
                            ),
                          ),
                          filter: (booking) => [
                            booking.nama,
                            booking.noPolisi,
                            booking.status,
                            booking.createdByPkb,
                            booking.createdBy,
                            booking.tglEstimasi,
                            booking.tipeSvc,
                            booking.kodeEstimasi,
                          ],
                          builder: (items) =>
                              HistoryList(items: items,
                                  onTap: () {
                                    handleBookingTap(items);
                                  }),
                        ),
                      ),
                      child: Container(
                          padding: EdgeInsets.all(5),
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
                          child: Row(
                            children: [
                              Icon(
                                Icons.search_rounded,
                                color: MyColors.appPrimaryColor,
                              ),
                              SizedBox(width: 10,),
                              Text('Pencarian')
                            ],
                          )
                      )
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Search',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: loadsearch(),
                  );
                }
              },
            ),
            const SizedBox(width: 20),
          ],
          bottom: TabBar(
            controller: _tabController,
            labelColor:
            MyColors.appPrimaryColor, // Change label color as needed
            unselectedLabelColor:
            Colors.grey, // Change unselected label color as needed
            indicatorColor: MyColors.appPrimaryColor,
            tabs: const [
              Tab(
                text: 'Repair & Maintenance',
              ),
              Tab(
                text: 'General Check UP/P2H',
              ),
              Tab(
                text: 'Periodical Maintenance',
              ),
              Tab(
                text: 'Warranty',
              ),
              Tab(
                text: 'Tire/ Ban',
              ),
            ],
            // Include other actions as needed
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildTabContent('Repair & Maintenance'),
            _buildTabContent('General Check UP/P2H'),
            _buildTabContent('Periodical Maintenance'),
            _buildTabContent('Warranty'),
            _buildTabContent('Tire/ Ban'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String tabService) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
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
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedStatus,
              items: statusOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedStatus = newValue!;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: SmartRefresher(
            controller: _refreshControllers[_getTabIndex(tabService)],
            enablePullDown: true,
            header: const WaterDropHeader(),
            onRefresh: () => _onRefresh(tabService),
            onLoading: () => _onLoading(tabService),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    FutureBuilder(
                      future: API.HistoryID(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const LoadingshammerHistory();
                        } else if (snapshot.hasError) {
                          return LoadingshammerHistory();
                        } else if (snapshot.hasData) {
                          final data = snapshot.data!.dataHistory ?? [];
                          List<DataHistory> filteredData = [];

                          if (selectedStatus == 'Semua') {
                            filteredData = data
                                .where((item) => item.tipeSvc == tabService)
                                .toList();
                          } else {
                            filteredData = data
                                .where((item) =>
                            item.status == selectedStatus &&
                                item.tipeSvc == tabService)
                                .toList();
                          }

                          return filteredData.isEmpty
                              ? Container(
                            height: 500,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/booking.png',
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Belum ada data History',
                                  style: TextStyle(
                                      color: MyColors.appPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                              : Column(
                            children: filteredData.map((e) => HistoryList(
                              items: e,
                              onTap: () {
                                Get.toNamed(
                                  Routes.DETAIL_HISTORY,
                                  arguments: {
                                    'kode_svc': e.kodeSvc ?? '',
                                  },
                                );
                              },
                            )).toList(),
                          );
                        } else {
                          return const Center(
                            child: Text('History tidak ada'),
                          );
                        }
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onLoading(String status) {
    _refreshControllers[_getTabIndex(status)]
        .loadComplete(); // Stop loading animation on the corresponding RefreshController for the active tab
  }

  void _onRefresh(String status) {
    // Perform refresh actions here
    widget.clearCachedBooking(); // Bersihkan cache data
    _refreshControllers[_getTabIndex(status)]
        .refreshCompleted(); // Notifikasi bahwa refresh sudah selesai
    Navigator.of(context)
        .popUntil((route) => route.isFirst); // Kembali ke layar utama
  }

  int _getTabIndex(String tabService) {
    switch (tabService) {
      case 'Repair & Maintenance':
        return 0;
      case 'General Check UP/P2H':
        return 1;
      case 'Periodical Maintenance':
        return 2;
      case 'Warranty':
        return 3;
      default:
        return 0;
    }
  }

}
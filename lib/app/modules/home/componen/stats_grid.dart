import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:http/http.dart' as http;
import '../../../componen/color.dart';
import '../../../data/data_endpoint/bookingmasuk.dart';
import '../../../data/data_endpoint/invoicehome.dart';
import '../../../data/data_endpoint/servicedikerjakan.dart';
import '../../../data/data_endpoint/serviceselesai.dart';
import '../../../data/endpoint.dart';
import '../../../routes/app_pages.dart';

class StatsGrid extends StatefulWidget {
  @override
  _StatsGridState createState() => _StatsGridState();
}

class _StatsGridState extends State<StatsGrid> {
  Map<String, dynamic>? _weatherData;
  bool _loading = true;
  String _errorMessage = '';
  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }
  Future<void> _fetchWeatherData() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    try {
      // Mendapatkan lokasi saat ini
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final apiKey = '386eb373e3c1000f7963b990a826686d';
      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(url));

      // Print respons untuk debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          _weatherData = jsonDecode(response.body);
          _loading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Error: ${response.statusCode} - ${response.body}';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Exception: $e';
        _loading = false;
      });
    }
  }
  Future<void> _refreshWeatherData() async {
    await _fetchWeatherData();
  }

  LinearGradient _getGradient(double temperature) {
    if (temperature <= 0) {
      return LinearGradient(
        colors: [Colors.blue.shade800, Colors.blue.shade200],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (temperature <= 10) {
      return LinearGradient(
        colors: [Colors.blue.shade600, Colors.blue.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (temperature <= 20) {
      return LinearGradient(
        colors: [Colors.blue.shade300, Colors.orange.shade300],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (temperature <= 30) {
      return LinearGradient(
        colors: [Colors.orange.shade400, Colors.orange.shade600],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return LinearGradient(
        colors: [Colors.orange.shade800, Colors.red.shade800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.50,
      child: Column(
        children: <Widget>[
          _loading
              ? Padding(
              padding: const EdgeInsets.all(10),
              child: Column
                (children: [
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'loading...',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              'loading...,°C', // Tidak perlu konversi
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Cuaca: loading...',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
              )
          )
              : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : _weatherData != null
              ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    gradient: _getGradient(
                        _weatherData!['main']['temp']),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_weatherData!['name']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Suhu: ${_weatherData!['main']['temp']}°C',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Cuaca: ${_weatherData!['weather'][0]['description']}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Image.network(
                          'https://openweathermap.org/img/wn/${_weatherData!['weather'][0]['icon']}@2x.png',
                          width: 80,
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
              : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'loading...',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              'loading...,°C', // Tidak perlu konversi
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Cuaca: loading...',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
              )
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildFutureStatCard<MasukBooking>(
                  future: API.BookingMasukID(),
                  color: Colors.orange,
                  onTapRoute: Routes.BOOKINGMASUK,
                  dataLabel: "Booking Masuk",
                ),
                _buildFutureStatCard<ServiceSelesaiHome>(
                  future: API.ServiceSelesaiID(),
                  color: Colors.blue,
                  onTapRoute: '',
                  dataLabel: "Service Selesai",
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildFutureStatCard2<ServiceDikerjakan>(
                  future: API.DikerjakanID(),
                  color: Colors.green,
                  onTapRoute: Routes.SELESAIDIKERJAKAN,
                  dataLabel: "Service Dikerjakan",
                ),
                _buildFutureStatCard2<InvoiceHome>(
                  future: API.InvoiceID(),
                  color: Colors.purple,
                  onTapRoute: Routes.INVOICEMASUK,
                  dataLabel: "Invoice",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFutureStatCard<T>({
    required Future<T> future,
    required Color color,
    required String onTapRoute,
    required String dataLabel,
  }) {
    return Expanded(
      child: FutureBuilder<T>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingCard(color);
          } else if (snapshot.hasError) {
            return Shimmer(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Tidak ada Internet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Hari ini',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            var data = snapshot.data;
            var count = '0';
            var label = dataLabel;

            if (data is MasukBooking) {
              count = data.countBookingMasuk?.toString() ?? '0';
            } else if (data is ServiceSelesaiHome) {
              count = data.countBookingMasuk?.toString() ?? '0';
            } else if (data is ServiceDikerjakan) {
              count = data.countDikerjakan?.toString() ?? '0';
            } else if (data is InvoiceHome) {
              count = data.countInvoice?.toString() ?? '0';
            }

            return InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                Get.toNamed(onTapRoute);
              },
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Hari ini',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      count,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildFutureStatCard2<T>({
    required Future<T> future,
    required Color color,
    required String onTapRoute,
    required String dataLabel,
  }) {
    return Expanded(
      child: FutureBuilder<T>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingCard(color);
          } else if (snapshot.hasError) {
            return Shimmer(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Tidak ada Internet',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Hari ini',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            var data = snapshot.data;
            var count = '0';
            var label = dataLabel;

            if (data is MasukBooking) {
              count = data.countBookingMasuk?.toString() ?? '0';
            } else if (data is ServiceSelesaiHome) {
              count = data.countBookingMasuk?.toString() ?? '0';
            } else if (data is ServiceDikerjakan) {
              count = data.countDikerjakan?.toString() ?? '0';
            }

            return InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                Get.toNamed(onTapRoute);
              },
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'Hari ini',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      count,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildLoadingCard(Color color) {
    return Shimmer(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Hari ini',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '0',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'Hari ini',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

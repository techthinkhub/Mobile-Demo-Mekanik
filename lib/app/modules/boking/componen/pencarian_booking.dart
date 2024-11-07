import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_page/search_page.dart';
import '../../../data/data_endpoint/boking.dart';
import '../../../data/endpoint.dart';
import 'card_booking.dart';


class SearchBoking extends StatefulWidget {
  const SearchBoking({super.key});

  @override
  State<SearchBoking> createState() => _SearchBokingState();
}

class _SearchBokingState extends State<SearchBoking> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey, // Warna abu-abu untuk border
              ),
            ),
            child: FutureBuilder(
              future: API.bokingid(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  final data = snapshot.data!.dataBooking;

                  if (data != null && data.isNotEmpty) {
                    return TextField(
                      readOnly: true,
                      onTap: () => showSearch(
                        context: context,
                        delegate: SearchPage<DataBooking>(
                          items: data,
                          searchLabel: 'Cari Boking',
                          searchStyle: GoogleFonts.nunito(color: Colors.black),
                          showItemsOnEmpty: true,
                          failure: Center(
                            child: Text(
                              'Pasien Tidak Terdaftar :(',
                              style: GoogleFonts.nunito(),
                            ),
                          ),
                          filter: (boking) => [
                            boking.nama,
                            boking.noPolisi,
                            boking.kodeBooking,
                          ],
                          builder: (items) =>
                              BokingList(items: items, onTap: () {  }, ),
                        ),
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                            left: 15, bottom: 11, top: 13, right: 15),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            if (kDebugMode) {
                              print('search');
                            }
                          },
                        ),
                        filled: true,
                        hintText: "Pencarian",
                        fillColor: Colors.transparent,
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Pencarian',
                        style: GoogleFonts.nunito(fontSize: 16),
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Text(
                      'Terjadi kesalahan saat mengambil data.',
                      style: GoogleFonts.nunito(),
                    ),
                  );
                }
              },
            )),
      ],
    );
  }
}

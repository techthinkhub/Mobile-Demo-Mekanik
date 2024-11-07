import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../componen/color.dart';
import '../../../data/data_endpoint/detailsperpart.dart';
import '../../../data/endpoint.dart';
import '../../../data/publik.dart';
import 'imagedetail/imagedetail.dart';
import 'package:http/http.dart' as http;

class CardDetailPKBSperepart extends StatefulWidget {
  const CardDetailPKBSperepart({Key? key}) : super(key: key);

  @override
  State<CardDetailPKBSperepart> createState() => _CardDetailPKBSperepartState();
}

class _CardDetailPKBSperepartState extends State<CardDetailPKBSperepart> {
  late RefreshController _refreshController;
  final ImagePicker _picker = ImagePicker();
  List<AddedImageBefor> _addedImagesBefore = [];
  List<AddedImageAfter> _addedImagesAfter = [];
  String svcId = '';
  String kodePkb = '';
  String kodeSparepart = '';

  void _showPicker(
      BuildContext context, String title, String photoType, String? namaSparepart, String? kodeSparepart,) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'Upload Photo $title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColors.appPrimaryColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Sparepart :',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    Text(
                      '$namaSparepart',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Kode Sparepart :',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    Text(
                      '$kodeSparepart',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImages('Gallery', photoType, kodeSparepart!);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImages('Camera', photoType, kodeSparepart!);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
  Future<void> _pickImages(String sourceType, String photoType, String? kodeSparepart) async {
    try {
      List<XFile>? images;

      if (sourceType == 'Gallery') {
        images = await _picker.pickMultiImage();
      } else if (sourceType == 'Camera') {
        final XFile? image = await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          images = [image];
        }
      }

      if (images != null) {
        // Show loading alert
        QuickAlert.show(
          barrierDismissible: true,
          context: Get.context!,
          type: QuickAlertType.loading,
          headerBackgroundColor: Colors.yellow,
          title: 'Proses Upload',
          confirmBtnColor: Colors.green,
        );

        for (var image in images) {
          String id = DateTime.now().millisecondsSinceEpoch.toString();

          // Compress image
          final compressedFile = await _compressImage(File(image.path));

          // Convert the compressed File back to XFile
          final compressedXFile = XFile(compressedFile.path);

          if (photoType == 'Before') {
            AddedImageBefor addedImage = AddedImageBefor(
              id: id,
              kodeSparepart: kodeSparepart ?? '', // Default to empty string if kodeSparepart is null
              file: compressedXFile, // Use the compressed XFile
            );
            _addedImagesBefore.add(addedImage);
          } else if (photoType == 'After') {
            AddedImageAfter addedImage = AddedImageAfter(
              id: id,
              kodeSparepart: kodeSparepart ?? '', // Default to empty string if kodeSparepart is null
              file: compressedXFile, // Use the compressed XFile
            );
            _addedImagesAfter.add(addedImage);
          }

          await _uploadImage(compressedFile, kodeSparepart ?? '', kodePkb, photoType); // Pass empty string if kodeSparepart is null

          print('Selected image path: ${compressedFile.path}');
        }

        // Dismiss loading alert
        Navigator.of(Get.context!).pop();

        setState(() {});
      }
    } catch (e) {
      // Dismiss loading alert in case of error
      Navigator.of(Get.context!).pop();
      print('Error picking images: $e');
      // Handle error
    }
  }

  Future<File> _compressImage(File file) async {
    final filePath = file.absolute.path;

    // Determine the output format based on the file extension
    CompressFormat format;
    if (filePath.toLowerCase().endsWith('.jpg') || filePath.toLowerCase().endsWith('.jpeg')) {
      format = CompressFormat.jpeg;
    } else if (filePath.toLowerCase().endsWith('.png')) {
      format = CompressFormat.png;
    } else if (filePath.toLowerCase().endsWith('.heic')) {
      format = CompressFormat.heic;
    } else {
      throw UnsupportedError('Unsupported file format');
    }

    final outPath = "${filePath.substring(0, filePath.lastIndexOf('.'))}_compressed${filePath.substring(filePath.lastIndexOf('.'))}";

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 70, // Adjust quality as needed
      minWidth: 1080,
      minHeight: 1080,
      format: format,
    );

    if (result == null) {
      throw Exception('Image compression failed');
    }


    return File(result.path);
  }



  Future<void> _uploadImage(File imageFile, String kodeSparepart, String kodePkb, String photoType) async {
    final token = Publics.controller.getToken.value ?? ''; // Get the token
    final url = Uri.parse('https://mobile.techthinkhub.id/api/mekanik/insert-photosparepart');
    final request = http.MultipartRequest('POST', url);

    request.headers['Authorization'] = 'Bearer $token';

    request.fields['svc_id'] = svcId;
    request.fields['kode_pkb'] = kodePkb;
    request.fields['dtl_kode_sparepart'] = kodeSparepart;

    int imageCount = photoType == 'Before' ? _addedImagesBefore.length : _addedImagesAfter.length;

    request.fields['baris_dtl'] = imageCount.toString();

    print('svcId: $svcId');
    print('kodePkb: $kodePkb');
    print('kodesparepart : $kodeSparepart');
    print('baris_dtl: ${request.fields['baris_dtl']}');

    request.files.add(await http.MultipartFile.fromPath(
      '${photoType == 'Before' ? 'image_before' : 'image_after'}_${imageCount - 1}[]',
      imageFile.path,
    ));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Image upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _fetchAbsenInfo(String kodeSvc) async {
    try {
      final UploadSpertpart1 = await API.DetailSpertpartID(kodesvc: kodeSvc);
      setState(() {
        if (UploadSpertpart1?.dataPhotosparepart != null) {
          svcId = UploadSpertpart1.dataPhotosparepart!.dataSvc!.svcId.toString();
          kodePkb = UploadSpertpart1.dataPhotosparepart!.dataSvc!.kodePkb.toString();
          print('svcId: $svcId'); // Ensure svcId is correctly set here
        } else {
          svcId = '';
        }
      });
    } catch (e) {
      print('Error fetching absen info: $e');
    }
  }
  @override
  void initState() {
    _refreshController = RefreshController();
    final Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;
    final String kodeSvc = arguments?['kode_svc'] ?? '';
    _fetchAbsenInfo(kodeSvc);
    super.initState();
  }

  void _reloadData() {
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;
    final String kodeSvc = arguments?['kode_svc'] ?? '';
    print(arguments);

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ),
        title: Text('Detail', style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.appPrimaryColor)),
        centerTitle: false,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: const WaterDropHeader(),
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: FutureBuilder<DetailSpertpart>(
            future: API.DetailSpertpartID(kodesvc: kodeSvc),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final dataSvc = snapshot.data!.dataPhotosparepart?.dataSvc;
                final dataSvcDtlJasa = snapshot.data!.dataPhotosparepart!.detailSparepart;
                final photoSparepart = snapshot.data!.dataPhotosparepart!.photoSparepart;

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${dataSvc?.tipeSvc}', style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.appPrimaryColor, fontSize: 15)),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text('Tanggal & Jam Estimasi :'),
                                    Text('${dataSvc?.tglEstimasi??'-'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text('Jam Selesai'),
                                    Text('${dataSvc?.jamSelesai ?? '-'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text('Tanggal & Jam PKB :'),
                                    Text('${dataSvc?.tglPkb??'-'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text('Jam Selesai'),
                                    Text('${dataSvc?.jamSelesai ?? '-'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Cabang'),
                              Text('${dataSvc?.namaCabang??'-'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Kode Estimasi'),
                              Text('${dataSvc?.kodeEstimasi??'-'}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Tipe Pelanggan :'),
                              Text('${dataSvc?.tipePelanggan ?? '-'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Kode PKB'),
                              Text('${dataSvc?.kodePkb??'-'}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                            ],
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),
                      Text('Detail Pelanggan', style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.appPrimaryColor)),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Nama :'),
                          Text('${dataSvc?.nama??'-'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          const Text('No Handphone :'),
                          Text('${dataSvc?.hp??'-'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          const Text('Alamat :'),
                          Text('${dataSvc?.alamat??'-'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),
                      Text('Kendaraan Pelanggan', style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.appPrimaryColor)),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Merk :'),
                              Text('${dataSvc?.namaMerk??'-'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),

                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text('Tipe :'),
                                Text(
                                  dataSvc?.namaTipe??'-',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          )],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Tahun :'),
                              Text('${dataSvc?.tahun??'-'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Warna :'),
                              Text('${dataSvc?.warna??'-'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Odometer :'),
                          Text('${dataSvc?.odometer??'-'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('No Polisi :'),
                              Text('${dataSvc?.noPolisi}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Vin Number :'),
                              Text('${dataSvc?.vinNumber??'belum ada Vin Number'}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),
                      Text('Sparepart', style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.appPrimaryColor, fontSize: 18)),
                      Column(
                        children: [
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              if (photoSparepart != null)
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (int index = 0; index < (dataSvcDtlJasa?.length ?? 0); index++)
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${dataSvcDtlJasa?[index].namaSparepart}',
                                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '${dataSvcDtlJasa?[index].kodeSparepart}',
                                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  const Text('Harga :'),
                                                  Text(
                                                    'Rp. ${NumberFormat('#,##0', 'id_ID').format(dataSvcDtlJasa?[index].hargaSparepart ?? 0)}',
                                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Text('Kode Sparepart:  ${dataSvcDtlJasa?[index].kodeSparepart}',
                                              style: TextStyle(
                                                fontSize: 14,
                                              )),
                                          SizedBox(height: 5),
                                          Text('QTY:  ${dataSvcDtlJasa?[index].qtySparepart}',
                                              style: TextStyle(
                                                fontSize: 14,
                                              )),
                                          const SizedBox(height: 10),
                                          if (photoSparepart != null)
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: 10),
                                                        Text(
                                                          'Before Photos :',
                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () => _showPicker(
                                                          context,
                                                          'Before ',
                                                          'Before',
                                                          dataSvcDtlJasa?[index].namaSparepart,
                                                          dataSvcDtlJasa?[index].kodeSparepart),
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: MyColors.appPrimaryColor,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                        elevation: 0,

                                                      ),
                                                      child: const Text(
                                                        'Upload Photo Before',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                if (getBeforePhotos(
                                                    photoSparepart,
                                                    dataSvcDtlJasa?[index].namaSparepart ?? "",
                                                    dataSvcDtlJasa?[index].kodeSparepart ?? "")
                                                    .isNotEmpty)
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const SizedBox(height: 10),
                                                      SizedBox(
                                                        height: 120,
                                                        child:ListView.builder(
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: getBeforePhotos(
                                                              photoSparepart,
                                                              dataSvcDtlJasa?[index].namaSparepart ?? "",
                                                              dataSvcDtlJasa?[index].kodeSparepart ?? ""
                                                          ).length + _addedImagesBefore.where((img) => img.kodeSparepart == dataSvcDtlJasa?[index].kodeSparepart).length,
                                                          itemBuilder: (context, photoIndex) {
                                                            if (photoIndex < getBeforePhotos(
                                                                photoSparepart,
                                                                dataSvcDtlJasa?[index].namaSparepart ?? "",
                                                                dataSvcDtlJasa?[index].kodeSparepart ?? ""
                                                            ).length) {
                                                              // Display existing photos
                                                              final List<PhotoSparepart> photos = getBeforePhotos(
                                                                  photoSparepart,
                                                                  dataSvcDtlJasa?[index].namaSparepart ?? "",
                                                                  dataSvcDtlJasa?[index].kodeSparepart ?? ""
                                                              );
                                                              final String imageUrl = photos[photoIndex].photoUrl ?? '';
                                                              final String photoId = photos[photoIndex].id.toString();
                                                              final String kodesparepart = photos[photoIndex].kodeSparepart ?? '';

                                                              // Ensure only network images are shown
                                                              if (imageUrl.startsWith('http')) {
                                                                return buildPhotoWidget(imageUrl, photoId, kodesparepart);
                                                              }
                                                              return SizedBox(); // Return an empty widget if the condition is not met
                                                            } else {
                                                              // Display newly added images filtered by kodeSparepart
                                                              final List<AddedImageBefor> filteredAddedImages = _addedImagesBefore.where((img) => img.kodeSparepart == dataSvcDtlJasa?[index].kodeSparepart).toList();
                                                              final AddedImageBefor addedImage = filteredAddedImages[photoIndex - getBeforePhotos(
                                                                  photoSparepart,
                                                                  dataSvcDtlJasa?[index].namaSparepart ?? "",
                                                                  dataSvcDtlJasa?[index].kodeSparepart ?? ""
                                                              ).length];

                                                              final String imageUrl = addedImage.file.path; // Adjust based on how XFile is stored
                                                              final String photoId = addedImage.id;
                                                              final String kodeSparepart = addedImage.kodeSparepart; // Get kodeSparepart from AddedImage

                                                              // Return an empty widget as we are hiding local file images
                                                              return SizedBox();
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: 10),
                                                        Text(
                                                          'After Photos :',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () => _showPicker(
                                                          context,
                                                          'After ',
                                                          'After',
                                                          dataSvcDtlJasa?[index].namaSparepart,
                                                          dataSvcDtlJasa?[index].kodeSparepart),
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: MyColors.appPrimaryColor,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(20)),
                                                        elevation: 0,
                                                      ),
                                                      child: const Text(
                                                        'Upload Photo After',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                if (getAfterPhotos(
                                                    photoSparepart,
                                                    dataSvcDtlJasa?[index].namaSparepart ?? "",
                                                    dataSvcDtlJasa?[index].kodeSparepart ?? "")
                                                    .isNotEmpty)
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const SizedBox(height: 10),
                                                      SizedBox(
                                                        height: 120,
                                                        child:ListView.builder(
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: getAfterPhotos(
                                                            photoSparepart,
                                                            dataSvcDtlJasa?[index].namaSparepart ?? "",
                                                            dataSvcDtlJasa?[index].kodeSparepart ?? "",
                                                          ).length + _addedImagesAfter.where((img) => img.kodeSparepart == dataSvcDtlJasa?[index].kodeSparepart).length,
                                                          itemBuilder: (context, photoIndex) {
                                                            if (photoIndex < getAfterPhotos(
                                                              photoSparepart,
                                                              dataSvcDtlJasa?[index].namaSparepart ?? "",
                                                              dataSvcDtlJasa?[index].kodeSparepart ?? "",
                                                            ).length) {
                                                              // Display existing photos
                                                              final List<PhotoSparepart> photos = getAfterPhotos(
                                                                photoSparepart,
                                                                dataSvcDtlJasa?[index].namaSparepart ?? "",
                                                                dataSvcDtlJasa?[index].kodeSparepart ?? "",
                                                              );
                                                              final String imageUrl = photos[photoIndex].photoUrl ?? '';
                                                              final String photoId = photos[photoIndex].id.toString();
                                                              final String kodesparepart = photos[photoIndex].kodeSparepart ?? '';

                                                              // Ensure only network images are shown
                                                              if (imageUrl.startsWith('http')) {
                                                                return buildPhotoWidget(imageUrl, photoId, kodesparepart);
                                                              }
                                                              return SizedBox(); // Return an empty widget if the condition is not met
                                                            } else {
                                                              // Display newly added images filtered by kodeSparepart
                                                              final List<AddedImageAfter> filteredAddedImages = _addedImagesAfter.where((img) => img.kodeSparepart == dataSvcDtlJasa?[index].kodeSparepart).toList();
                                                              final AddedImageAfter addedImage = filteredAddedImages[photoIndex - getAfterPhotos(
                                                                photoSparepart,
                                                                dataSvcDtlJasa?[index].namaSparepart ?? "",
                                                                dataSvcDtlJasa?[index].kodeSparepart ?? "",
                                                              ).length];

                                                              final String imageUrl = addedImage.file.path; // Adjust based on how XFile is stored
                                                              final String photoId = addedImage.id;
                                                              final String kodeSparepart = addedImage.kodeSparepart; // Get kodeSparepart from AddedImage

                                                              // Return an empty widget as we are hiding local file images
                                                              return SizedBox();
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          const Divider(color: Colors.grey),
                                        ],
                                      ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }
  Widget buildPhotoWidget(String imageUrl, String photoId, String kodeSparepart) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDetailScreen(
                    imageUrl: imageUrl,
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageUrl.startsWith('http') ?
              Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ) :
              Image.file(
                File(imageUrl),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () async {
                print(photoId);
                QuickAlert.show(
                  barrierDismissible: true,
                  context: Get.context!,
                  type: QuickAlertType.info,
                  headerBackgroundColor:
                  Colors.yellow,
                  title:
                  'Anda yakin ingin menghapusnya?',
                  confirmBtnText: 'Hapus',
                  cancelBtnText: 'Batal',
                  confirmBtnColor: Colors.green,
                  onConfirmBtnTap: () async {
                    var response =
                    await API.DeletesPerpartID(
                        id: photoId);
                    if (response.status == true) {
                      _reloadData();
                      Navigator.of(Get.context!)
                          .pop();
                    } else {}
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _onLoading() {
    _refreshController.loadComplete();
  }

  void _onRefresh() {
    HapticFeedback.lightImpact();
    setState(() {
      // Refresh logic here
    });
    _refreshController.refreshCompleted();
  }

  List<PhotoSparepart> getBeforePhotos(List<PhotoSparepart> photoSparepart, String namaSparepart, String kodeSparepart) {
    return photoSparepart.where((photo) => photo.photoType?.toLowerCase() == 'before' && photo.kodeSparepart == kodeSparepart).toList();
  }

  List<PhotoSparepart> getAfterPhotos(List<PhotoSparepart> photoSparepart, String namaSparepart, String kodeSparepart) {
    return photoSparepart.where((photo) => photo.photoType?.toLowerCase() == 'after' && photo.kodeSparepart == kodeSparepart).toList();
  }

}
class AddedImageBefor {
  String id;
  String kodeSparepart;
  XFile file;

  AddedImageBefor({
    required this.id,
    required this.kodeSparepart,
    required this.file,
  });
}
class AddedImageAfter {
  String id;
  String kodeSparepart;
  XFile file;

  AddedImageAfter({
    required this.id,
    required this.kodeSparepart,
    required this.file,
  });
}
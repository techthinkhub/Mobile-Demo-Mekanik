class Kategori {
  bool? status;
  String? message;
  List<DataKategoriKendaraan>? dataKategoriKendaraan;

  Kategori({this.status, this.message, this.dataKategoriKendaraan});

  Kategori.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['dataKategoriKendaraan'] != null) {
      dataKategoriKendaraan = <DataKategoriKendaraan>[];
      json['dataKategoriKendaraan'].forEach((v) {
        dataKategoriKendaraan!.add(new DataKategoriKendaraan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.dataKategoriKendaraan != null) {
      data['dataKategoriKendaraan'] =
          this.dataKategoriKendaraan!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataKategoriKendaraan {
  String? kategoriKendaraanId;
  String? kategoriKendaraan;

  DataKategoriKendaraan({this.kategoriKendaraanId, this.kategoriKendaraan});

  DataKategoriKendaraan.fromJson(Map<String, dynamic> json) {
    kategoriKendaraanId = json['kategori_kendaraan_id'];
    kategoriKendaraan = json['kategori_kendaraan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kategori_kendaraan_id'] = this.kategoriKendaraanId;
    data['kategori_kendaraan'] = this.kategoriKendaraan;
    return data;
  }
}
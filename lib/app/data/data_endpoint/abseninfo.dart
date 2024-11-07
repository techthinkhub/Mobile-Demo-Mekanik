class Absen {
  bool? status;
  String? message;
  DataAbsen? dataAbsen;

  Absen({this.status, this.message, this.dataAbsen});

  Absen.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dataAbsen = json['dataAbsen'] != null
        ? new DataAbsen.fromJson(json['dataAbsen'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.dataAbsen != null) {
      data['dataAbsen'] = this.dataAbsen!.toJson();
    }
    return data;
  }
}

class DataAbsen {
  int? id;
  int? idKaryawan;
  String? nama;
  String? tglAbsen;
  String? jamMasuk;
  String? jamKeluar;
  String? keterangan;

  DataAbsen(
      {this.id,
        this.idKaryawan,
        this.nama,
        this.tglAbsen,
        this.jamMasuk,
        this.jamKeluar,
        this.keterangan});

  DataAbsen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idKaryawan = json['id_karyawan'];
    nama = json['nama'];
    tglAbsen = json['tgl_absen'];
    jamMasuk = json['jam_masuk'];
    jamKeluar = json['jam_keluar'];
    keterangan = json['keterangan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_karyawan'] = this.idKaryawan;
    data['nama'] = this.nama;
    data['tgl_absen'] = this.tglAbsen;
    data['jam_masuk'] = this.jamMasuk;
    data['jam_keluar'] = this.jamKeluar;
    data['keterangan'] = this.keterangan;
    return data;
  }
}
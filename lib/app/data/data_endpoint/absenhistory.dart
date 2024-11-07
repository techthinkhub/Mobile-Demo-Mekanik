class AbsenHistory {
  bool? status;
  String? massage;
  List<HistoryAbsen>? historyAbsen;

  AbsenHistory({this.status, this.massage, this.historyAbsen});

  AbsenHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    massage = json['massage'];
    if (json['historyAbsen'] != null) {
      historyAbsen = <HistoryAbsen>[];
      json['historyAbsen'].forEach((v) {
        historyAbsen!.add(new HistoryAbsen.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['massage'] = this.massage;
    if (this.historyAbsen != null) {
      data['historyAbsen'] = this.historyAbsen!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryAbsen {
  int? id;
  String? nama;
  String? tglAbsen;
  String? jamMasuk;
  String? jamKeluar;
  String? keterangan;

  HistoryAbsen(
      {this.id,
        this.nama,
        this.tglAbsen,
        this.jamMasuk,
        this.jamKeluar,
        this.keterangan});

  HistoryAbsen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    tglAbsen = json['tgl_absen'];
    jamMasuk = json['jam_masuk'];
    jamKeluar = json['jam_keluar'];
    keterangan = json['keterangan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['tgl_absen'] = this.tglAbsen;
    data['jam_masuk'] = this.jamMasuk;
    data['jam_keluar'] = this.jamKeluar;
    data['keterangan'] = this.keterangan;
    return data;
  }
}
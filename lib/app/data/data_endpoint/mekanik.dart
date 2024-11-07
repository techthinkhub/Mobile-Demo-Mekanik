class Mekanik {
  bool? status;
  String? message;
  List<DataJasa>? dataJasa;
  List<DataMekanik>? dataMekanik;

  Mekanik({this.status, this.message, this.dataJasa, this.dataMekanik});

  Mekanik.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['dataJasa'] != null) {
      dataJasa = <DataJasa>[];
      json['dataJasa'].forEach((v) {
        dataJasa!.add(new DataJasa.fromJson(v));
      });
    }
    if (json['dataMekanik'] != null) {
      dataMekanik = <DataMekanik>[];
      json['dataMekanik'].forEach((v) {
        dataMekanik!.add(new DataMekanik.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.dataJasa != null) {
      data['dataJasa'] = this.dataJasa!.map((v) => v.toJson()).toList();
    }
    if (this.dataMekanik != null) {
      data['dataMekanik'] = this.dataMekanik!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataJasa {
  int? id;
  String? kodeJasa;
  String? namaJasa;
  int? biaya;
  int? jam;
  String? divisiJasa;
  int? deleted;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  DataJasa(
      {this.id,
        this.kodeJasa,
        this.namaJasa,
        this.biaya,
        this.jam,
        this.divisiJasa,
        this.deleted,
        this.createdBy,
        this.createdAt,
        this.updatedAt});

  DataJasa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodeJasa = json['kode_jasa'];
    namaJasa = json['nama_jasa'];
    biaya = json['biaya'];
    jam = json['jam'];
    divisiJasa = json['divisi_jasa'];
    deleted = json['deleted'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode_jasa'] = this.kodeJasa;
    data['nama_jasa'] = this.namaJasa;
    data['biaya'] = this.biaya;
    data['jam'] = this.jam;
    data['divisi_jasa'] = this.divisiJasa;
    data['deleted'] = this.deleted;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class DataMekanik {
  int? idMekanik;
  String? nama;
  String? email;
  String? roleNama;

  DataMekanik({this.idMekanik, this.nama, this.email, this.roleNama});

  DataMekanik.fromJson(Map<String, dynamic> json) {
    idMekanik = json['id_mekanik'];
    nama = json['nama'];
    email = json['email'];
    roleNama = json['role_nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_mekanik'] = this.idMekanik;
    data['nama'] = this.nama;
    data['email'] = this.email;
    data['role_nama'] = this.roleNama;
    return data;
  }
}
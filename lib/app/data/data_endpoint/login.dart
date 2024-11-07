class Token {
  bool? status;
  String? message;
  String? token;
  Data? data;

  Token({this.status, this.message, this.token, this.data});

  Token.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Karyawan? karyawan;

  Data({this.karyawan});

  Data.fromJson(Map<String, dynamic> json) {
    karyawan = json['karyawan'] != null
        ? new Karyawan.fromJson(json['karyawan'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.karyawan != null) {
      data['karyawan' ] = this.karyawan!.toJson();
    }
    return data;
  }
}

class Karyawan {
  int? id;
  String? kode;
  String? nama;
  String? hp;
  String? email;
  String? posisi;
  String? group;
  int? useApp;
  int? deleted;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? cabangId;
  String? namaCabang;

  Karyawan(
      {this.id,
        this.kode,
        this.nama,
        this.hp,
        this.email,
        this.posisi,
        this.group,
        this.useApp,
        this.deleted,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.cabangId,
        this.namaCabang});

  Karyawan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    nama = json['nama'];
    hp = json['hp'];
    email = json['email'];
    posisi = json['posisi'];
    group = json['group'];
    useApp = json['use_app'];
    deleted = json['deleted'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cabangId = json['cabang_id'];
    namaCabang = json['nama_cabang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode'] = this.kode;
    data['nama'] = this.nama;
    data['hp'] = this.hp;
    data['email'] = this.email;
    data['posisi'] = this.posisi;
    data['group'] = this.group;
    data['use_app'] = this.useApp;
    data['deleted'] = this.deleted;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['cabang_id'] = this.cabangId;
    data['nama_cabang'] = this.namaCabang;
    return data;
  }
}
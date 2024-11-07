class MekanikPromekPKB {
  int? status;
  String? message;
  List<DataMekanikPromek>? dataMekanikPromek;

  MekanikPromekPKB({this.status, this.message, this.dataMekanikPromek});

  MekanikPromekPKB.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['dataMekanikPromek'] != null) {
      dataMekanikPromek = <DataMekanikPromek>[];
      json['dataMekanikPromek'].forEach((v) {
        dataMekanikPromek!.add(new DataMekanikPromek.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.dataMekanikPromek != null) {
      data['dataMekanikPromek'] =
          this.dataMekanikPromek!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataMekanikPromek {
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
  String? companyId;

  DataMekanikPromek(
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
        this.companyId});

  DataMekanikPromek.fromJson(Map<String, dynamic> json) {
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
    companyId = json['company_id'];
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
    data['company_id'] = this.companyId;
    return data;
  }
}
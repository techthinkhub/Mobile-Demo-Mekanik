class PromekProses {
  bool? status;
  String? message;
  List<DataPromek>? dataPromek;

  PromekProses({this.status, this.message, this.dataPromek});

  PromekProses.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['dataPromek'] != null) {
      dataPromek = <DataPromek>[];
      json['dataPromek'].forEach((v) {
        dataPromek!.add(new DataPromek.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.dataPromek != null) {
      data['dataPromek'] = this.dataPromek!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataPromek {
  int? promekId;
  int? idMekanik;
  String? kodeBooking;
  String? kodeJasa;
  String? startPromek;
  String? stopPromek;
  int? menit;
  String? keterangan;
  int? id;
  String? kode;
  String? nama;
  String? hp;
  String? email;
  String? posisi;
  Null? group;
  int? useApp;
  int? deleted;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? cabangId;
  Null? companyId;

  DataPromek(
      {this.promekId,
        this.idMekanik,
        this.kodeBooking,
        this.kodeJasa,
        this.startPromek,
        this.stopPromek,
        this.menit,
        this.keterangan,
        this.id,
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

  DataPromek.fromJson(Map<String, dynamic> json) {
    promekId = json['promek_id'];
    idMekanik = json['id_mekanik'];
    kodeBooking = json['kode_booking'];
    kodeJasa = json['kode_jasa'];
    startPromek = json['start_promek'];
    stopPromek = json['stop_promek'];
    menit = json['menit'];
    keterangan = json['keterangan'];
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
    data['promek_id'] = this.promekId;
    data['id_mekanik'] = this.idMekanik;
    data['kode_booking'] = this.kodeBooking;
    data['kode_jasa'] = this.kodeJasa;
    data['start_promek'] = this.startPromek;
    data['stop_promek'] = this.stopPromek;
    data['menit'] = this.menit;
    data['keterangan'] = this.keterangan;
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
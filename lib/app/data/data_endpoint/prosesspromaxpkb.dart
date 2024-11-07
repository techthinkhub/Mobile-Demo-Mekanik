class ProsesPromex {
  int? status;
  DataProsesMekanik? dataProsesMekanik;

  ProsesPromex({this.status, this.dataProsesMekanik});

  ProsesPromex.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dataProsesMekanik = json['dataProsesMekanik'] != null
        ? new DataProsesMekanik.fromJson(json['dataProsesMekanik'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.dataProsesMekanik != null) {
      data['dataProsesMekanik'] = this.dataProsesMekanik!.toJson();
    }
    return data;
  }
}

class DataProsesMekanik {
  List<Proses>? proses;

  DataProsesMekanik({this.proses});

  DataProsesMekanik.fromJson(Map<String, dynamic> json) {
    if (json['proses'] != null) {
      proses = <Proses>[];
      json['proses'].forEach((v) {
        proses!.add(new Proses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.proses != null) {
      data['proses'] = this.proses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Proses {
  int? id;
  String? kodeSvc;
  String? kodeJasa;
  int? idKaryawan;
  String? startPromek;
  String? stopPromek;
  int? menit;
  String? keterangan;
  String? createdAt;
  String? updatedAt;
  int? promekId;
  String? kode;
  String? nama;
  String? hp;
  String? email;
  String? posisi;
  String? group;
  int? useApp;
  int? deleted;
  String? createdBy;
  int? cabangId;
  String? companyId;

  Proses(
      {this.id,
        this.kodeSvc,
        this.kodeJasa,
        this.idKaryawan,
        this.startPromek,
        this.stopPromek,
        this.menit,
        this.keterangan,
        this.createdAt,
        this.updatedAt,
        this.promekId,
        this.kode,
        this.nama,
        this.hp,
        this.email,
        this.posisi,
        this.group,
        this.useApp,
        this.deleted,
        this.createdBy,
        this.cabangId,
        this.companyId});

  Proses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodeSvc = json['kode_svc'];
    kodeJasa = json['kode_jasa'];
    idKaryawan = json['id_karyawan'];
    startPromek = json['start_promek'];
    stopPromek = json['stop_promek'];
    menit = json['menit'];
    keterangan = json['keterangan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    promekId = json['promek_id'];
    kode = json['kode'];
    nama = json['nama'];
    hp = json['hp'];
    email = json['email'];
    posisi = json['posisi'];
    group = json['group'];
    useApp = json['use_app'];
    deleted = json['deleted'];
    createdBy = json['created_by'];
    cabangId = json['cabang_id'];
    companyId = json['company_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode_svc'] = this.kodeSvc;
    data['kode_jasa'] = this.kodeJasa;
    data['id_karyawan'] = this.idKaryawan;
    data['start_promek'] = this.startPromek;
    data['stop_promek'] = this.stopPromek;
    data['menit'] = this.menit;
    data['keterangan'] = this.keterangan;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['promek_id'] = this.promekId;
    data['kode'] = this.kode;
    data['nama'] = this.nama;
    data['hp'] = this.hp;
    data['email'] = this.email;
    data['posisi'] = this.posisi;
    data['group'] = this.group;
    data['use_app'] = this.useApp;
    data['deleted'] = this.deleted;
    data['created_by'] = this.createdBy;
    data['cabang_id'] = this.cabangId;
    data['company_id'] = this.companyId;
    return data;
  }
}
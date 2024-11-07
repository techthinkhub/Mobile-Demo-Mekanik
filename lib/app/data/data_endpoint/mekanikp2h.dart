class MekanikP2H {
  int? status;
  JasaPromek? jasaPromek;

  MekanikP2H({this.status, this.jasaPromek});

  MekanikP2H.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    jasaPromek = json['jasaPromek'] != null
        ? new JasaPromek.fromJson(json['jasaPromek'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.jasaPromek != null) {
      data['jasaPromek'] = this.jasaPromek!.toJson();
    }
    return data;
  }
}

class JasaPromek {
  List<Mekanik>? mekanik;
  List<Jasa>? jasa;

  JasaPromek({this.mekanik, this.jasa});

  JasaPromek.fromJson(Map<String, dynamic> json) {
    if (json['mekanik'] != null) {
      mekanik = <Mekanik>[];
      json['mekanik'].forEach((v) {
        mekanik!.add(new Mekanik.fromJson(v));
      });
    }
    if (json['jasa'] != null) {
      jasa = <Jasa>[];
      json['jasa'].forEach((v) {
        jasa!.add(new Jasa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mekanik != null) {
      data['mekanik'] = this.mekanik!.map((v) => v.toJson()).toList();
    }
    if (this.jasa != null) {
      data['jasa'] = this.jasa!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mekanik {
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

  Mekanik(
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

  Mekanik.fromJson(Map<String, dynamic> json) {
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

class Jasa {
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

  Jasa(
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

  Jasa.fromJson(Map<String, dynamic> json) {
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
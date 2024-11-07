class MekanikPKB {
  int? status;
  DataJasaMekanik? dataJasaMekanik;

  MekanikPKB({this.status, this.dataJasaMekanik});

  MekanikPKB.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dataJasaMekanik = json['dataJasaMekanik'] != null
        ? DataJasaMekanik.fromJson(json['dataJasaMekanik'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (dataJasaMekanik != null) {
      data['dataJasaMekanik'] = dataJasaMekanik!.toJson();
    }
    return data;
  }
}

class DataJasaMekanik {
  List<Mekanikpkb>? mekanik;
  List<Jasa>? jasa;

  DataJasaMekanik({this.mekanik, this.jasa});

  DataJasaMekanik.fromJson(Map<String, dynamic> json) {
    if (json['mekanik'] != null) {
      mekanik = <Mekanikpkb>[];
      json['mekanik'].forEach((v) {
        mekanik!.add(Mekanikpkb.fromJson(v));
      });
    }
    if (json['jasa'] != null) {
      jasa = <Jasa>[];
      json['jasa'].forEach((v) {
        jasa!.add(Jasa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mekanik != null) {
      data['mekanik'] = mekanik!.map((v) => v.toJson()).toList();
    }
    if (jasa != null) {
      data['jasa'] = jasa!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mekanikpkb {
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

  Mekanikpkb(
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

  Mekanikpkb.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['kode'] = kode;
    data['nama'] = nama;
    data['hp'] = hp;
    data['email'] = email;
    data['posisi'] = posisi;
    data['group'] = group;
    data['use_app'] = useApp;
    data['deleted'] = deleted;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['cabang_id'] = cabangId;
    data['company_id'] = companyId;
    return data;
  }
}

class Jasa {
  int? id;
  String? kodeSvc;
  String? kodeJasa;
  String? namaJasa;
  int? qtyJasa;
  int? hargaJasa;
  int? diskonJasa;
  String? createdAt;
  int? biaya;
  int? jam;
  String? divisiJasa;
  int? deleted;
  String? createdBy;

  Jasa(
      {this.id,
        this.kodeSvc,
        this.kodeJasa,
        this.namaJasa,
        this.qtyJasa,
        this.hargaJasa,
        this.diskonJasa,
        this.createdAt,
        this.biaya,
        this.jam,
        this.divisiJasa,
        this.deleted,
        this.createdBy});

  Jasa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodeSvc = json['kode_svc'];
    kodeJasa = json['kode_jasa'];
    namaJasa = json['nama_jasa'];
    qtyJasa = json['qty_jasa'];
    hargaJasa = json['harga_jasa'];
    diskonJasa = json['diskon_jasa'];
    createdAt = json['created_at'];
    biaya = json['biaya'];
    jam = json['jam'];
    divisiJasa = json['divisi_jasa'];
    deleted = json['deleted'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['kode_svc'] = kodeSvc;
    data['kode_jasa'] = kodeJasa;
    data['nama_jasa'] = namaJasa;
    data['qty_jasa'] = qtyJasa;
    data['harga_jasa'] = hargaJasa;
    data['diskon_jasa'] = diskonJasa;
    data['created_at'] = createdAt;
    data['biaya'] = biaya;
    data['jam'] = jam;
    data['divisi_jasa'] = divisiJasa;
    data['deleted'] = deleted;
    data['created_by'] = createdBy;
    return data;
  }
}

class Getdetailpart {
  bool? status;
  String? message;
  DetailSparepart? detailSparepart;

  Getdetailpart({this.status, this.message, this.detailSparepart});

  factory Getdetailpart.fromJson(Map<String, dynamic> json) {
    return Getdetailpart(
      status: json['status'],
      message: json['message'],
      detailSparepart: json['detailSparepart'] != null
          ? DetailSparepart.fromJson(json['detailSparepart'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'status': status,
      'message': message,
    };
    if (detailSparepart != null) {
      data['detailSparepart'] = detailSparepart!.toJson();
    }
    return data;
  }
}

class DetailSparepart {
  List<Detail>? detail;
  List<Null>? photos;

  DetailSparepart({this.detail, this.photos});

  factory DetailSparepart.fromJson(Map<String, dynamic> json) {
    return DetailSparepart(
      detail: json['detail'] != null
          ? List<Detail>.from(json['detail'].map((x) => Detail.fromJson(x)))
          : null,
      photos: json['photos'] != null
          ? List<Null>.from(json['photos'].map((x) => x))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (detail != null) {
      data['detail'] = detail!.map((v) => v.toJson()).toList();
    }
    if (photos != null) {
      data['photos'] = photos!.map((v) => v).toList();
    }
    return data;
  }
}

class Detail {
  int? id;
  String? kodeSvc;
  String? kodeSparepart;
  String? namaSparepart;
  int? qtySparepart;
  int? hargaSparepart;
  int? diskonSparepart;
  dynamic hidSparepart;
  int? nota;
  String? createdAt;
  dynamic updatedAt;
  String? kodeMaster;
  String? kode;
  dynamic kode2;
  String? nama;
  String? divisi;
  String? brand;
  int? qty;
  int? hargaBeli;
  int? hargaJual;
  dynamic barcode;
  String? satuan;
  dynamic noStock;
  dynamic lokasi;
  dynamic note;
  String? tipe;
  String? kodeSupplier;
  dynamic qtyMin;
  dynamic qtyMax;
  dynamic ukuran;
  String? kualitas;
  int? demandBulanan;
  dynamic emergency;
  String? jenis;
  int? deleted;
  String? createdBy;
  String? gudang;
  int? cabangId;

  Detail({
    this.id,
    this.kodeSvc,
    this.kodeSparepart,
    this.namaSparepart,
    this.qtySparepart,
    this.hargaSparepart,
    this.diskonSparepart,
    this.hidSparepart,
    this.nota,
    this.createdAt,
    this.updatedAt,
    this.kodeMaster,
    this.kode,
    this.kode2,
    this.nama,
    this.divisi,
    this.brand,
    this.qty,
    this.hargaBeli,
    this.hargaJual,
    this.barcode,
    this.satuan,
    this.noStock,
    this.lokasi,
    this.note,
    this.tipe,
    this.kodeSupplier,
    this.qtyMin,
    this.qtyMax,
    this.ukuran,
    this.kualitas,
    this.demandBulanan,
    this.emergency,
    this.jenis,
    this.deleted,
    this.createdBy,
    this.gudang,
    this.cabangId,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json['id'],
      kodeSvc: json['kode_svc'],
      kodeSparepart: json['kode_sparepart'],
      namaSparepart: json['nama_sparepart'],
      qtySparepart: json['qty_sparepart'],
      hargaSparepart: json['harga_sparepart'],
      diskonSparepart: json['diskon_sparepart'],
      hidSparepart: json['hid_sparepart'],
      nota: json['nota'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      kodeMaster: json['kode_master'],
      kode: json['kode'],
      kode2: json['kode_2'],
      nama: json['nama'],
      divisi: json['divisi'],
      brand: json['brand'],
      qty: json['qty'],
      hargaBeli: json['harga_beli'],
      hargaJual: json['harga_jual'],
      barcode: json['barcode'],
      satuan: json['satuan'],
      noStock: json['no_stock'],
      lokasi: json['lokasi'],
      note: json['note'],
      tipe: json['tipe'],
      kodeSupplier: json['kode_supplier'],
      qtyMin: json['qty_min'],
      qtyMax: json['qty_max'],
      ukuran: json['ukuran'],
      kualitas: json['kualitas'],
      demandBulanan: json['demand_bulanan'],
      emergency: json['emergency'],
      jenis: json['jenis'],
      deleted: json['deleted'],
      createdBy: json['created_by'],
      gudang: json['gudang'],
      cabangId: json['cabang_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'kode_svc': kodeSvc,
      'kode_sparepart': kodeSparepart,
      'nama_sparepart': namaSparepart,
      'qty_sparepart': qtySparepart,
      'harga_sparepart': hargaSparepart,
      'diskon_sparepart': diskonSparepart,
      'hid_sparepart': hidSparepart,
      'nota': nota,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'kode_master': kodeMaster,
      'kode': kode,
      'kode_2': kode2,
      'nama': nama,
      'divisi': divisi,
      'brand': brand,
      'qty': qty,
      'harga_beli': hargaBeli,
      'harga_jual': hargaJual,
      'barcode': barcode,
      'satuan': satuan,
      'no_stock': noStock,
      'lokasi': lokasi,
      'note': note,
      'tipe': tipe,
      'kode_supplier': kodeSupplier,
      'qty_min': qtyMin,
      'qty_max': qtyMax,
      'ukuran': ukuran,
      'kualitas': kualitas,
      'demand_bulanan': demandBulanan,
      'emergency': emergency,
      'jenis': jenis,
      'deleted': deleted,
      'created_by': createdBy,
      'gudang': gudang,
      'cabang_id': cabangId,
    };
    return data;
  }
}

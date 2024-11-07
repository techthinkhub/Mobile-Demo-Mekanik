class ServiceDikerjakan {
  bool? status;
  String? message;
  String? namaSD;
  int? countDikerjakan;
  List<DataDikerjakan>? dataDikerjakan;

  ServiceDikerjakan(
      {this.status,
        this.message,
        this.namaSD,
        this.countDikerjakan,
        this.dataDikerjakan});

  ServiceDikerjakan.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    namaSD = json['namaSD'];
    countDikerjakan = json['countDikerjakan'];
    if (json['dataDikerjakan'] != null) {
      dataDikerjakan = <DataDikerjakan>[];
      json['dataDikerjakan'].forEach((v) {
        dataDikerjakan!.add(new DataDikerjakan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['namaSD'] = this.namaSD;
    data['countDikerjakan'] = this.countDikerjakan;
    if (this.dataDikerjakan != null) {
      data['dataDikerjakan'] =
          this.dataDikerjakan!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataDikerjakan {
  int? id;
  String? kodeBooking;
  int? idJenissvc;
  int? idTipe;
  int? idMerk;
  int? idCustomer;
  int? idKendaraan;
  int? idCabang;
  String? jamBooking;
  String? tglBooking;
  String? status;
  String? odometer;
  String? pic;
  String? hpPic;
  String? referensi;
  String? referensiTeman;
  String? keluhan;
  String? perintahKerja;
  String? createdBy;
  int? deleted;
  String? createdAt;
  String? updatedAt;
  String? berita;
  String? kode;
  String? typeOrder;

  DataDikerjakan(
      {this.id,
        this.kodeBooking,
        this.idJenissvc,
        this.idTipe,
        this.idMerk,
        this.idCustomer,
        this.idKendaraan,
        this.idCabang,
        this.jamBooking,
        this.tglBooking,
        this.status,
        this.odometer,
        this.pic,
        this.hpPic,
        this.referensi,
        this.referensiTeman,
        this.keluhan,
        this.perintahKerja,
        this.createdBy,
        this.deleted,
        this.createdAt,
        this.updatedAt,
        this.berita,
        this.kode,
        this.typeOrder});

  DataDikerjakan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodeBooking = json['kode_booking'];
    idJenissvc = json['id_jenissvc'];
    idTipe = json['id_tipe'];
    idMerk = json['id_merk'];
    idCustomer = json['id_customer'];
    idKendaraan = json['id_kendaraan'];
    idCabang = json['id_cabang'];
    jamBooking = json['jam_booking'];
    tglBooking = json['tgl_booking'];
    status = json['status'];
    odometer = json['odometer'];
    pic = json['pic'];
    hpPic = json['hp_pic'];
    referensi = json['referensi'];
    referensiTeman = json['referensi_teman'];
    keluhan = json['keluhan'];
    perintahKerja = json['perintah_kerja'];
    createdBy = json['created_by'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    berita = json['berita'];
    kode = json['kode'];
    typeOrder = json['type_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode_booking'] = this.kodeBooking;
    data['id_jenissvc'] = this.idJenissvc;
    data['id_tipe'] = this.idTipe;
    data['id_merk'] = this.idMerk;
    data['id_customer'] = this.idCustomer;
    data['id_kendaraan'] = this.idKendaraan;
    data['id_cabang'] = this.idCabang;
    data['jam_booking'] = this.jamBooking;
    data['tgl_booking'] = this.tglBooking;
    data['status'] = this.status;
    data['odometer'] = this.odometer;
    data['pic'] = this.pic;
    data['hp_pic'] = this.hpPic;
    data['referensi'] = this.referensi;
    data['referensi_teman'] = this.referensiTeman;
    data['keluhan'] = this.keluhan;
    data['perintah_kerja'] = this.perintahKerja;
    data['created_by'] = this.createdBy;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['berita'] = this.berita;
    data['kode'] = this.kode;
    data['type_order'] = this.typeOrder;
    return data;
  }
}
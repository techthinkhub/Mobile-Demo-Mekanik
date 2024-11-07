class Approve {
  bool? success;
  String? message;
  DataApprove? dataApprove;

  Approve({this.success, this.message, this.dataApprove});

  Approve.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    dataApprove = json['dataApprove'] != null
        ? new DataApprove.fromJson(json['dataApprove'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.dataApprove != null) {
      data['dataApprove'] = this.dataApprove!.toJson();
    }
    return data;
  }
}

class DataApprove {
  String? nama;
  String? email;
  String? noPolisi;
  String? kendaraanKode;
  String? merk;
  String? tipe;
  int? id;
  String? kodeBooking;
  String? idJenissvc;
  String? idTipe;
  String? idMerk;
  String? idCustomer;
  String? idKendaraan;
  String? idCabang;
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
  String? lokasiBengkel;
  String? jenisLayanan;

  DataApprove(
      {this.nama,
        this.email,
        this.noPolisi,
        this.kendaraanKode,
        this.merk,
        this.tipe,
        this.id,
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
        this.typeOrder,
        this.lokasiBengkel,
        this.jenisLayanan});

  DataApprove.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    email = json['email'];
    noPolisi = json['no_polisi'];
    kendaraanKode = json['kendaraan_kode'];
    merk = json['merk'];
    tipe = json['tipe'];
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
    lokasiBengkel = json['lokasi_bengkel'];
    jenisLayanan = json['jenis_layanan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['email'] = this.email;
    data['no_polisi'] = this.noPolisi;
    data['kendaraan_kode'] = this.kendaraanKode;
    data['merk'] = this.merk;
    data['tipe'] = this.tipe;
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
    data['lokasi_bengkel'] = this.lokasiBengkel;
    data['jenis_layanan'] = this.jenisLayanan;
    return data;
  }
}
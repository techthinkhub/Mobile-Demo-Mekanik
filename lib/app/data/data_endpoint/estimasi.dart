class Estimasi {
  bool? success;
  String? message;
  DataEstimasi? dataEstimasi;

  Estimasi({this.success, this.message, this.dataEstimasi});

  Estimasi.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    dataEstimasi = json['dataEstimasi'] != null
        ? new DataEstimasi.fromJson(json['dataEstimasi'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.dataEstimasi != null) {
      data['dataEstimasi'] = this.dataEstimasi!.toJson();
    }
    return data;
  }
}

class DataEstimasi {
  int? id;
  String? kodeBooking;
  int? cabangId;
  String? kodeSvc;
  String? kodeEstimasi;
  String? kodePkb;
  String? kodePelanggan;
  String? kodeKendaraan;
  String? odometer;
  String? pic;
  String? hpPic;
  String? kodeMembership;
  String? kodePaketmember;
  String? tipeSvc;
  String? tipePelanggan;
  String? referensi;
  String? referensiTeman;
  String? poNumber;
  String? paketSvc;
  String? tglKeluar;
  String? tglKembali;
  String? kmKeluar;
  String? kmKembali;
  String? keluhan;
  String? perintahKerja;
  String? pergantianPart;
  String? saran;
  String? ppn;
  String? penanggungJawab;
  String? tglEstimasi;
  String? tglPkb;
  String? tglTutup;
  String? jamEstimasiSelesai;
  String? jamSelesai;
  int? pkb;
  int? tutup;
  int? faktur;
  int? deleted;
  int? notab;
  String? createdBy;
  String? createdByPkb;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;

  DataEstimasi(
      {this.id,
        this.kodeBooking,
        this.cabangId,
        this.kodeSvc,
        this.kodeEstimasi,
        this.kodePkb,
        this.kodePelanggan,
        this.kodeKendaraan,
        this.odometer,
        this.pic,
        this.hpPic,
        this.kodeMembership,
        this.kodePaketmember,
        this.tipeSvc,
        this.tipePelanggan,
        this.referensi,
        this.referensiTeman,
        this.poNumber,
        this.paketSvc,
        this.tglKeluar,
        this.tglKembali,
        this.kmKeluar,
        this.kmKembali,
        this.keluhan,
        this.perintahKerja,
        this.pergantianPart,
        this.saran,
        this.ppn,
        this.penanggungJawab,
        this.tglEstimasi,
        this.tglPkb,
        this.tglTutup,
        this.jamEstimasiSelesai,
        this.jamSelesai,
        this.pkb,
        this.tutup,
        this.faktur,
        this.deleted,
        this.notab,
        this.createdBy,
        this.createdByPkb,
        this.createdAt,
        this.updatedBy,
        this.updatedAt});

  DataEstimasi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodeBooking = json['kode_booking'];
    cabangId = json['cabang_id'];
    kodeSvc = json['kode_svc'];
    kodeEstimasi = json['kode_estimasi'];
    kodePkb = json['kode_pkb'];
    kodePelanggan = json['kode_pelanggan'];
    kodeKendaraan = json['kode_kendaraan'];
    odometer = json['odometer'];
    pic = json['pic'];
    hpPic = json['hp_pic'];
    kodeMembership = json['kode_membership'];
    kodePaketmember = json['kode_paketmember'];
    tipeSvc = json['tipe_svc'];
    tipePelanggan = json['tipe_pelanggan'];
    referensi = json['referensi'];
    referensiTeman = json['referensi_teman'];
    poNumber = json['po_number'];
    paketSvc = json['paket_svc'];
    tglKeluar = json['tgl_keluar'];
    tglKembali = json['tgl_kembali'];
    kmKeluar = json['km_keluar'];
    kmKembali = json['km_kembali'];
    keluhan = json['keluhan'];
    perintahKerja = json['perintah_kerja'];
    pergantianPart = json['pergantian_part'];
    saran = json['saran'];
    ppn = json['ppn'];
    penanggungJawab = json['penanggung_jawab'];
    tglEstimasi = json['tgl_estimasi'];
    tglPkb = json['tgl_pkb'];
    tglTutup = json['tgl_tutup'];
    jamEstimasiSelesai = json['jam_estimasi_selesai'];
    jamSelesai = json['jam_selesai'];
    pkb = json['pkb'];
    tutup = json['tutup'];
    faktur = json['faktur'];
    deleted = json['deleted'];
    notab = json['notab'];
    createdBy = json['created_by'];
    createdByPkb = json['created_by_pkb'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kode_booking'] = this.kodeBooking;
    data['cabang_id'] = this.cabangId;
    data['kode_svc'] = this.kodeSvc;
    data['kode_estimasi'] = this.kodeEstimasi;
    data['kode_pkb'] = this.kodePkb;
    data['kode_pelanggan'] = this.kodePelanggan;
    data['kode_kendaraan'] = this.kodeKendaraan;
    data['odometer'] = this.odometer;
    data['pic'] = this.pic;
    data['hp_pic'] = this.hpPic;
    data['kode_membership'] = this.kodeMembership;
    data['kode_paketmember'] = this.kodePaketmember;
    data['tipe_svc'] = this.tipeSvc;
    data['tipe_pelanggan'] = this.tipePelanggan;
    data['referensi'] = this.referensi;
    data['referensi_teman'] = this.referensiTeman;
    data['po_number'] = this.poNumber;
    data['paket_svc'] = this.paketSvc;
    data['tgl_keluar'] = this.tglKeluar;
    data['tgl_kembali'] = this.tglKembali;
    data['km_keluar'] = this.kmKeluar;
    data['km_kembali'] = this.kmKembali;
    data['keluhan'] = this.keluhan;
    data['perintah_kerja'] = this.perintahKerja;
    data['pergantian_part'] = this.pergantianPart;
    data['saran'] = this.saran;
    data['ppn'] = this.ppn;
    data['penanggung_jawab'] = this.penanggungJawab;
    data['tgl_estimasi'] = this.tglEstimasi;
    data['tgl_pkb'] = this.tglPkb;
    data['tgl_tutup'] = this.tglTutup;
    data['jam_estimasi_selesai'] = this.jamEstimasiSelesai;
    data['jam_selesai'] = this.jamSelesai;
    data['pkb'] = this.pkb;
    data['tutup'] = this.tutup;
    data['faktur'] = this.faktur;
    data['deleted'] = this.deleted;
    data['notab'] = this.notab;
    data['created_by'] = this.createdBy;
    data['created_by_pkb'] = this.createdByPkb;
    data['created_at'] = this.createdAt;
    data['updated_by'] = this.updatedBy;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
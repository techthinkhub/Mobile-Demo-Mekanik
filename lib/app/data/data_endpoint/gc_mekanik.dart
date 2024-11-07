class GCMekanik {
  List<DataGeneralCheckUp>? dataGeneralCheckUp;

  GCMekanik({this.dataGeneralCheckUp});

  GCMekanik.fromJson(Map<String, dynamic> json) {
    if (json['dataGeneralCheckUp'] != null) {
      dataGeneralCheckUp = <DataGeneralCheckUp>[];
      json['dataGeneralCheckUp'].forEach((v) {
        dataGeneralCheckUp!.add(new DataGeneralCheckUp.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataGeneralCheckUp != null) {
      data['dataGeneralCheckUp'] =
          this.dataGeneralCheckUp!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataGeneralCheckUp {
  int? subHeadingId;
  int? kategoriKendaraanId;
  String? subHeading;
  List<Gcus>? gcus;

  DataGeneralCheckUp(
      {this.subHeadingId,
        this.kategoriKendaraanId,
        this.subHeading,
        this.gcus});

  DataGeneralCheckUp.fromJson(Map<String, dynamic> json) {
    subHeadingId = json['sub_heading_id'];
    kategoriKendaraanId = json['kategori_kendaraan_id'];
    subHeading = json['sub_heading'];
    if (json['gcus'] != null) {
      gcus = <Gcus>[];
      json['gcus'].forEach((v) {
        gcus!.add(new Gcus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_heading_id'] = this.subHeadingId;
    data['kategori_kendaraan_id'] = this.kategoriKendaraanId;
    data['sub_heading'] = this.subHeading;
    if (this.gcus != null) {
      data['gcus'] = this.gcus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gcus {
  int? gcuId;
  String? gcu;

  Gcus({this.gcuId, this.gcu});

  Gcus.fromJson(Map<String, dynamic> json) {
    gcuId = json['gcu_id'];
    gcu = json['gcu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gcu_id'] = this.gcuId;
    data['gcu'] = this.gcu;
    return data;
  }
}
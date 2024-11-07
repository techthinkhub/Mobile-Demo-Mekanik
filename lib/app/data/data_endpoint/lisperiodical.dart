class ListPeriodical {
  List<DataPeriodicalMaintenance>? dataPeriodicalMaintenance;

  ListPeriodical({this.dataPeriodicalMaintenance});

  ListPeriodical.fromJson(Map<String, dynamic> json) {
    if (json['dataPeriodicalMaintenance'] != null) {
      dataPeriodicalMaintenance = <DataPeriodicalMaintenance>[];
      json['dataPeriodicalMaintenance'].forEach((v) {
        dataPeriodicalMaintenance!
            .add(new DataPeriodicalMaintenance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataPeriodicalMaintenance != null) {
      data['dataPeriodicalMaintenance'] =
          this.dataPeriodicalMaintenance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataPeriodicalMaintenance {
  int? subHeadingId;
  int? kategoriKendaraanId;
  String? subHeading;
  List<Gcus>? gcus;

  DataPeriodicalMaintenance(
      {this.subHeadingId,
        this.kategoriKendaraanId,
        this.subHeading,
        this.gcus});

  DataPeriodicalMaintenance.fromJson(Map<String, dynamic> json) {
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

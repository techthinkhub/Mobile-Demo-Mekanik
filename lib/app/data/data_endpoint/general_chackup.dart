class general_checkup {
  List<Data>? data;

  general_checkup({this.data});

  general_checkup.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? subHeadingId;
  String? subHeading;
  List<Gcus>? gcus;

  Data({this.subHeadingId, this.subHeading, this.gcus});

  Data.fromJson(Map<String, dynamic> json) {
    subHeadingId = json['sub_heading_id'];
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
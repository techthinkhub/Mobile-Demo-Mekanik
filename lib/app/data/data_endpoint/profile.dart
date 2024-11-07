class Profile {
  bool? status;
  String? message;
  Data? data;

  Profile({this.status, this.message, this.data});

  Profile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? namaKaryawan;
  String? email;
  String? hp;
  String? cabang;


  Data({this.namaKaryawan, this.email, this.hp, this.cabang, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaKaryawan = json['nama_karyawan'];
    email = json['email'];
    hp = json['hp'];
    cabang = json['cabang'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_karyawan'] = this.namaKaryawan;
    data['email'] = this.email;
    data['hp'] = this.hp;
    data['cabang'] = this.cabang;
    return data;
  }
}
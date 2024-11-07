class AbsenMasuk {
  String? status;
  String? message;

  AbsenMasuk({this.status, this.message});

  AbsenMasuk.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
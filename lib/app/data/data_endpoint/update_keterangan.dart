class UpdateKeterangan {
  bool? status;
  String? message;
  int? updatePromek;

  UpdateKeterangan({this.status, this.message, this.updatePromek});

  UpdateKeterangan.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    updatePromek = json['updatePromek'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['updatePromek'] = this.updatePromek;
    return data;
  }
}
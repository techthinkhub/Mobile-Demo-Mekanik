class Unapprove {
  bool? success;
  String? message;
  String? catatan;

  Unapprove({this.success, this.message, this.catatan});

  Unapprove.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    catatan = json['catatan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['catatan'] = this.catatan;
    return data;
  }
}
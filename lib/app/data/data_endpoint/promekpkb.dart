class PromePKB {
  int? status;
  String? message;

  PromePKB({this.status, this.message});

  PromePKB.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int?;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

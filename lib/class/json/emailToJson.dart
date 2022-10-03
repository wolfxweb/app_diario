class emailToJson {
  int? id;
  String? email;
  String? status;
  String? code;
  String? pass;

  emailToJson(this.id, this.email, this.status, this.code, this.pass);

  emailToJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    status = json['status'];
    code = json['code'];
    pass = json['pass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['status'] = this.status;
    data['code'] = this.code;
    data['pass'] = this.pass;
    return data;
  }
}
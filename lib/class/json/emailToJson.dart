class emailToJson {
  int? id;
  String? email;
  String? status;
  String? code;
  String? senha;

  emailToJson(this.id, this.email, this.status, this.code, this.senha);

  emailToJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    status = json['status'];
    code = json['code'];
    senha = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['status'] = this.status;
    data['code'] = this.code;
    data['senha'] = this.senha;
    return data;
  }
}
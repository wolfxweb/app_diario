class noteToJson {
  int? id;
  String? anotacao;
  String? data;

  noteToJson({this.id, this.anotacao, this.data});

  noteToJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    anotacao = json['anotacao'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['anotacao'] = this.anotacao;
    data['data'] = this.data;
    return data;
  }
}
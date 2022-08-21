class noteToJson {
  int? id;
  String? anotacao;
  String? humor;

  noteToJson(this.id, this.anotacao, this.humor);

  noteToJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    anotacao = json['anotacao'];
    humor = json['humor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['anotacao'] = this.anotacao;
    data['humor'] = this.humor;
    return data;
  }
}
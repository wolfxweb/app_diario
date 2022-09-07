class noteToJson {
  int? id;
  String? anotacao;
  String? humor;
  String? titulo;

  noteToJson(this.id, this.anotacao,this.humor , this.titulo);

  noteToJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    anotacao = json['anotacao'];
    humor = json['humor'];
    titulo = json['titulo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['anotacao'] = this.anotacao;
    data['humor'] = this.humor;
    data['titulo'] = this.titulo;
    return data;
  }
}
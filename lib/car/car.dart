class CarType {
  static final classicos = "classicos";
  static final esportivos = "esportivos";
  static final luxo = "luxo";
}

class Car {
  int? id;
  String? tipo;
  String? nome;
  String? desc;
  String? urlFoto;
  String? urlVideo;
  String? latitude;
  String? longitude;

  Car({
    this.nome,
    this.desc,
    this.urlFoto,
    this.id,
    this.tipo,
    this.urlVideo,
    this.latitude,
    this.longitude,
  });

  Car.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        tipo = json['tipo'],
        nome = json['nome'],
        desc = json['desc'],
        urlFoto = json['urlFoto'],
        urlVideo = json['urlVideo'],
        latitude = json['latitude'],
        longitude = json['longitude'];

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'tipo': this.tipo,
        'nome': this.nome,
        'desc': this.desc,
        'urlFoto': this.urlFoto,
        'urlVideo': this.urlVideo,
        'latitude': this.latitude,
        'longitude': this.longitude,
      };
}

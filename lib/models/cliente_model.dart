import 'dart:convert';

ClienteModel clienteModelFromJson(String str) =>
    ClienteModel.fromJson(json.decode(str));

String clienteModelToJson(ClienteModel data) => json.encode(data.toJson());

class ClienteModel {
  ClienteModel({
    this.id,
    this.nombre,
    this.direccion,
  });

  String id;
  String nombre;
  String direccion;

  factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
        id: json["id"],
        nombre: json["nombre"],
        direccion: json["direccion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
      };
}

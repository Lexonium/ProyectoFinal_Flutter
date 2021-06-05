import 'dart:convert';

OrdenModel ordenModelFromJson(String str) =>
    OrdenModel.fromJson(json.decode(str));

String ordenModelToJson(OrdenModel data) => json.encode(data.toJson());

class OrdenModel {
  OrdenModel({
    this.idOrden,
    this.cantidadproducto,
    this.dirEntrega,
    this.idCliente,
    this.idEmpleado,
    this.idProducto,
    this.nombreCliente,
    this.nombreEmpleado,
    this.nombreProducto,
    this.total,
  });

  int cantidadproducto;
  String idOrden;
  String dirEntrega;
  String idCliente;
  String idEmpleado;
  String idProducto;
  String nombreCliente;
  String nombreEmpleado;
  String nombreProducto;
  double total;

  factory OrdenModel.fromJson(Map<String, dynamic> json) => OrdenModel(
        cantidadproducto: json["cantidadproducto"],
        dirEntrega: json["dirEntrega"],
        idCliente: json["idCliente"],
        idEmpleado: json["idEmpleado"],
        idProducto: json["idProducto"],
        nombreCliente: json["nombreCliente"],
        nombreEmpleado: json["nombreEmpleado"],
        nombreProducto: json["nombreProducto"],
        total: json["total"]?.toDouble(),
        idOrden: json['idOrden'],
      );

  Map<String, dynamic> toJson() => {
        "cantidadproducto": cantidadproducto,
        "dirEntrega": dirEntrega,
        "idCliente": idCliente,
        "idEmpleado": idEmpleado,
        "idProducto": idProducto,
        "nombreCliente": nombreCliente,
        "nombreEmpleado": nombreEmpleado,
        "nombreProducto": nombreProducto,
        "total": total,
        "idOrden": idOrden
      };
  double getLat() {
    List<String> coord = dirEntrega.split(',');
    return double.parse(coord[0].trim());
  }

  double getLng() {
    List<String> coord = dirEntrega.split(',');
    return double.parse(coord[1].trim());
  }
}

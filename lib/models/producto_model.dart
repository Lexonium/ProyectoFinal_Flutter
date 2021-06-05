import 'dart:convert';

ProductoModel productoModelFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  ProductoModel({
    this.idProducto,
    this.nombreProducto = "",
    this.descripcion = "",
    this.stringFoto,
    this.precio = 0.0,
  });

  String idProducto;
  String nombreProducto;
  String descripcion;
  String stringFoto;
  double precio;

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        idProducto: json["id_producto"],
        nombreProducto: json["nombreProducto"],
        descripcion: json["descripcion"],
        stringFoto: json["string_foto"],
        precio: json["precio"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id_producto": idProducto,
        "nombreProducto": nombreProducto,
        "descripcion": descripcion,
        "string_foto": stringFoto,
        "precio": precio,
      };
}

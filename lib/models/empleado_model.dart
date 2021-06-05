import 'dart:convert';

EmpleadoModel empleadoModelFromJson(String str) =>
    EmpleadoModel.fromJson(json.decode(str));

String empleadoModelToJson(EmpleadoModel data) => json.encode(data.toJson());

class EmpleadoModel {
  EmpleadoModel({
    this.idEmpleado,
    this.nombre,
    this.puesto,
    this.stringFoto,
    this.sueldo,
  });

  String idEmpleado;
  String nombre;
  String puesto;
  String stringFoto;
  double sueldo;

  factory EmpleadoModel.fromJson(Map<String, dynamic> json) => EmpleadoModel(
        idEmpleado: json["id_empleado"],
        nombre: json["nombre"],
        puesto: json["puesto"],
        stringFoto: json["string_foto"],
        sueldo: json["sueldo"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id_empleado": idEmpleado,
        "nombre": nombre,
        "puesto": puesto,
        "string_foto": stringFoto,
        "sueldo": sueldo,
      };
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/empleado_model.dart';

class EmpleadosProvider {
  final String _url =
      'https://flutter-curso-a788e-default-rtdb.firebaseio.com/';

  Future<bool> crearEmpleado(EmpleadoModel empleado) async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    final url = '$_url/Empleados.json';

    final resp = await http.post(url, body: empleadoModelToJson(empleado));
    final decodedDaata = json.decode(resp.body);

    print(decodedDaata);
    return true;
  }

  Future<bool> modificarEmpleado(EmpleadoModel empleado) async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    final url = '$_url/Empleados/${empleado.idEmpleado}.json';

    final resp = await http.put(url, body: empleadoModelToJson(empleado));
    final decodedDaata = json.decode(resp.body);

    print(decodedDaata);
    return true;
  }

  Future<List<EmpleadoModel>> cargarEmpleados() async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    final url = '$_url/Empleados.json';

    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<EmpleadoModel> empleados = List();

    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      final empTemp = EmpleadoModel.fromJson(value);
      empTemp.idEmpleado = key;
      empleados.add(empTemp);
    });

    return empleados;
  }

  Future<List<String>> cargarEmpleadosNombre() async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    final url = '$_url/Empleados.json';

    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<EmpleadoModel> empleados = List();
    final List<String> nombres = List();

    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      final empTemp = EmpleadoModel.fromJson(value);
      empTemp.idEmpleado = key;
      empleados.add(empTemp);
      nombres.add(empTemp.nombre);
    });

    return nombres;
  }

  Future<int> eliminarProducto(String id) async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos/-MZAnaCf9nB3i3TnDByL.json
    final url = '$_url/Empleados/$id.json';

    final resp = await http.delete(url);
    print(json.decode(resp.body)); // null

    return -1;
  }
}

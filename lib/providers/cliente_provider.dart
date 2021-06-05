import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/cliente_model.dart';

class ClienteProvider {
  final String _url =
      'https://flutter-curso-a788e-default-rtdb.firebaseio.com/';

  Future<bool> crearCliente(ClienteModel cliente) async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    final url = '$_url/Clientes.json';

    final resp = await http.post(url, body: clienteModelToJson(cliente));
    final decodedDaata = json.decode(resp.body);

    print(decodedDaata);
    return true;
  }

  Future<bool> modificarCliente(ClienteModel cliente) async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    final url = '$_url/Clientes/${cliente.id}.json';

    final resp = await http.put(url, body: clienteModelToJson(cliente));
    final decodedDaata = json.decode(resp.body);

    print(decodedDaata);
    return true;
  }

  Future<List<ClienteModel>> cargarClientes() async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    final url = '$_url/Clientes.json';

    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ClienteModel> empleados = List();

    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      final empTemp = ClienteModel.fromJson(value);
      empTemp.id = key;
      empleados.add(empTemp);
    });

    return empleados;
  }

  Future<List<String>> cargarNombreClientes() async {
    final url = '$_url/Clientes.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ClienteModel> empleados = List();
    final List<String> nombres = List();

    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      final empTemp = ClienteModel.fromJson(value);
      empTemp.id = key;
      empleados.add(empTemp);
      nombres.add(empTemp.nombre);
    });

    return nombres;
  }

  Future<int> eliminarCliente(String id) async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos/-MZAnaCf9nB3i3TnDByL.json
    final url = '$_url/Clientes/$id.json';

    final resp = await http.delete(url);
    print(json.decode(resp.body)); // null

    return -1;
  }
}

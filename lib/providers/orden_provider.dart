import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/orden_model.dart';

class OrdenesProvider {
  final String _url =
      'https://flutter-curso-a788e-default-rtdb.firebaseio.com/';

  Future<bool> crearorden(OrdenModel orden) async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    final url = '$_url/Ordenes.json';

    final resp = await http.post(url, body: ordenModelToJson(orden));
    final decodedDaata = json.decode(resp.body);

    print(decodedDaata);
    return true;
  }

  Future<bool> modificarOrden(OrdenModel orden) async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    final url = '$_url/Ordenes/${orden.idOrden}.json';

    final resp = await http.put(url, body: ordenModelToJson(orden));
    final decodedDaata = json.decode(resp.body);

    print(decodedDaata);
    return true;
  }

  Future<List<OrdenModel>> cargarOrdenes() async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    final url = '$_url/Ordenes.json';

    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<OrdenModel> productos = List();

    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      final prodTemp = OrdenModel.fromJson(value);
      prodTemp.idOrden = key;
      productos.add(prodTemp);
    });

    return productos;
  }

  Future<int> eliminarOrdenes(String id) async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos/-MZAnaCf9nB3i3TnDByL.json
    final url = '$_url/Ordenes/$id.json';

    final resp = await http.delete(url);
    print(json.decode(resp.body)); // null

    return -1;
  }
}

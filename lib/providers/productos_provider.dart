import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/producto_model.dart';

class ProductosProvider {
  final String _url =
      'https://flutter-curso-a788e-default-rtdb.firebaseio.com/';

  Future<bool> crearProducto(ProductoModel producto) async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    final url = '$_url/productos.json';

    final resp = await http.post(url, body: productoModelToJson(producto));
    final decodedDaata = json.decode(resp.body);

    print(decodedDaata);
    return true;
  }

  Future<bool> modificarProducto(ProductoModel producto) async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    final url = '$_url/productos/${producto.idProducto}.json';

    final resp = await http.put(url, body: productoModelToJson(producto));
    final decodedDaata = json.decode(resp.body);

    print(decodedDaata);
    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos
    final url = '$_url/productos.json';

    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = List();

    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      final prodTemp = ProductoModel.fromJson(value);
      prodTemp.idProducto = key;
      productos.add(prodTemp);
    });
    return productos;
  }

  Future<List<String>> cargarNombreProductos() async {
    final url = '$_url/productos.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> empleados = List();
    final List<String> nombres = List();

    if (decodedData == null) return [];

    decodedData.forEach((key, value) {
      final empTemp = ProductoModel.fromJson(value);
      empTemp.idProducto = key;
      empleados.add(empTemp);
      nombres.add(empTemp.nombreProducto);
    });

    return nombres;
  }

  Future<int> eliminarProducto(String id) async {
    // https://flutter-curso-5f131-default-rtdb.firebaseio.com/productos/-MZAnaCf9nB3i3TnDByL.json
    final url = '$_url/productos/$id.json';

    final resp = await http.delete(url);
    print(json.decode(resp.body)); // null

    return -1;
  }
}

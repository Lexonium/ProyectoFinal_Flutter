import 'package:flutter/material.dart';
import 'package:proyecto_final/models/producto_model.dart';
import 'package:proyecto_final/providers/productos_provider.dart';

class ProductoPage extends StatefulWidget {
  //const HomePage({Key key}) : super(key: key);

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final ProductosProvider productosProvider = new ProductosProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'creapro')
          .then((value) => setState(() {})),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        List<ProductoModel> productos = snapshot.data;

        return ListView.builder(
          itemCount: productos.length,
          itemBuilder: (context, i) => _crearItem(context, productos[i]),
        );
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel prod) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        productosProvider.eliminarProducto(prod.idProducto);
      },
      child: Card(
        child: Column(
          children: [
            (prod.stringFoto == null)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    image: NetworkImage(prod.stringFoto),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ListTile(
              title: Text('${prod.nombreProducto} - ${prod.precio}'),
              subtitle: Text('${prod.idProducto}'),
              onTap: () =>
                  Navigator.pushNamed(context, 'creapro', arguments: prod)
                      .then((value) => setState(() {})),
            ),
          ],
        ),
      ),
    );
  }
}

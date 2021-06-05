import 'package:flutter/material.dart';
import 'package:proyecto_final/models/orden_model.dart';
import 'package:proyecto_final/providers/orden_provider.dart';

class OrdenesPage extends StatefulWidget {
  //OrdenesPage({Key key}) : super(key: key);

  @override
  _OrdenesPageState createState() => _OrdenesPageState();
}

class _OrdenesPageState extends State<OrdenesPage> {
  final OrdenesProvider ordenesProvider = new OrdenesProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add_shopping_cart_rounded),
      backgroundColor: Colors.orangeAccent,
      onPressed: () => Navigator.pushNamed(context, 'creaord')
          .then((value) => setState(() {})),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: ordenesProvider.cargarOrdenes(),
      builder:
          (BuildContext context, AsyncSnapshot<List<OrdenModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        List<OrdenModel> ordenes = snapshot.data;

        return ListView.builder(
          itemCount: ordenes.length,
          itemBuilder: (context, i) => _crearItem(context, ordenes[i]),
        );
      },
    );
  }

  Widget _crearItem(BuildContext context, OrdenModel ord) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        ordenesProvider.eliminarOrdenes(ord.idOrden);
      },
      child: Card(
        child: ListTile(
          leading: IconButton(
            icon: Icon(Icons.add_shopping_cart_rounded),
            onPressed: () =>
                Navigator.pushNamed(context, 'creaord', arguments: ord)
                    .then((value) => setState(() {})),
          ),
          title: Text('${ord.idOrden} - para : ${ord.nombreCliente}'),
          subtitle: Text(
              '${ord.nombreProducto} x ${ord.cantidadproducto}, total: ${ord.total}'),
          trailing: IconButton(
            icon: Icon(
              Icons.assistant_navigation,
              color: Colors.blueAccent,
            ),
            onPressed: () =>
                Navigator.pushNamed(context, 'mapa', arguments: ord)
                    .then((value) => setState(() {})),
          ),
        ),
      ),
    );
  }
}

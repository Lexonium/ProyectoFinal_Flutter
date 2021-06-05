import 'package:flutter/material.dart';
import 'package:proyecto_final/models/cliente_model.dart';
import 'package:proyecto_final/providers/cliente_provider.dart';

class ClientePage extends StatefulWidget {
  //ClientePage({Key key}) : super(key: key);

  @override
  _ClientePageState createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  final ClienteProvider clienteProvider = new ClienteProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.person_add_alt_1),
      backgroundColor: Colors.orangeAccent,
      onPressed: () => Navigator.pushNamed(context, 'creacli')
          .then((value) => setState(() {})),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: clienteProvider.cargarClientes(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ClienteModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        List<ClienteModel> productos = snapshot.data;

        return ListView.builder(
          itemCount: productos.length,
          itemBuilder: (context, i) => _crearItem(context, productos[i]),
        );
      },
    );
  }

  Widget _crearItem(BuildContext context, ClienteModel prod) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        clienteProvider.eliminarCliente(prod.id);
      },
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person_outline_rounded),
              title: Text('${prod.nombre}'),
              subtitle: Text('${prod.direccion}'),
              onTap: () =>
                  Navigator.pushNamed(context, 'creacli', arguments: prod)
                      .then((value) => setState(() {})),
            ),
          ],
        ),
      ),
    );
  }
}

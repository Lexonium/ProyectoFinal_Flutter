import 'package:flutter/material.dart';
import 'package:proyecto_final/models/empleado_model.dart';
import 'package:proyecto_final/providers/empleados_provider.dart';

class EmpleadoPage extends StatefulWidget {
  //EmpleadoPage({Key key}) : super(key: key);

  @override
  _EmpleadoPageState createState() => _EmpleadoPageState();
}

class _EmpleadoPageState extends State<EmpleadoPage> {
  final EmpleadosProvider empleadosProvider = new EmpleadosProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _crearListadoEmpleado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'creaemp')
          .then((value) => setState(() {})),
    );
  }

  Widget _crearListadoEmpleado() {
    return FutureBuilder(
      future: empleadosProvider.cargarEmpleados(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return _crearEmpleadosPageView(snapshot.data);
      },
    );
  }

  Widget _crearEmpleadosPageView(List<EmpleadoModel> empleados) {
    return SizedBox(
      height: 500.0,
      child: PageView.builder(
          controller: PageController(initialPage: 0, viewportFraction: 0.7),
          itemCount: empleados.length,
          itemBuilder: (context, i) {
            return _actorTarjeta(empleados[i]);
          }),
    );
  }

  Widget _actorTarjeta(EmpleadoModel empleado) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      direction: DismissDirection.down,
      onDismissed: (direction) {
        empleadosProvider.eliminarProducto(empleado.idEmpleado);
      },
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: [
            (empleado.stringFoto == null)
                ? Image(image: AssetImage('assets/fotoEmpleado.png'))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      image: NetworkImage(empleado.stringFoto),
                      height: 375,
                      fit: BoxFit.cover,
                    ),
                  ),
            ListTile(
              title: Text(
                "${empleado.nombre} - '${empleado.puesto}",
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () =>
                  Navigator.pushNamed(context, 'creaemp', arguments: empleado)
                      .then((value) => setState(() {})),
            ),
          ],
        ),
      ),
    );
  }
}

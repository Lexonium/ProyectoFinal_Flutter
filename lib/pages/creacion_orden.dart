import 'package:flutter/material.dart';
import 'package:proyecto_final/models/cliente_model.dart';
import 'package:proyecto_final/models/empleado_model.dart';
import 'package:proyecto_final/models/orden_model.dart';
import 'package:proyecto_final/models/producto_model.dart';
import 'package:proyecto_final/providers/cliente_provider.dart';
import 'package:proyecto_final/providers/empleados_provider.dart';
import 'package:proyecto_final/providers/orden_provider.dart';
import 'package:proyecto_final/providers/productos_provider.dart';

class CreacionOrdenPage extends StatefulWidget {
  //CreacionOrdenPage({Key key}) : super(key: key);

  @override
  _CreacionOrdenPageState createState() => _CreacionOrdenPageState();
}

class _CreacionOrdenPageState extends State<CreacionOrdenPage> {
  final formKey = GlobalKey<FormState>();
  final scapffoldKey = GlobalKey<ScaffoldState>();
  final prodProvider = new ProductosProvider();
  final empProvider = new EmpleadosProvider();
  final clienteProvider = new ClienteProvider();
  final ordProvider = new OrdenesProvider();
  String clientemp = ' ';
  String prodTemp = ' ';
  String empTemp = ' ';
  String stringvacio = ' ';
  String stringvacio1 = ' ';
  String stringvacio2 = ' ';
  String direccion = ' ';
  double preciounidad = 0.0;
  double total = 0.0;

  ProductoModel producto = ProductoModel();
  EmpleadoModel empleado = EmpleadoModel();
  ClienteModel cliente = ClienteModel();
  OrdenModel orden = OrdenModel();

  List<ProductoModel> productos = List();
  List<EmpleadoModel> empleados = List();
  List<ClienteModel> clientes = List();

  bool _guardando = false;
  @override
  @override
  Widget build(BuildContext context) {
    final OrdenModel ordData = ModalRoute.of(context).settings.arguments;

    if (ordData != null) {
      orden = ordData;
    }

    return Scaffold(
      key: scapffoldKey,
      appBar: AppBar(
        title: Text('Agregar Ordenes'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _seleccionCliente(context),
                _seleccionProducto(context),
                _creacionCantidad(),
                _seleccionEmpleado(context),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepOrange,
      textColor: Colors.white,
      onPressed: (_guardando) ? null : _submit,
      icon: Icon(Icons.save),
      label: Text('Guardar'),
    );
  }

  void _submit() async {
    bool isValidForm = formKey.currentState.validate();

    if (!isValidForm) {
      return null;
    }

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (orden.idOrden == null) {
      await ordProvider.crearorden(orden);
    } else {
      await ordProvider.modificarOrden(orden);
    }

    mostrarSnackbar('Registro guardado');

    setState(() {
      _guardando = false;
    });

    ordProvider.cargarOrdenes();
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scapffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _seleccionCliente(BuildContext context) {
    return FutureBuilder(
      future: _crearItems(1),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        List<DropdownMenuItem> itemscliente = snapshot.data;
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Para Quien es: '),
                  SizedBox(
                    width: 150,
                    child: DropdownButton(
                        items: itemscliente,
                        value: clientemp,
                        isExpanded: true,
                        onChanged: (opt) {
                          setState(() {
                            clientemp = opt;
                            for (int i = 0; i < clientes.length; i++) {
                              if (clientemp == clientes[i].nombre) {
                                cliente = clientes[i];
                                orden.idCliente = cliente.id;
                                orden.dirEntrega = cliente.direccion;
                                orden.nombreCliente = clientemp;
                              }
                            }
                          });
                        }),
                  )
                ],
              ),
              ListTile(
                leading: Icon(Icons.select_all),
                title: Text('ClienteId: ${orden.idCliente}'),
                subtitle: Text('Direccion: ${orden.dirEntrega}'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _seleccionProducto(BuildContext context) {
    return FutureBuilder(
      future: _crearItems(2),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        List<DropdownMenuItem> itemscliente = snapshot.data;
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Que Producto Quiere: '),
                  SizedBox(
                    width: 150,
                    child: DropdownButton(
                        items: itemscliente,
                        value: prodTemp,
                        isExpanded: true,
                        onChanged: (opt) {
                          setState(() {
                            prodTemp = opt;
                            for (int i = 0; i < productos.length; i++) {
                              if (prodTemp == productos[i].nombreProducto) {
                                producto = productos[i];
                                orden.idProducto = producto.idProducto;
                                orden.nombreProducto = prodTemp;
                                preciounidad = producto.precio;
                              }
                            }
                          });
                        }),
                  )
                ],
              ),
              ListTile(
                leading: Icon(Icons.select_all),
                title: Text('ProductoId: ${orden.idProducto}'),
                subtitle: Text('Precio: $preciounidad'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _seleccionEmpleado(BuildContext context) {
    return FutureBuilder(
      future: _crearItems(3),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        List<DropdownMenuItem> itemscliente = snapshot.data;
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Quien es el Encargado?: '),
                  SizedBox(
                    width: 150,
                    child: DropdownButton(
                        items: itemscliente,
                        value: empTemp,
                        isExpanded: true,
                        onChanged: (opt) {
                          setState(() {
                            empTemp = opt;
                            for (int i = 0; i < empleados.length; i++) {
                              if (empTemp == empleados[i].nombre) {
                                empleado = empleados[i];
                                orden.idEmpleado = empleado.idEmpleado;
                                orden.nombreEmpleado = empTemp;
                              }
                            }
                          });
                        }),
                  )
                ],
              ),
              ListTile(
                leading: Icon(Icons.select_all),
                title: Text('EmpleadoId: ${orden.idEmpleado}'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _creacionCantidad() {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Cuantos va a querer?'),
              SizedBox(
                width: 25,
                child: TextFormField(
                  initialValue: orden.cantidadproducto.toString(),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  //decoration: InputDecoration(labelText: 'Precio'),
                  onSaved: (value) => orden.cantidadproducto = int.parse(value),
                  onChanged: (value) {
                    setState(() {
                      if (value != ' ') {
                        orden.cantidadproducto = int.parse(value);
                      }
                      if (preciounidad != 0.0) {
                        orden.total = preciounidad * orden.cantidadproducto;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.select_all),
            title: Text('Total: ${orden.total}'),
          ),
        ],
      ),
    );
  }

  Future<List<DropdownMenuItem<String>>> _crearItems(int i) async {
    List<String> nombres = await _seleccionLista(i);
    nombres.add(' ');
    return nombres.map((opt) {
      return DropdownMenuItem(
        child: Text(opt),
        value: opt,
      );
    }).toList();
  }

  Future<List<String>> _seleccionLista(int i) async {
    switch (i) {
      case 1:
        clientes = await clienteProvider.cargarClientes();
        return clienteProvider.cargarNombreClientes();

        break;
      case 2:
        productos = await prodProvider.cargarProductos();
        return prodProvider.cargarNombreProductos();
      case 3:
        empleados = await empProvider.cargarEmpleados();
        return empProvider.cargarEmpleadosNombre();
        break;
    }
    return null;
  }
}

//Flutter, Dart

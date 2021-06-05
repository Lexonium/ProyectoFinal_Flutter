import 'package:flutter/material.dart';
import 'package:proyecto_final/models/cliente_model.dart';
import 'package:proyecto_final/providers/cliente_provider.dart';
//import 'package:proyecto_final/util/util.dart' as utils;

class CreacionClientePage extends StatefulWidget {
  // const ProductoPage({Key key}) : super(key: key);

  @override
  _CreacionClientePageState createState() => _CreacionClientePageState();
}

class _CreacionClientePageState extends State<CreacionClientePage> {
  final formKey = GlobalKey<FormState>();
  final scapffoldKey = GlobalKey<ScaffoldState>();
  final clienteProvider = new ClienteProvider();

  ClienteModel cliente = ClienteModel();
  bool _guardando = false;
  @override
  Widget build(BuildContext context) {
    final ClienteModel prodData = ModalRoute.of(context).settings.arguments;

    if (prodData != null) {
      cliente = prodData;
    }

    return Scaffold(
      key: scapffoldKey,
      appBar: AppBar(
        title: Text('Agregar Cliente'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _crearNombre(),
                _crearDireccion(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: cliente.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre Cliente'),
      onSaved: (value) => cliente.nombre = value,
      validator: (String value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del cliente';
        }

        return null;
      },
    );
  }

  Widget _crearDireccion() {
    return TextFormField(
      initialValue: cliente.direccion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Direccion'),
      keyboardType: TextInputType.number,
      onSaved: (value) => cliente.direccion = value,
      validator: (String value) {
        if (value.length > 22 || value.length < 4) {
          return 'Ingrese Direccion LatLng cliente';
        }

        return null;
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple,
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

    if (cliente.id == null) {
      await clienteProvider.crearCliente(cliente);
    } else {
      await clienteProvider.modificarCliente(cliente);
    }

    mostrarSnackbar('Registro guardado');

    setState(() {
      _guardando = false;
    });

    clienteProvider.cargarClientes();
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scapffoldKey.currentState.showSnackBar(snackbar);
  }
}

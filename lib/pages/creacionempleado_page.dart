import 'package:flutter/material.dart';
import 'package:proyecto_final/models/empleado_model.dart';
import 'package:proyecto_final/providers/empleados_provider.dart';
import 'package:proyecto_final/util/util.dart' as utils;

class CreacionEmpleado extends StatefulWidget {
  //CreacionEmpleado({Key key}) : super(key: key);

  @override
  _CreacionEmpleadoState createState() => _CreacionEmpleadoState();
}

class _CreacionEmpleadoState extends State<CreacionEmpleado> {
  final formKey = GlobalKey<FormState>();
  final scapffoldKey = GlobalKey<ScaffoldState>();
  final prodProvider = new EmpleadosProvider();

  EmpleadoModel empleado = EmpleadoModel();
  bool _guardando = false;
  @override
  Widget build(BuildContext context) {
    final EmpleadoModel prodData = ModalRoute.of(context).settings.arguments;

    if (prodData != null) {
      empleado = prodData;
    }

    return Scaffold(
      key: scapffoldKey,
      appBar: AppBar(
        title: Text('Agregar Empleado'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _crearNombre(),
                _crearSueldo(),
                _crearPuesto(),
                _crearStringFoto(),
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
      initialValue: empleado.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Nombre'),
      onSaved: (value) => empleado.nombre = value,
      validator: (String value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del empleado';
        }

        return null;
      },
    );
  }

  Widget _crearSueldo() {
    return TextFormField(
      initialValue: empleado.sueldo.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Sueldo'),
      onSaved: (value) => empleado.sueldo = double.parse(value),
      validator: (String value) {
        if (utils.isNumeric(value)) {
          return null;
        }

        return 'El Sueldo debe de ser un numero';
      },
    );
  }

  Widget _crearPuesto() {
    return TextFormField(
      initialValue: empleado.puesto,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Puesto'),
      onSaved: (value) => empleado.puesto = value,
      validator: (String value) {
        if (value.length < 3) {
          return 'Ingrese puesto del empleado';
        }

        return null;
      },
    );
  }

  Widget _crearStringFoto() {
    return TextFormField(
      initialValue: empleado.stringFoto,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Url Imagen'),
      onSaved: (value) => empleado.stringFoto = value,
      validator: (String value) {
        if (value.length < 3) {
          return 'Ingrese el string del empleado';
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
      color: Colors.orangeAccent,
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

    if (empleado.idEmpleado == null) {
      await prodProvider.crearEmpleado(empleado);
    } else {
      await prodProvider.modificarEmpleado(empleado);
    }

    mostrarSnackbar('Registro guardado');

    setState(() {
      _guardando = false;
    });

    prodProvider.cargarEmpleados();
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

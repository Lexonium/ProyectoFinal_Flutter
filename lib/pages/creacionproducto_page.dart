import 'package:flutter/material.dart';
import 'package:proyecto_final/models/producto_model.dart';
import 'package:proyecto_final/providers/productos_provider.dart';
import 'package:proyecto_final/util/util.dart' as utils;

class CreacionProductoPage extends StatefulWidget {
  // const ProductoPage({Key key}) : super(key: key);

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<CreacionProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scapffoldKey = GlobalKey<ScaffoldState>();
  final prodProvider = new ProductosProvider();

  ProductoModel producto = ProductoModel();
  bool _guardando = false;
  @override
  Widget build(BuildContext context) {
    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if (prodData != null) {
      producto = prodData;
    }

    return Scaffold(
      key: scapffoldKey,
      appBar: AppBar(
        title: Text('Agregar Productos'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _crearNombre(),
                _crearPrecio(),
                _crearDescripcion(),
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
      initialValue: producto.nombreProducto,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      onSaved: (value) => producto.nombreProducto = value,
      validator: (String value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del producto';
        }

        return null;
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.precio.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      onSaved: (value) => producto.precio = double.parse(value),
      validator: (String value) {
        if (utils.isNumeric(value)) {
          return null;
        }

        return 'El precio debe de ser un numero';
      },
    );
  }

  Widget _crearDescripcion() {
    return TextFormField(
      initialValue: producto.descripcion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Descripcion'),
      onSaved: (value) => producto.descripcion = value,
      validator: (String value) {
        if (value.length < 3) {
          return 'Ingrese Descripcion del producto';
        }

        return null;
      },
    );
  }

  Widget _crearStringFoto() {
    return TextFormField(
      initialValue: producto.stringFoto,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Url Imagen'),
      onSaved: (value) => producto.stringFoto = value,
      validator: (String value) {
        if (value.length < 3) {
          return 'Ingrese el string del producto';
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

    if (producto.idProducto == null) {
      await prodProvider.crearProducto(producto);
    } else {
      await prodProvider.modificarProducto(producto);
    }

    mostrarSnackbar('Registro guardado');

    setState(() {
      _guardando = false;
    });

    prodProvider.cargarProductos();
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

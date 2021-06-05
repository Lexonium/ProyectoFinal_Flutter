import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/pages/cliente_page.dart';
import 'package:proyecto_final/pages/empleado_page.dart';
import 'package:proyecto_final/pages/ordenes_page.dart';
import 'package:proyecto_final/pages/producto_page.dart';
import 'package:proyecto_final/providers/ui_provider.dart';
import 'package:proyecto_final/widgets/custom_navigation.dart';

String titulo = 'Dessierto';

class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    final currenIndex = uiProvider.selectedMenuOpt;
    switch (currenIndex) {
      case 0:
        titulo = "Clientes";
        return ClientePage();

      case 1:
        titulo = "Empleados";
        return EmpleadoPage();
      case 2:
        titulo = "Productos";
        return ProductoPage();
      case 3:
        titulo = "Ordenes";
        return OrdenesPage();

      default:
        titulo = "Ordenes";
        return OrdenesPage();
    }
  }
}

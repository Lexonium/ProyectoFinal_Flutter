import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/pages/cliente_page.dart';
import 'package:proyecto_final/pages/empleado_page.dart';
import 'package:proyecto_final/pages/ordenes_page.dart';
import 'package:proyecto_final/pages/producto_page.dart';
import 'package:proyecto_final/providers/ui_provider.dart';
import 'package:proyecto_final/widgets/custom_navigation.dart';

class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
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
        return ClientePage();

      case 1:
        return EmpleadoPage();
      case 2:
        return ProductoPage();
      case 3:
        return OrdenesPage();

      default:
        return OrdenesPage();
    }
  }
}

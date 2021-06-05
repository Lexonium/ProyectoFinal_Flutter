import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int i) => uiProvider.selectedMenuOpt = i,
        elevation: 0,
        currentIndex: currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Clientes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration), label: 'Empleados'),
          BottomNavigationBarItem(
              icon: Icon(Icons.pages_rounded), label: 'Producto'),
          BottomNavigationBarItem(
              icon: Icon(Icons.pages_rounded), label: 'Ordenes'),
        ]);
  }
}

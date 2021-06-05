import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/pages/creacion_cliente.dart';
import 'package:proyecto_final/pages/creacion_orden.dart';
import 'package:proyecto_final/pages/creacionempleado_page.dart';
import 'package:proyecto_final/pages/creacionproducto_page.dart';
import 'package:proyecto_final/pages/home_page.dart';
import 'package:proyecto_final/pages/mapa_page.dart';
import 'package:proyecto_final/pages/producto_page.dart';
import 'package:proyecto_final/providers/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UiProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Proyecto Final',
          initialRoute: 'Home',
          routes: {
            'Home': (BuildContext context) => HomePage(),
            'producto': (_) => ProductoPage(),
            'creapro': (_) => CreacionProductoPage(),
            'creaemp': (_) => CreacionEmpleado(),
            'creacli': (_) => CreacionClientePage(),
            'creaord': (_) => CreacionOrdenPage(),
            'mapa': (_) => MapaPage(),
          },
          theme: ThemeData(primaryColor: Colors.deepOrange),
        ));
  }
}

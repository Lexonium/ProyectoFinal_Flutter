import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_final/models/directions_model.dart';
import 'package:proyecto_final/models/orden_model.dart';
import 'package:proyecto_final/repository/directions_repository.dart';

class MapaPage extends StatefulWidget {
  //MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  OrdenModel orden = OrdenModel();
  CameraPosition _initialCameraPosition =
      CameraPosition(target: LatLng(32.65608, -115.41181), zoom: 12.5);
  GoogleMapController _googleMapController;
  Marker origen = Marker(
      markerId: MarkerId('origen'),
      position: LatLng(32.65608, -115.41181),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
  Directions _info;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OrdenModel ordData = ModalRoute.of(context).settings.arguments;
    if (ordData != null) {
      orden = ordData;
    }
    Marker destino = Marker(
        markerId: MarkerId('destino'),
        position: LatLng(orden.getLat(), orden.getLng()),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Ruta a Cliente'),
        actions: [
          if (origen != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: origen.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.green,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('ORIGIN'),
            ),
          if (destino != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: destino.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.blue,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('DEST'),
            )
        ],
      ),
      body: mapScreen2(context, destino),
      floatingActionButton: crearBoton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget crearBoton() {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.black,
      onPressed: () => _googleMapController.animateCamera(
        _info != null
            ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
            : CameraUpdate.newCameraPosition(_initialCameraPosition),
      ),
      child: const Icon(Icons.center_focus_weak_rounded),
    );
  }

  Widget mapScreen(BuildContext context, Marker destino) {
    return GoogleMap(
      initialCameraPosition: _initialCameraPosition,
      onMapCreated: (controller) => _googleMapController = controller,
      markers: {
        origen,
        destino,
      },
    );
  }

  Future<Directions> getDirections(Marker destino) async {
    Directions directions;
    return directions = await DirectionsRepository()
        .getDirections(origin: origen.position, destination: destino.position);
  }

  Widget mapScreen2(BuildContext context, Marker destino) {
    return FutureBuilder(
      future: getDirections(destino),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        _info = snapshot.data;
        return Stack(alignment: Alignment.center, children: [
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              origen,
              destino,
            },
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId: PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: _info.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },
          ),
          if (_info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info.totalDistance}, ${_info.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ]);
      },
    );
  }
}

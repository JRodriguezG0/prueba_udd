import 'dart:async';  // Importa el paquete para usar Timer
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';  // Para trabajar con fechas

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Coordenadas iniciales para el mapa (La Reina)
  LatLng _center = LatLng(-33.4699, -70.5566); // Coordenadas de La Reina
  LatLng _userLocation = LatLng(-33.4699, -70.5566); // Default, La Reina
  bool _locationFetched = false;

  // Variables para mostrar la hora y fecha actual en Chile
  String _currentTime = '';
  String _currentDate = '';

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _startClock(); // Inicia el reloj para actualizar la hora cada segundo
  }

  // Función para obtener la ubicación del usuario
  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Los servicios de ubicación están deshabilitados.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        print('Permiso de ubicación denegado.');
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
      _locationFetched = true;
      _center = _userLocation; // Centrar el mapa en la ubicación del usuario
    });
  }

  // Función para obtener la hora y fecha actual de Chile
  void _getCurrentTime() {
    DateTime now = DateTime.now().toUtc().add(Duration(hours: -3)); // Ajustar a hora de Chile (CST)
    setState(() {
      _currentTime = DateFormat('HH:mm:ss').format(now); // Hora con formato HH:mm:ss
      _currentDate = DateFormat('dd - MM - yyyy').format(now); // Fecha con formato dd - MM - yyyy  
    });
  }

  // Función para iniciar el reloj y actualizar la hora cada segundo
  void _startClock() {
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getCurrentTime());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Área principal
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: FlutterMap(
                options: MapOptions(
                  center: _center,  // Se centra en La Reina o en la ubicación del usuario
                  zoom: 15.0,  // Aumento del zoom para mayor detalle en la comuna
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                    additionalOptions: {
                      'attribution': '© OpenStreetMap contributors',
                    },
                  ),
                  // Mostrar la ubicación del usuario
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _userLocation,
                        builder: (ctx) => Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Panel lateral derecho
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            color: Colors.red[700],
            child: Column(
              children: [
                // Agregar espacio en la parte superior para evitar que los botones choquen con la barra de estado
                SizedBox(height: MediaQuery.of(context).padding.top + 20), // Agregar padding superior

                // Botones superiores
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.visibility, color: Colors.white),
                        label: Text('Visibilidad', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: Size(double.infinity, 50),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.map, color: Colors.white),
                        label: Text('Ver Mapa', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: Size(double.infinity, 50),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                // Botones de rutas
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: Size(double.infinity, 50),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'Ruta Operaciones',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: Size(double.infinity, 50),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'Ruta Preventiva',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                // Espaciador para empujar los botones hacia abajo
                Spacer(),
                // Footer
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: Size(double.infinity, 50),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'Cerrar Turno',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$_currentTime\n$_currentDate',
                            style: TextStyle(color: Colors.yellow),
                          ),
                          IconButton(
                            icon: Icon(Icons.settings, color: Colors.yellow),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back),
          title: const Text(""), //Título AppBar
          actions: const [
            Icon(Icons.arrow_forward),
          ],
        ),
        body: SingleChildScrollView(
          //Habilita scroll en caso de overflow, se podría usar tb ListView
          child: Column(
            children: [
              const SizedBox(height: 12.0), //Espacio entre
              Container(
                height: 448.0,
                width: double.infinity,
                color: const Color.fromARGB(255, 144, 144, 144),
                child: const Text("Imagen Principal"),
              ),
              const SizedBox(height: 90.0),

              Container(
                height: 148.0,
                color: Colors.transparent,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, //navegación horizontal
                  child: Row(
                    //Row: permite trabajar al interior de un container en una sola fila, dividiendo o agregando elementos
                    children: [
                      Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: const Color.fromARGB(255, 253, 198, 116),
                        child: const Center(child: Text("Filtro 1")),
                      ),
                      Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: const Color.fromARGB(255, 255, 191, 95),
                        child: const Center(child: Text("Filtro 2")),
                      ),
                      Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: const Color.fromARGB(255, 255, 191, 94),
                        child: const Center(child: Text("Filtro 3")),
                      ),
                      Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: const Color.fromARGB(255, 255, 180, 67),
                        child: const Center(child: Text("Filtro 4")),
                      ),
                      Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: const Color.fromARGB(255, 255, 172, 49),
                        child: const Center(child: Text("Filtro 5")),
                      ),
                      Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: const Color.fromARGB(255, 255, 164, 28),
                        child: const Center(child: Text("Filtro 6")),
                      ),
                      Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: Colors.orange,
                        child: const Center(child: Text("Filtro 7")),
                      ),
                      Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: const Color.fromARGB(255, 137, 137, 137),
                        child: const Center(child: Text("Filtro 8 (B-W)")),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 90.0),

              Container(
                height: 45.0,
                width: double.infinity,
                color: const Color.fromARGB(255, 144, 144, 144),
                child: const Text("                   Filtro                                                                                 Editar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

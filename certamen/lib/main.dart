//Scroll vertical (Arriba y abajo), cuadrados, rectángulos
//Código para hacer tres rectángulos uno arriba del otro y 4 cuadrados (2 arriba y 2 abajo)

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
          leading: const Icon(Icons.menu),
          title: const Text("Instagram"), //Título AppBar
          actions: const [
            Icon(Icons.more_vert),
          ],
        ),
        body: SingleChildScrollView(
          //Habilita scroll en caso de overflow, se podría usar tb ListView
          child: Column(
            children: [
              const SizedBox(height: 12.0), //Espacio entre
              Container(
                height: 100.0,
                width: double.infinity,
                color: Colors.blue,
                child: const Text("segundo container"),
              ),
              const SizedBox(height: 12.0),
              Container(
                height: 148.0,
                width: double.infinity,
                color: Colors.blue,
                child: const Text("tercer container"),
              ),

              const SizedBox(height: 12.0),

              Container(
                height: 180,
                color: Colors.transparent,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, //navegación horizontal
                  child: Row(
                    //Row: permite trabajar al interior de un container en una sola fila, dividiendo o agregando elementos
                    children: [
                      
                      Container(
                        width: 180,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: Colors.orange,
                        child: const Center(child: Text("Container 1")),
                      ),
                      Container(
                        width: 180,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: Colors.orange,
                        child: const Center(child: Text("Container 2")),
                      ),
                      Container(
                        width: 180,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: Colors.orange,
                        child: const Center(child: Text("Container 3")),
                      ),
                      Container(
                        width: 180,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: Colors.orange,
                        child: const Center(child: Text("Container 4")),
                      ),
                      Container(
                        width: 180,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: Colors.orange,
                        child: const Center(child: Text("Container 5")),
                      ),
                      Container(
                        width: 180,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: Colors.orange,
                        child: const Center(child: Text("Container 6")),
                      ),
                      Container(
                        width: 180,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: Colors.orange,
                        child: const Center(child: Text("Container 7")),
                      ),
                      Container(
                        width: 180,
                        margin: const EdgeInsets.only(right: 12.0),
                        color: Colors.orange,
                        child: const Center(child: Text("Container 8")),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    );
  }
}

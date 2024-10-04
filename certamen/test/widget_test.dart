// Importa las dependencias necesarias
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Define MyApp como un ejemplo de aplicación para ser probada
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

// Define MyHomePage, que contiene un contador y un botón flotante
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // Función para incrementar el contador
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Define el test
void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Construye el widget y espera un frame
    await tester.pumpWidget(const MyApp());

    // Verifica que el contador comienza en 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Simula un toque en el botón flotante y espera un frame
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifica que el contador se ha incrementado a 1
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semana6/components/appbar.dart';
import 'package:semana6/components/formulario.dart';
import 'package:semana6/components/formulario_retiro.dart';

class Mantenedor extends StatefulWidget {
  const Mantenedor({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MantenedorState createState() => _MantenedorState();
}

class _MantenedorState extends State<Mantenedor> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const BlogScreen(),
    const CallsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync_alt),
            label: 'Movimientos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Billetera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Aprende',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '¡Hola de nuevo, Joaco!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Total invertido',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Text(
                '\$104.602',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: ListTile(
                        title: const Text(
                          'Rentabilidad',
                          textAlign: TextAlign.center,
                        ),
                        subtitle: const Text(
                          '35 %',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Card(
                      child: ListTile(
                        title: const Text(
                          'Mis Acciones',
                          textAlign: TextAlign.center,
                        ),
                        subtitle: const Text(
                          '+0.2%',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Abre el formulario ya existente
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => FractionallySizedBox(
                          heightFactor: 0.9,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: FormularioScreen(),
                            ),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text('Nueva inversión'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Acción para "Crear Portafolio"
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Crear Portafolio'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Mis portafolios',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      tabs: [
                        Tab(
                          child: Text('Privados', style: TextStyle(color: Colors.white)),
                        ),
                        Tab(
                          child: Text('Grupales', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 200,
                      child: TabBarView(
                        children: [
                          ListView(
                            children: const [
                              ListTile(
                                title: Text('Viajes'),
                                subtitle: Text('Disney'),
                                trailing: Text('\$100.000'),
                              ),
                              ListTile(
                                title: Text('Salud'),
                                subtitle: Text('Salud Abuelos'),
                                trailing: Text('\$250.000'),
                              ),
                              ListTile(
                                title: Text('Lujitos'),
                                subtitle: Text('Ferrari 458'),
                                trailing: Text('\$250.000.000'),
                              ),
                            ],
                          ),
                          const Center(child: Text('No hay portafolios grupales')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Movimientos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Historial de Movimientos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.arrow_upward, color: Colors.red),
                    title: Text('Retiro a cuenta bancaria'),
                    subtitle: Text('01/12/2024'),
                    trailing: Text('-\$500.00'),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_downward, color: Colors.green),
                    title: Text('Depósito recibido'),
                    subtitle: Text('30/11/2024'),
                    trailing: Text('+\$1,000.00'),
                  ),
                  ListTile(
                    leading: Icon(Icons.sync_alt, color: Colors.blue),
                    title: Text('Transferencia entre cuentas'),
                    subtitle: Text('28/11/2024'),
                    trailing: Text('-\$300.00'),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_downward, color: Colors.green),
                    title: Text('Depósito adicional'),
                    subtitle: Text('25/11/2024'),
                    trailing: Text('+\$700.00'),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_upward, color: Colors.red),
                    title: Text('Pago de servicio'),
                    subtitle: Text('20/11/2024'),
                    trailing: Text('-\$200.00'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Billetera',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gestión de Billetera',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Saldo disponible:',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Text(
              '\$104.602',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Abre el formulario de retiro
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => FractionallySizedBox(
                        heightFactor: 0.9,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: FormularioRetiroScreen(),
                          ),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text('Solicitar Retiro'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Acción futura para ver historial
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Ver Historial'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Últimos movimientos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.arrow_upward, color: Colors.red),
                    title: Text('Retiro a cuenta bancaria'),
                    subtitle: Text('01/12/2024'),
                    trailing: Text('-\$500.00'),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_downward, color: Colors.green),
                    title: Text('Depósito recibido'),
                    subtitle: Text('30/11/2024'),
                    trailing: Text('+\$1,000.00'),
                  ),
                  ListTile(
                    leading: Icon(Icons.sync_alt, color: Colors.blue),
                    title: Text('Transferencia entre cuentas'),
                    subtitle: Text('28/11/2024'),
                    trailing: Text('-\$300.00'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CallsScreenState createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Aprende',
          style: TextStyle(color: Colors.white),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          tabs: const [
            Tab(text: 'Finanzas'),
            Tab(text: 'Datos'),
            Tab(text: 'Ciencias'),
            Tab(text: 'Tecnología'),
            Tab(text: 'Favoritos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(5, (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'lib/assets/images/finanzas.png',
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'La tecnología avanza',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.bookmark),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

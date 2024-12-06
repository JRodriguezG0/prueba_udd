import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FormularioScreen extends StatefulWidget {
  final DocumentSnapshot? usuario;

  // ignore: use_super_parameters
  const FormularioScreen({Key? key, this.usuario}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final _nombreController = TextEditingController();
  final _apellidopaternoController = TextEditingController();
  final _inversionMensualController = TextEditingController();
  final _inversionMensualController2 = TextEditingController();

  // Valor seleccionado para inversión inicial
  int? _inversionInicial;
  int? _inversionMen;
  String? _tiempoSeleccionado; // Controlador para el tiempo

  final List<int> opcionesInversionInicial = [100000, 200000, 500000, 1000000];
  final List<int> opcionesInversionMen = [100000, 200000, 500000, 1000000];
  final List<String> opcionesTiempo = [
    'Menos de un año',
    '1-2 años',
    '3-5 años',
    'Más de 5 años'
  ];

  @override
  void initState() {
    super.initState();

    // Si estamos en modo edición, cargamos los datos del usuario en los controladores
    if (widget.usuario != null) {
      final usuarioData = widget.usuario!.data() as Map<String, dynamic>;
      _nombreController.text = usuarioData['nombre'] ?? '';
      _apellidopaternoController.text = usuarioData['apellido paterno'] ?? '';
      _inversionMensualController.text =
          (usuarioData['inversionMensual'] ?? '').toString();
      _inversionMensualController2.text =
          (usuarioData['inversionMensual'] ?? '').toString();
      _inversionInicial = usuarioData['inversionInicial'];
      _inversionMen = usuarioData['inversionMen'];
      _tiempoSeleccionado = usuarioData['tiempo']; // Cargar el tiempo si existe
    }
  }

  @override
  void dispose() {
    // Liberamos los controladores al cerrar el formulario
    _nombreController.dispose();
    _apellidopaternoController.dispose();
    _inversionMensualController.dispose();
    _inversionMensualController2.dispose();
    super.dispose();
  }

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final usuarioData = {
        'nombre': _nombreController.text,
        'apellido paterno': _apellidopaternoController.text,
        'inversionInicial': _inversionInicial,
        'inversionMen': _inversionMen,
        'inversionMensual': int.tryParse(_inversionMensualController.text) ?? 0,
        'inversionMensual2':
            int.tryParse(_inversionMensualController2.text) ?? 0,
        'tiempo': _tiempoSeleccionado, // Guardar el tiempo seleccionado
      };

      try {
        if (widget.usuario == null) {
          // Si el usuario es nuevo, lo agregamos a la colección
          await FirebaseFirestore.instance
              .collection('usuarios')
              .add(usuarioData);

          // Mostrar un SnackBar de confirmación de creación
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Inversión creada correctamente')),
          );
        } else {
          // Si es una edición, actualizamos el documento existente
          await FirebaseFirestore.instance
              .collection('usuarios')
              .doc(widget.usuario!.id)
              .update(usuarioData);

          // Mostrar un SnackBar de confirmación de edición
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Inversión editada correctamente')),
          );
        }

        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(); // Cerramos el formulario
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar la inversión')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.usuario == null
            ? 'Crear inversión rápida'
            : 'Editar inversión'),
        automaticallyImplyLeading: false, // Desactiva la flecha de retroceso
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Formulario inv inicial
              TextFormField(
                controller: _inversionMensualController,
                decoration: const InputDecoration(labelText: "ej. 80.000"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un monto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Divider(thickness: 1.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Caja 1
                  ChoiceChip(
                    label: const Text('\$25.000'),
                    selected: _inversionInicial == 10000,
                    onSelected: (selected) {
                      setState(() {
                        _inversionInicial = selected ? 10000 : null;
                        _inversionMensualController.text =
                            selected ? '25000' : '';
                      });
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    labelStyle: TextStyle(
                      color: _inversionInicial == 10000
                          ? Colors.white
                          : Colors.black,
                    ),
                    backgroundColor: _inversionInicial == 10000
                        ? Colors.blue
                        : Colors.grey[300],
                    selectedColor: Colors.blue,
                    showCheckmark: false,
                  ),
                  const SizedBox(width: 1.0),

                  // Caja 2
                  ChoiceChip(
                    label: const Text('\$50.000'),
                    selected: _inversionInicial == 20000,
                    onSelected: (selected) {
                      setState(() {
                        _inversionInicial = selected ? 20000 : null;
                        _inversionMensualController.text =
                            selected ? '50000' : '';
                      });
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    labelStyle: TextStyle(
                      color: _inversionInicial == 20000
                          ? Colors.white
                          : Colors.black,
                    ),
                    backgroundColor: _inversionInicial == 20000
                        ? Colors.blue
                        : Colors.grey[300],
                    selectedColor: Colors.blue,
                    showCheckmark: false,
                  ),
                  const SizedBox(width: 1.0),

                  // Caja 3
                  ChoiceChip(
                    label: const Text('\$75.000'),
                    selected: _inversionInicial == 30000,
                    onSelected: (selected) {
                      setState(() {
                        _inversionInicial = selected ? 30000 : null;
                        _inversionMensualController.text =
                            selected ? '75000' : '';
                      });
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    labelStyle: TextStyle(
                      color: _inversionInicial == 30000
                          ? Colors.white
                          : Colors.black,
                    ),
                    backgroundColor: _inversionInicial == 30000
                        ? Colors.blue
                        : Colors.grey[300],
                    selectedColor: Colors.blue,
                    showCheckmark: false,
                  ),
                  const SizedBox(width: 1.0),

                  // Caja 4
                  ChoiceChip(
                    label: const Text('\$100.000'),
                    selected: _inversionInicial == 40000,
                    onSelected: (selected) {
                      setState(() {
                        _inversionInicial = selected ? 40000 : null;
                        _inversionMensualController.text =
                            selected ? '100000' : '';
                      });
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    labelStyle: TextStyle(
                      color: _inversionInicial == 40000
                          ? Colors.white
                          : Colors.black,
                    ),
                    backgroundColor: _inversionInicial == 40000
                        ? Colors.blue
                        : Colors.grey[300],
                    selectedColor: Colors.blue,
                    showCheckmark: false,
                  ),
                ],
              ),

              const SizedBox(height: 32),
// Formulario inv mensual
              TextFormField(
                controller: _inversionMensualController2,
                decoration: const InputDecoration(labelText: "ej. 20.000"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un monto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Divider(thickness: 1.0),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // alinear cajas al inicio
                children: [
                  // Caja 1
                  ChoiceChip(
                    label: const Text('\$25.000'),
                    selected: _inversionMen == 10000,
                    onSelected: (selected) {
                      setState(() {
                        _inversionMen = selected ? 10000 : null;
                        _inversionMensualController2.text =
                            selected ? '25000' : '';
                      });
                    },
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0), // Espacio dentro de la caja
                    labelStyle: TextStyle(
                      color:
                          _inversionMen == 10000 ? Colors.white : Colors.black,
                    ),
                    backgroundColor:
                        _inversionMen == 10000 ? Colors.blue : Colors.grey[300],
                    selectedColor: Colors.blue,
                    showCheckmark: false,
                  ),
                  const SizedBox(width: 1.0),

                  // Caja 2
                  ChoiceChip(
                    label: const Text('\$50.000'),
                    selected: _inversionMen == 20000,
                    onSelected: (selected) {
                      setState(() {
                        _inversionMen = selected ? 20000 : null;
                        _inversionMensualController2.text =
                            selected ? '50000' : '';
                      });
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    labelStyle: TextStyle(
                      color:
                          _inversionMen == 20000 ? Colors.white : Colors.black,
                    ),
                    backgroundColor:
                        _inversionMen == 20000 ? Colors.blue : Colors.grey[300],
                    selectedColor: Colors.blue,
                    showCheckmark: false,
                  ),
                  const SizedBox(width: 1.0),

                  // Caja 3
                  ChoiceChip(
                    label: const Text('\$75.000'),
                    selected: _inversionMen == 30000,
                    onSelected: (selected) {
                      setState(() {
                        _inversionMen = selected ? 30000 : null;
                        _inversionMensualController2.text =
                            selected ? '75000' : '';
                      });
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    labelStyle: TextStyle(
                      color:
                          _inversionMen == 30000 ? Colors.white : Colors.black,
                    ),
                    backgroundColor:
                        _inversionMen == 30000 ? Colors.blue : Colors.grey[300],
                    selectedColor: Colors.blue,
                    showCheckmark: false,
                  ),
                  const SizedBox(width: 1.0),

                  // Caja 4
                  ChoiceChip(
                    label: const Text('\$100.000'),
                    selected: _inversionMen == 40000,
                    onSelected: (selected) {
                      setState(() {
                        _inversionMen = selected ? 40000 : null;
                        // Coloca el valor en la caja de texto
                        _inversionMensualController2.text =
                            selected ? '100000' : '';
                      });
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    labelStyle: TextStyle(
                      color:
                          _inversionMen == 40000 ? Colors.white : Colors.black,
                    ),
                    backgroundColor:
                        _inversionMen == 40000 ? Colors.blue : Colors.grey[300],
                    selectedColor: Colors.blue,
                    showCheckmark: false,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Dropdown para seleccionar el tiempo de inversión
              DropdownButtonFormField<String>(
                value: _tiempoSeleccionado,
                decoration:
                    const InputDecoration(labelText: 'Tiempo de inversión'),
                items: opcionesTiempo.map((tiempo) {
                  return DropdownMenuItem<String>(
                    value: tiempo,
                    child: Text(tiempo),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _tiempoSeleccionado = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione el tiempo de inversión';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              // Botón para agregar inversión
              ElevatedButton(
                onPressed: _saveUser,
                child: Text(widget.usuario == null
                    ? 'Agregar inversión'
                    : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

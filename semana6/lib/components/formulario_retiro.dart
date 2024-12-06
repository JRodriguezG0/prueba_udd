import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FormularioRetiroScreen extends StatefulWidget {
  final DocumentSnapshot? usuario;

  // ignore: use_super_parameters
  const FormularioRetiroScreen({Key? key, this.usuario}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FormularioRetiroScreenState createState() => _FormularioRetiroScreenState();
}

class _FormularioRetiroScreenState extends State<FormularioRetiroScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final _montoController = TextEditingController();
  final _descripcionController = TextEditingController();

  // Valor seleccionado para cuenta de origen
  String? _cuentaSeleccionada;
  final List<String> opcionesCuentas = [
    'Cuenta Corriente',
    'Criptomonedas',
    'Fondo de Inversiones'
  ];

  @override
  void initState() {
    super.initState();

    // Si estamos en modo edición, cargamos los datos del usuario en los controladores
    if (widget.usuario != null) {
      final usuarioData = widget.usuario!.data() as Map<String, dynamic>;
      _montoController.text = (usuarioData['monto'] ?? '').toString();
      _descripcionController.text = usuarioData['descripcion'] ?? '';
      _cuentaSeleccionada = usuarioData['cuenta'];
    }
  }

  @override
  void dispose() {
    // Liberamos los controladores al cerrar el formulario
    _montoController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _saveRetiro() async {
    if (_formKey.currentState!.validate()) {
      final retiroData = {
        'monto': int.tryParse(_montoController.text) ?? 0,
        'descripcion': _descripcionController.text,
        'cuenta': _cuentaSeleccionada,
      };

      try {
        if (widget.usuario == null) {
          // Si el retiro es nuevo, lo agregamos a la colección
          await FirebaseFirestore.instance.collection('retiros').add(retiroData);

          // Mostrar un SnackBar de confirmación de creación
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Retiro registrado correctamente')),
          );
        } else {
          // Si es una edición, actualizamos el documento existente
          await FirebaseFirestore.instance
              .collection('retiros')
              .doc(widget.usuario!.id)
              .update(retiroData);

          // Mostrar un SnackBar de confirmación de edición
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Retiro actualizado correctamente')),
          );
        }

        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(); // Cerramos el formulario
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al registrar el retiro')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.usuario == null ? 'Solicitar Retiro' : 'Editar Retiro'),
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
              // Campo para el monto del retiro
              TextFormField(
                controller: _montoController,
                decoration: const InputDecoration(labelText: 'Monto a retirar'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un monto válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Dropdown para seleccionar la cuenta de origen
              DropdownButtonFormField<String>(
                value: _cuentaSeleccionada,
                decoration: const InputDecoration(labelText: 'Cuenta de origen'),
                items: opcionesCuentas.map((cuenta) {
                  return DropdownMenuItem<String>(
                    value: cuenta,
                    child: Text(cuenta),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _cuentaSeleccionada = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione una cuenta de origen';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo para la descripción del retiro
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción (opcional)'),
              ),
              const SizedBox(height: 32),

              // Botón para confirmar el retiro
              ElevatedButton(
                onPressed: _saveRetiro,
                child: Text(widget.usuario == null ? 'Registrar Retiro' : 'Actualizar Retiro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

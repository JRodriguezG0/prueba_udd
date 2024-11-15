import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FormularioScreen extends StatefulWidget {
  final DocumentSnapshot? usuario;

  const FormularioScreen({super.key, this.usuario});

  @override
  // ignore: library_private_types_in_public_api
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final _nombreController = TextEditingController();
  final _fechaNacimientoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Si estamos en modo edición, cargamos los datos del usuario en los controladores
    if (widget.usuario != null) {
      final usuarioData = widget.usuario!.data() as Map<String, dynamic>;
      _nombreController.text = usuarioData['nombre'] ?? '';
      _fechaNacimientoController.text = usuarioData['fechaNacimiento'] ?? '';
    }
  }

  @override
  void dispose() {
    // Liberamos los controladores al cerrar el formulario
    _nombreController.dispose();
    _fechaNacimientoController.dispose();
    super.dispose();
  }

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final usuarioData = {
        'nombre': _nombreController.text,
        'fechaNacimiento': _fechaNacimientoController.text,
      };

      try {
        if (widget.usuario == null) {
          // Si el usuario es nuevo, lo agregamos a la colección
          await FirebaseFirestore.instance.collection('usuarios').add(usuarioData);

          // Mostrar un SnackBar de confirmación de creación
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuario creado correctamente')),
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
            const SnackBar(content: Text('Usuario editado correctamente')),
          );
        }

        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(); // Cerramos el formulario
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar el usuario')),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    // Mostrar el selector de fecha
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      // Formatear la fecha seleccionada a un formato más adecuado
      final formattedDate = "${pickedDate.toLocal()}".split(' ')[0];
      setState(() {
        _fechaNacimientoController.text = formattedDate; // Asignar la fecha seleccionada al controlador
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.usuario == null ? 'Agregar Usuario' : 'Editar Usuario'),
        automaticallyImplyLeading: false, // Desactiva la flecha de retroceso
        actions: [
          IconButton(
            icon: const Icon(Icons.close), // Ícono de cierre (X)
            onPressed: () {
              Navigator.of(context).pop(); // Cierra la pantalla actual
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
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32), // Espacio entre campos
              GestureDetector(
                onTap: () => _selectDate(context), // Abre el DatePicker cuando se toca el campo
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _fechaNacimientoController,
                    decoration: const InputDecoration(
                      labelText: 'Fecha de Nacimiento',
                      hintText: 'Selecciona tu fecha de nacimiento',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la fecha de nacimiento';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32), // Espacio antes del botón
              ElevatedButton(
                onPressed: _saveUser,
                child: Text(widget.usuario == null ? 'Agregar' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

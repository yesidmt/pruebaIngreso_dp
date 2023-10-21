import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dp_prueba_ingreso/models/user_model.dart';
import 'package:dp_prueba_ingreso/services/database_helper.dart'; 
import 'package:dp_prueba_ingreso/providers/user_provider.dart'; 

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dateController = TextEditingController();
  late DateTime _selectedDate; 

  @override
  void dispose() {
    // Limpia los controladores cuando el widget sea descartado
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Usuario'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Apellido'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su apellido';
                  }
                  return null;
                },
              ),
              GestureDetector(
                onTap: () => _selectDate(context), // para seleccionar la fecha
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(labelText: 'Fecha de Nacimiento'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su fecha de nacimiento';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveUser(); // Guarda los datos en la base de datos
                    }
                  },
                  child: Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función para seleccionar la fecha de nacimiento
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
   if (picked != null) {
    setState(() {
      _selectedDate = picked;
      _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    });
  }
  }

 // Función para guardar el usuario
void _saveUser() {
  // ignore: unnecessary_null_comparison
  if (_selectedDate == null) { // Verifica si _selectedDate está inicializado
    // Si _selectedDate no está inicializado, muestra un error o maneja de otra manera
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Por favor, seleccione su fecha de nacimiento')),
    );
    return; // No continúes con la función
  }

  final newUser = UserModel(
    firstName: _firstNameController.text,
    lastName: _lastNameController.text,
    dateOfBirth: _selectedDate, 
  );
  
// Inserta el usuario en la base de datos
DatabaseHelper.instance.insertUser(newUser).then((savedUserId) {
  // Cuando se completa la inserción, se devuelve el ID del usuario guardado
  // ignore: unnecessary_null_comparison
  if (savedUserId != null) {
    Provider.of<UserProvider>(context, listen: false).updateUser(savedUserId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Usuario guardado con éxito! ID: $savedUserId')),
    );
   Navigator.of(context).pushNamed('/user_form_new_address'); 
  } else {
    // Maneja el error de inserción
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error al guardar el usuario.')),
    );
  }
  }).catchError((error) {
    // Manejo de errores de la base de datos
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $error')),
    );
  });

  }

}

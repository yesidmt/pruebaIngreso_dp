import 'package:flutter/material.dart';
import 'package:dp_prueba_ingreso/models/user_model.dart'; 
import 'package:dp_prueba_ingreso/services/database_helper.dart'; 
import 'package:dp_prueba_ingreso/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddressFormScreen extends StatefulWidget {
  @override
  _AddressFormScreenState createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _zipCodeController = TextEditingController();

  @override
  void dispose() {
    // Limpia los controladores cuando el widget sea descartado
    _streetController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Dirección'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _streetController,
                decoration: InputDecoration(labelText: 'Calle'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la calle';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'Ciudad'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la ciudad';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'País'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el país';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _zipCodeController,
                decoration: InputDecoration(labelText: 'Código Postal'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el código postal';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveAddress(); // Guarda los datos en la lista de direcciones
                    }
                  },
                  child: Text('Guardar Dirección'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

void _saveAddress() async { // Hazlo asíncrono
  int userId = Provider.of<UserProvider>(context, listen: false).userId;

  final newAddress = Address(
    id: DateTime.now().millisecondsSinceEpoch, 
    userId: userId, 
    street: _streetController.text,
    city: _cityController.text,
    country: _countryController.text,
    zipCode: _zipCodeController.text,
  );

  // Inserta la nueva dirección en SQLite
  await DatabaseHelper.instance.insertAddress(newAddress);

  // Muestra un Snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Dirección guardada con éxito!')),
  );

    Navigator.of(context).pushNamed('/'); 
 
}
}

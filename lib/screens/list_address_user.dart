import 'package:flutter/material.dart';
import 'package:dp_prueba_ingreso/services/database_helper.dart';
import 'package:dp_prueba_ingreso/models/user_model.dart';

class AddressesListScreen extends StatelessWidget {
  final int userId;

  AddressesListScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Direcciones del Usuario'),
      ),
      body: FutureBuilder<List<Address>>(
        future: DatabaseHelper.instance.getAddressesByUserId(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay direcciones para este usuario'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final address = snapshot.data![index];
                return ListTile(
                  title: Text(address.street),
                  subtitle: Text('${address.city}, ${address.country} - ${address.zipCode}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dp_prueba_ingreso/providers/user_provider.dart'; 
import 'package:dp_prueba_ingreso/screens/user_form_screen.dart';
import 'package:dp_prueba_ingreso/screens/user_form_new_adress.dart'; 
import 'package:dp_prueba_ingreso/screens/list_user.dart'; 
import 'package:dp_prueba_ingreso/screens/list_address_user.dart'; 
import 'package:dp_prueba_ingreso/screens/home_screen.dart'; 

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
       routes: {
        '/': (context) => HomeScreen(), // La ruta de la pantalla inicial
         '/user_form_new_user': (context) => const UserFormScreen(),
        '/user_form_new_address': (context) => AddressFormScreen(), 
        '/users': (context) => UsersListScreen(),
        '/addresses': (context) => AddressesListScreen(userId: 1,), 
        // ... otras rutas
      },
    );
  }
}

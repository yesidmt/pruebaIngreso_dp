import 'package:flutter/foundation.dart';
import 'package:dp_prueba_ingreso/models/user_model.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> _users = [];

  List<UserModel> get users => [..._users];

  void addUser(UserModel user) {
    _users.add(user);
    notifyListeners();
  }
   int _userId = 0;  // Inicializar con un valor por defecto o con un valor que indique que no hay usuario.

  // Método para cambiar el userId cuando el usuario se guarda en la base de datos
  void updateUser(int userId) {
    _userId = userId;
    notifyListeners();  // Notifica a los escuchas que el userId ha cambiado
  }

  // Método para obtener el userId actual
  int get userId => _userId;
}
class AddressProvider with ChangeNotifier {
  List<Address> _addresses = [];

  List<Address> get addresses => _addresses;

  void addAddress(Address address) {
    _addresses.add(address);
    notifyListeners(); // notifica a los oyentes que se ha agregado una nueva dirección
  }

  // ... cualquier otra lógica que necesites para manejar las direcciones
}
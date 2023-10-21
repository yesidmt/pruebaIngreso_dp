import 'package:flutter_test/flutter_test.dart';
import 'package:dp_prueba_ingreso/services/database_helper.dart';
import 'package:dp_prueba_ingreso/models/user_model.dart';

void main() {
  group('DatabaseHelper', () {
    late DatabaseHelper dbHelper;
    late UserModel testUser;
    late Address testAddress;

    setUp(() async {
      // Inicializa una nueva instancia de la base de datos
      dbHelper = DatabaseHelper.instance;

      // Crea un usuario de prueba
      testUser = UserModel(
        firstName: 'Test',
        lastName: 'User',
        dateOfBirth: DateTime.now(),
        // Asegúrate de pasar todos los valores necesarios
      );

      testAddress = Address(
        id: 1,
        userId: 1,
        street: '123 Test St',
        city: 'Test City',
        country: 'Test Country',
        zipCode: '12345',
      );

      await dbHelper.insertAddress(testAddress);
      await dbHelper.insertUser(testUser);
    });

    tearDown(() async {
      // Opcional: Elimina el usuario de prueba de la base de datos
      // Si tienes un método para eliminar usuarios, aquí deberías llamarlo para limpiar después de cada prueba
    });

    test('insert a user into the database', () async {
      // Recupera todos los usuarios de la base de datos
      final users = await dbHelper.getUsers();

      // Encuentra el usuario de prueba en la lista de usuarios recuperados
      final insertedUser = users.firstWhere(
        (user) => user.firstName == testUser.firstName && user.lastName == testUser.lastName,
      );

      // Verifica si el usuario de prueba existe en la base de datos
      expect(insertedUser, isNotNull);
      expect(insertedUser.firstName, testUser.firstName);
      expect(insertedUser.lastName, testUser.lastName);
      // ...otros campos que quieras verificar
    });
 test('insert and retrieve an address from the database', () async {
      final users = await dbHelper.getUsers();
      final addresses = await dbHelper.getAddressesByUserId(users[0].userId!);

      expect(addresses, isNotEmpty);
      expect(addresses[0].street, testAddress.street);
      expect(addresses[0].city, testAddress.city);
      expect(addresses[0].country, testAddress.country);
      expect(addresses[0].zipCode, testAddress.zipCode);
    });

    test('retrieve addresses by user id from the database', () async {
      final users = await dbHelper.getUsers();
      final addresses = await dbHelper.getAddressesByUserId(users[0].userId!);

      expect(addresses, isNotEmpty);

      // Verifica si las direcciones recuperadas corresponden al usuario correcto
      for (final address in addresses) {
        expect(address.userId, equals(users[0].userId));
      }
    });

    // Aquí podrías agregar más pruebas para otros métodos como `insertAddress`, `getUsers`, `getAddressesByUserId`, etc.
  });
}

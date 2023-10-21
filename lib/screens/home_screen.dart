import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 4.0, 
              margin: EdgeInsets.all(20),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.of(context).pushNamed('/user_form_new_user');
                },
                child: Container(
                  width: 300,
                  height: 50,
                  child: Center(child: Text('Agregar Usuario', style: TextStyle(fontSize: 20))),
                ),
              ),
            ),
            Card(
              elevation: 4.0,
              margin: EdgeInsets.all(20),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.of(context).pushNamed('/users');
                },
                child: Container(
                  width: 300,
                  height: 50,
                  child: Center(child: Text('Listar Usuarios', style: TextStyle(fontSize: 20))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

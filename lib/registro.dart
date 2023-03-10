import 'package:flutter/material.dart';

void main() => runApp(const Registro());

class Registro extends StatelessWidget {
  static const routeName = 'registro';
  const Registro({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 10, 176, 115),
        appBar: AppBar(
          title: const Text('Material App Bar'),
            
        ),
        body: const Center(
          child: Text('Registrado con exito'),
          
        ),
      ),
    );
  }
}
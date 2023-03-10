import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Signup extends StatefulWidget {
  static const routeName = 'signup';
  const Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _signUP() async {
    var valid = _formKey.currentState.validate();
    User user;
    if (!valid) {
      return;
    } else {
      user = await registerUser(_emailController.text, _passwordController.text);
      if (user != null) {
        FirebaseFirestore.instance.doc('users/${user.uid}').set({
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text
        }).onError((e, _) => print("Error writing document: $e"));

        Navigator.of(context).pushNamed(Home.routeName);
      }
    }
  }

  Future<User> registerUser(String email, String password) async {
    User user;
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } catch (e) {}
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Signup application demo',
        ),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
                controller: _nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Ingrese su Nombre";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Correo',
                ),
                controller: _emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Ingrese su correo";
                  }
                  if (!value.contains('@')) {
                    return "Correo Incorrecto";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contrasenia',
                ),
                controller: _passwordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Ingrese su contrasenia";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: _signUP,
                child: Text(
                  'Registrase ',
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, Home.routeName);
              //   },
              //   child: Text(
              //     'View Users ',
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

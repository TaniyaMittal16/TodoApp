import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/database.dart';
import 'package:todoapp/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/todocard.dart';

import 'firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

late String _email;
late String _pass;

  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if(e.code == "user-not-found"){
        print("No user found for that email");
      }
    }
    return user;
  }
  bool validateemail = false;
  bool validatePass = false;
  final formKey = GlobalKey<FormState>();


  // late DBProvider _dbProvider;


   @override
  Widget build(BuildContext context) {
     final _text = TextEditingController();
     final _password = TextEditingController();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login App'),
        ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Image.asset("assets/images/icon.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: TextField(
                  controller: _text,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintStyle: const TextStyle(color: Colors.purple),
                    labelText: "Enter your Email ",
                    errorText: validateemail ? 'field can not be empty' : null,
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintStyle: const TextStyle(color: Colors.purple),
                    labelText: 'Enter Your Password',
                    errorText: validatePass ? 'field can not be empty' : null,

                  ),
                ),
              ),

              ElevatedButton(
                  onPressed: () {
                    // either
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Login()));

                    // or
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register(username: '',city: '', age: '', mobilenumber: '', email: '', password: '')));
                  },
                  child: const Text("New User? Please Register Here")),

            ],
          ),
        bottomNavigationBar: Container(
            height: 60,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: ElevatedButton(
              child: const Text('Login'),
              onPressed: () async{
     setState(() {
     _text.text.isEmpty ? validateemail = true : validateemail = false;
     _password.text.isEmpty ? validatePass = true : validatePass = false;
     });
     if(validateemail || validatePass){
     }else{

     }
     User? user = await loginUsingEmailPassword(email: _text.text, password: _password.text, context: context);
     print(user);
     if(user != null){
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const TodoCard()));

     }


     }
            )
      ),
      ) );


  }

}





import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/database.dart';
import 'package:todoapp/registermodel.dart';
import 'package:todoapp/todocard.dart';


class Register extends StatefulWidget {
  const Register({Key? key, required String username, required String city, required String age, required String email, required String mobilenumber, required String password}) : super(key: key);


  @override
  _RegisterState createState() => _RegisterState();

  static fromMap(Map<String, Object?> c) {}
}


class _RegisterState extends State<Register> {
  final _usernameController = TextEditingController();
  final _cityController = TextEditingController();
  final _mobilenumController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _focusname = FocusNode();
  final _focuscity = FocusNode();
  final _focusnumber = FocusNode();
  final _focusemail = FocusNode();
  final _focuspassword = FocusNode();
  final _focusage = FocusNode();

  bool _isProcessing = false;
  bool validate = false;
  bool validatePass = false;
  bool validateName = false;
  bool validateAge = false;
  bool validateCity = false;
  bool validateNumber = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusname.unfocus();
        _focuscity.unfocus();
        _focusage.unfocus();
        _focusnumber.unfocus();
        _focusemail.unfocus();
        _focuspassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: SingleChildScrollView(
            child: Center(
              key: formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: _usernameController,
                  focusNode: _focusname,
                  decoration:  InputDecoration(
                    border: const OutlineInputBorder(),
                    hintStyle: const TextStyle(color: Colors.purple),
                    labelText: "Enter your Name",
                   errorText: validateName ? 'field can not be empty' : null,
                  ),


                ),


              ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: _cityController,
                  focusNode: _focuscity,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintStyle: const TextStyle(color: Colors.purple),
                    labelText: 'Enter Your City',
                   errorText: validateCity ? 'field can not be empty' : null,

                  ),

                ),

              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: _mobilenumController,
                  focusNode: _focusnumber,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintStyle: const TextStyle(color: Colors.purple),
                    labelText: 'Enter Your Mobile Number',
                   errorText: validateNumber ? 'field can not be empty' : null,

                  ),

                ),

              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: _ageController,
                  focusNode: _focusage,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintStyle: const TextStyle(color: Colors.purple),
                    labelText: 'Enter Your Age',
                    errorText: validateAge ? 'field can not be empty' : null,

                  ),

                ),

              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: _emailController,
                  focusNode: _focusemail,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintStyle: const TextStyle(color: Colors.blue),
                    labelText: "Enter your Email ",
                    errorText: validate ? 'field can not be empty' : null,
                  ),


                ),

              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: _passwordController,
                  focusNode: _focuspassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintStyle: const TextStyle(color: Colors.purple),
                    labelText: 'Enter Your Password',
                    errorText: validatePass ? 'field can not be empty' : null,

                  ),

                ),

              ),
              SizedBox(height: 32),
              _isProcessing
              ? CircularProgressIndicator()
                  : Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isProcessing = true;
                        });
                      }, child: null,
                    ),
                  )
                ],
              )


            ],
          ),
        )),
        bottomNavigationBar: Container(
            height: 60,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: ElevatedButton(
              child: const Text('SUBMIT'),
              onPressed: () async {


                setState(() {
                  _emailController.text.isEmpty ? validate = true : validate = false;
                  _usernameController.text.isEmpty ? validateName = true : validateName = false;
                  _passwordController.text.isEmpty ? validatePass = true : validatePass = false;
                  _mobilenumController.text.isEmpty ? validateNumber = true : validateNumber = false;
                  _ageController.text.isEmpty ? validateAge = true : validateAge = false;
                  _cityController.text.isEmpty? validateCity = true : validateCity = false;


                });

                if(validate || validatePass || validateCity || validateAge || validateNumber || validateName){
                }else {
                  submitDetails(_usernameController.text ?? "Shivi",
                      _ageController.text ?? "24",
                      _cityController.text ?? "Mathura",
                      _emailController.text ?? "abc@example.com",
                      _mobilenumController.text ?? "1234567789",
                      _passwordController.text ?? "123456");

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>
                      const Register(username: '',
                        city: '',
                        age: '',
                        email: '',
                        mobilenumber: '',
                        password: '',),));

                  // or
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TodoCard()));
                }
    },
            )

        ),
      ),
    );

  }

  submitDetails(String user, String a, String c, String s, String m,
      String n,) async {

    RegisterModel userDetails = RegisterModel(age: a,
        city: c,
        email: s,
        mobilenumber: m,
        password: n,
        username: user);
        await DBProvider.db.newRegisterModel(userDetails) ;
        if (kDebugMode) {
          print("insert successful");
        }
        else{
          print("Not successful");
        }
  }
}




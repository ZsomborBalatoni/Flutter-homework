//ignore_for_file: unused_local_variable
//ignore_for_file: prefer_const_literals_to_create_immutables
//ignore_for_file: prefer_const_constructors
// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields, unused_field, body_might_complete_normally_nullable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_homework/ui/bloc/login/login_bloc.dart';
import 'package:validators/validators.dart';

class LoginPageBloc extends StatefulWidget {
  const LoginPageBloc({super.key});

  @override
  State<LoginPageBloc> createState() => _LoginPageBlocState();
}

class _LoginPageBlocState extends State<LoginPageBloc> {
  @override
  void initState() {
    super.initState();
  }

  String _email = '';
  String _password = '';

  String errorEmailTextvalue = '';
  String errorPasswordTextvalue = '';

  final GlobalKey<_LoginPageBlocState> _formkey =
      GlobalKey<_LoginPageBlocState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[500],
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                //Hello
                SizedBox(height: 40),
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),

                //email
                SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              errorEmailTextvalue = value;
                            } else {
                              errorEmailTextvalue = '';
                              _email = value.toString();
                            }
                          });
                        },
                        onSaved: (email) {
                          setState(() {
                            _email = email.toString();
                          });
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          errorText: errorEmailTextvalue.isEmpty
                              ? null
                              : 'Nem megfelelő formátum!',
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),

                //password
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    width: 400,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            if (value.length < 6) {
                              errorPasswordTextvalue = value;
                            } else {
                              errorPasswordTextvalue = '';
                              _password = value.toString();
                            }
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.password),
                          errorText: errorPasswordTextvalue.isEmpty
                              ? null
                              : 'Túl rövid jelszó!',
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),

                //jegyezz meg checkbox
                SizedBox(height: 20),

                //bejelentkezési gomb
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: (() {
                    if (errorEmailTextvalue == '' &&
                        errorPasswordTextvalue == '') {
                      //context.read(<LoginBloc>().add(LoginSubmitEvent(email, password, rememberMe)))
                    }
                    ;
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[200],
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    //throw UnimplementedError('Page not implemented!');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
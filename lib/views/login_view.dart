import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter your email here',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter your password here',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  )
                  .then(
                      (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                            notesRoute,
                            (route) => false,
                          ))
                  .catchError(
                (error) async {
                  if (error is FirebaseAuthException) {
                    final FirebaseAuthException e = error;
                    if (e.code == 'invalid-credential') {
                      await showErrorDialog(
                        context,
                        'Invalid credentials entered!',
                      );
                    } else {
                      await showErrorDialog(
                        context,
                        'Error: ${e.code}',
                      );
                    }
                  } else {
                    await showErrorDialog(
                      context,
                      error.toString(),
                    );
                  }
                  return 0;
                },
              );
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Not Registered Yet? Register here!'),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: Center(
            child: TextButton(
                child: const Text('Sign in with Google'),
                onPressed: () async {
                  await authService.googleSignIn();
                })));
  }
}

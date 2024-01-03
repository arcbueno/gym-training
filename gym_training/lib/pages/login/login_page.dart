import 'package:flutter/material.dart';
import 'package:gym_training/utils/extensions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(),
            12.h,
            TextFormField(),
            12.h,
            TextButton(
              onPressed: () {},
              child: const Text('Log in'),
            )
          ],
        ),
      ),
    );
  }
}

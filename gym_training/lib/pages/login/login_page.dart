import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_training/pages/home/home_page.dart';
import 'package:gym_training/pages/login/login_controller.dart';
import 'package:gym_training/utils/extensions.dart';
import 'package:gym_training/widgets/custom_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late final LoginController _controller;

  @override
  void initState() {
    _controller = Get.find<LoginController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                32.h,
                CustomFormField(
                  hintText: 'Email',
                  onChanged: (val) {
                    _controller.email = val;
                  },
                  validator: (value) {
                    if (value.isNullOrEmpty) return 'Required Field';
                    return null;
                  },
                ),
                16.h,
                CustomFormField(
                  hintText: 'Password',
                  onChanged: (val) {
                    _controller.password = val;
                  },
                  isPassword: true,
                  validator: (value) {
                    if (value.isNullOrEmpty) return 'Required Field';
                    return null;
                  },
                ),
                12.h,
                ElevatedButton(
                  onPressed: () async {
                    var success = _formKey.currentState?.validate();
                    if (success ?? false) {
                      var loginSuccess = await _controller.login();
                      if (loginSuccess) {
                        Get.offAll(() => const HomePage());
                      }
                    }
                  },
                  child: const Text('Log in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

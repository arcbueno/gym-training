import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_training/pages/create_account/create_account_controller.dart';
import 'package:gym_training/pages/create_account/state.dart';
import 'package:gym_training/utils/extensions.dart';
import 'package:gym_training/widgets/custom_form_field.dart';
import 'package:gym_training/widgets/error_text.dart';
import 'package:gym_training/widgets/save_form_button.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  late final CreateAccountController _controller;

  @override
  void initState() {
    _controller = CreateAccountController(repository: Get.find());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(() {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create a account',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    32.h,
                    CustomFormField(
                      hintText: 'Email',
                      onChanged: (val) {
                        _controller.email = val;
                      },
                      validator: (value) {
                        if (value.isNullOrEmpty) {
                          return 'Required Field';
                        }
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
                        if (value.isNullOrEmpty) {
                          return 'Required Field';
                        }
                        return null;
                      },
                    ),
                    16.h,
                    CustomFormField(
                      hintText: 'Repeat password',
                      onChanged: (val) {
                        _controller.repeatedPassword = val;
                      },
                      isPassword: true,
                      validator: (value) {
                        if (_controller.password !=
                            _controller.repeatedPassword) {
                          return 'Password don\'t match';
                        }
                        return null;
                      },
                    ),
                    12.h,
                    if (_controller.state.value is CreateAccountError)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ErrorText(
                          text: (_controller.state.value as CreateAccountError)
                              .errorMessage,
                        ),
                      ),
                    SaveFormButton(
                      onTap: () async {
                        var success = _formKey.currentState?.validate();
                        if (success ?? false) {
                          var loginSuccess = await _controller.save();
                          if (loginSuccess) {
                            Get.back();
                          }
                        }
                      },
                      text: 'Create account',
                      isLoading:
                          _controller.state.value is CreateAccountLoading,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

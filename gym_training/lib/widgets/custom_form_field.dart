import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String hintText;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool isPassword;

  const CustomFormField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool showPassword = false;

  @override
  void initState() {
    showPassword = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 5.0),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        hintText: widget.hintText,
        suffixIcon: !widget.isPassword
            ? null
            : IconButton(
                onPressed: () {
                  setState(
                    () {
                      showPassword = !showPassword;
                    },
                  );
                },
                icon: showPassword
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: showPassword,
    );
  }
}

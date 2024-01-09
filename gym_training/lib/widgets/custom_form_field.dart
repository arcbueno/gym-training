import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatefulWidget {
  final String hintText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final String? initialValue;

  const CustomFormField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.controller,
    this.isPassword = false,
    this.validator,
    this.maxLines,
    this.keyboardType,
    this.inputFormatters,
    this.contentPadding,
    this.initialValue,
  }) : assert(controller != null || onChanged != null);

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
      controller: widget.controller,
      initialValue: widget.initialValue,
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
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
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';

class GTTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool autofocus;
  final bool isPassword;
  final int? maxLength;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;
  final bool? enableInteractiveSelection;
  final void Function()? onTap;

  const GTTextField(
      {Key? key,
      this.label,
      this.hintText,
      this.controller,
      this.maxLength,
      this.textInputType,
      this.onChanged,
      this.textInputAction,
      this.onEditingComplete,
      this.enableInteractiveSelection,
      this.autofocus = false,
      this.isPassword = false,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      enableInteractiveSelection: enableInteractiveSelection,
      obscureText: isPassword,
      enableSuggestions: !isPassword,
      autocorrect: !isPassword,
      autofocus: autofocus,
      style: AppTextTheme.T4,
      cursorColor: Colors.black,
      keyboardType: textInputType,
      maxLength: maxLength,
      controller: controller,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        counterText: "",
        fillColor: AppColorTheme.white,
        filled: true,
        hintStyle: AppTextTheme.Explain,
        floatingLabelStyle: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.4),
            fontWeight: FontWeight.w500,
            fontSize: 12),
      ),
    );
  }
}

class GTTextFormField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool autofocus;
  final bool isPassword;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;
  final bool? enableInteractiveSelection;
  final void Function()? onTap;
  final bool readOnly;
  final Color color;

  const GTTextFormField(
      {Key? key,
      this.label,
      this.hintText,
      this.controller,
      this.maxLength,
      this.maxLines,
      this.textInputType,
      this.validator,
      this.onChanged,
      this.textInputAction,
      this.onEditingComplete,
      this.enableInteractiveSelection,
      this.autofocus = false,
      this.isPassword = false,
      this.onTap,
      this.readOnly = false,
      this.color = AppColorTheme.Gray3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onTap: onTap,
      enableInteractiveSelection: enableInteractiveSelection,
      textInputAction: textInputAction,
      obscureText: isPassword,
      enableSuggestions: !isPassword,
      autocorrect: !isPassword,
      autofocus: autofocus,
      style: AppTextTheme.T4,
      onEditingComplete: onEditingComplete,
      cursorColor: Colors.black,
      keyboardType: textInputType,
      maxLength: maxLength,
      maxLines: maxLines,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        labelStyle: AppTextTheme.T6.copyWith(color: AppColorTheme.Gray3),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 3,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 3,
          ),
        ),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: color,
            width: 3,
          ),
        ),
        counterText: "",
        fillColor: Colors.transparent,
        filled: true,
        hintStyle: AppTextTheme.Explain,
        floatingLabelStyle: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.4),
            fontWeight: FontWeight.w500,
            fontSize: 12),
      ),
      validator: validator,
    );
  }
}

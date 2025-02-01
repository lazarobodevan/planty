import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/theme_colors.dart';
import '../../theme/typography_styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  bool isObscureText;
  final String? hintText;
  final Icon? prefixIcon;
  final bool isShowSuffixIcon;
  final String? label;
  final bool isActive;
  final Function(String s) onChanged;
  final List<TextInputFormatter>? textInputFormatters;

  CustomTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.isObscureText = false,
    this.hintText,
    this.prefixIcon,
    this.isShowSuffixIcon = false,
    this.label,
    this.isActive = true,
    required this.onChanged,
    this.textInputFormatters,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    Icon suffixIcon = widget.isObscureText
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.065,
      child: TextFormField(
        style: widget.isActive
            ? TypographyStyles.paragraph4()
            : TypographyStyles.paragraph4().copyWith(
          color: Colors.grey,
        ),
        controller: widget.controller,
        obscureText: widget.isObscureText,
        obscuringCharacter: "*",
        keyboardType: widget.keyboardType,
        inputFormatters: widget.textInputFormatters,
        enabled: widget.isActive,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(12, 10, 0, 10),
            hintText: widget.hintText,
            labelStyle: TypographyStyles.paragraph4(),
            labelText: widget.label ?? widget.label,
            border: InputBorder.none,
            filled: true,
            fillColor: widget.isActive ? Colors.white : Colors.grey.shade400,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isShowSuffixIcon
                ? IconButton(
              icon: suffixIcon,
              onPressed: () {
                setState(() {
                  widget.isObscureText = !widget.isObscureText;
                  suffixIcon = widget.isObscureText
                      ? const Icon(Icons.visibility_outlined)
                      : const Icon(Icons.visibility_off_outlined);
                });
              },
            )
                : null,
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(width: 1, color: ThemeColors.primary1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(width: 1, color: Colors.grey.shade400)),
            disabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(width: 1, color: Colors.grey.shade400))),
      ),
    );
  }
}
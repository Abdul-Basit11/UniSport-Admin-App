import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../const/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? validator;
  bool obsecureText;
  bool isPasswordField;
  final IconData? prefixIcon;
  final Widget? suffixicon;
  final TextAlign? textAlign;
  final TextInputType? textInputType;
  final int? maxline;
  final bool isPrefixIcon;
  final VoidCallback? onTapped;
  final bool enable;
  final bool? readOnly;
  final ValueChanged<String>? onValueChanged;
  final ValueChanged<String>? onFieldSubmitted;

  CustomTextField({
    super.key,
    required this.hintText,
    this.onValueChanged,
    this.suffixicon,
    this.enable = true,
    this.onTapped,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.obsecureText = false,
    this.isPasswordField = false,
    this.textAlign,
    this.textInputType,
    this.maxline = 1,
    this.isPrefixIcon = false,
    this.onFieldSubmitted, this.readOnly=false,
  });

  @override
  State<CustomTextField> createState() => _CuctomTextFieldState();
}

class _CuctomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        readOnly:widget.readOnly??false ,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onValueChanged,
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: widget.maxline,
        enabled: widget.enable,
        onTap: widget.onTapped,
        cursorColor: AppColors.kSecondary,
        keyboardType: widget.textInputType ?? TextInputType.text,
        textAlign: widget.textAlign ?? TextAlign.start,

        controller: widget.controller,
        validator: (val) {
          if (widget.validator != null) {
            return widget.validator!(val!);
          }
          return null;
        },
        obscureText: widget.obsecureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(),
          prefixIcon: widget.isPrefixIcon
              ? Icon(
                  widget.prefixIcon,
                )
              : null,
          suffixIcon: widget.isPasswordField
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.obsecureText = !widget.obsecureText;
                    });
                  },
                  child: Icon(
                    widget.obsecureText ? Iconsax.eye_slash : Iconsax.eye,
                    size: 18,
                  ))
              : Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: widget.suffixicon,
                ),
        ),
      ),
    );
  }
}

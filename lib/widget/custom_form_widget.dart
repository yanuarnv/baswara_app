import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFormWidget extends StatefulWidget {
  final String? hint;
  final TextEditingController? controller;
  final String? label;
  final bool obsecure;
  final bool isOpsional;
  final Widget? suffixIcon;

  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormaters;
  final FormFieldValidator<String>? validation;

  const CustomFormWidget(
      {super.key,
      this.hint,
      this.controller,
      this.validation,
      this.inputFormaters,
      required this.obsecure,
      this.inputType,
      this.isOpsional = true,
      this.label,
      this.suffixIcon});

  @override
  State<CustomFormWidget> createState() => _CustomFormWidgetState();
}

class _CustomFormWidgetState extends State<CustomFormWidget> {
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: GoogleFonts.roboto(fontSize: 14),
      obscureText: widget.obsecure ? hidePass : false,
      inputFormatters: widget.inputFormaters,
      keyboardType: widget.inputType,
      validator: widget.validation ??
          (value) {
            if (value == null || value.isEmpty) {
              if (widget.isOpsional) {
                return 'Please enter some text';
              }
            }
            return null;
          },
      decoration: InputDecoration(
        hintStyle: GoogleFonts.roboto(
          color: const Color(0xffB5B6B8),
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        labelText: widget.label,
        labelStyle: GoogleFonts.roboto(fontSize: 14),
        contentPadding: const EdgeInsets.only(top: 16, bottom: 16, left: 20),
        isDense: true,
        hintText: widget.hint,
        suffixIcon: widget.obsecure
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    hidePass = !hidePass;
                  });
                },
                child: SvgPicture.asset("assets/icons/hide_eye.svg"))
            : widget.suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

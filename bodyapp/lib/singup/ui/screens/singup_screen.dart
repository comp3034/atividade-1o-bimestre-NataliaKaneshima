import 'dart:ui';

import 'package:bodyapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';

class SingUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          body: Column(
            children: [
              Container(
                color: Colors.teal,
                height: size.width * 0.13,
              ),
              SizedBox(
                height: size.width * 0.05,
              ),
              AddImageProfile(size: size),
              SizedBox(
                height: size.width * 0.1,
              ),
              ContaFormWidget(),
              Divider(
                indent: 32,
                endIndent: 32,
                thickness: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      FontAwesomeIcons.facebook,
                      color: Color.fromRGBO(0,0,139, 5),
                      size: size.width * 0.1,
                    ),
                    iconSize: 32,
                  ),
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      FontAwesomeIcons.twitter,
                      color: Color.fromRGBO(0,191,255, 5),
                      size: size.width * 0.1,
                    ),
                    iconSize: 32,
                  ),
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: Color.fromRGBO(178,34,34, 5),
                      size: size.width * 0.1,
                    ),
                    iconSize: 32,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class AddImageProfile extends StatelessWidget {
  const AddImageProfile({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: CircleAvatar(
              radius: size.width * 0.15,
              backgroundColor: Colors.grey[300],
              child: Icon(
                FontAwesomeIcons.user,
                color: Colors.teal,
                size: size.width * 0.15,
              )
          ),
        ),
        Positioned(
          top: size.height * 0.09,
          left: size.width * 0.57,
          child: Container(
            height: size.width * .12,
            width: size.width * .12,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                )
            ),
            child: Icon(
              FontAwesomeIcons.camera,
              color: Colors.teal,
            ),
          ),
        ),

      ],
    );
  }
}

class ContaFormWidget extends StatefulWidget {
  const ContaFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ContaFormWidgetState createState() => _ContaFormWidgetState();
}

class _ContaFormWidgetState extends State<ContaFormWidget> {
  final _formKey = GlobalKey<FormState>();
  RegExp _upper = RegExp(r'[A-Z]');
  RegExp _lower = RegExp(r'[a-z]');
  RegExp _numeric = RegExp(r'[0-9]');
  bool isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputWidget(
              hintText: 'Nome',
              prefixIcon: Icons.account_circle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputWidget(
              hintText: 'Email',
              prefixIcon: Icons.email_outlined,
              validator: (value) {
                if (value != null && !isEmail(value)) {
                  return 'Preencha um e-mail válido.';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputWidget(
              hintText: 'Senha',
              prefixIcon: Icons.lock,
              sufixIcon:
              isPasswordObscured ? Icons.visibility_off : Icons.visibility,
              obscureText: isPasswordObscured,
              suffixIconOnPressed: () {
                setState(() {
                  isPasswordObscured = !isPasswordObscured;
                });
              },
              validator: (value) {
                if (value != null && value.length < 6) {
                  return 'A senha deve conter no mínimo 6 caracteres';
                }
                if (value != null && !value.contains(_upper)) {
                  return 'A senha deve conter pelo menos um caractere uppercase.';
                }
                if (value != null && !value.contains(_lower)) {
                  return 'A senha deve conter pelo menos um caractere lowercase.';
                }
                if (value != null && !value.contains(_numeric)) {
                  return 'A senha deve conter pelo menos um caractere numerico.';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputWidget(
              hintText: 'Confirmar senha',
              prefixIcon: Icons.lock,
              sufixIcon:
              isPasswordObscured ? Icons.visibility_off : Icons.visibility,
              obscureText: isPasswordObscured,
              suffixIconOnPressed: () {
                setState(() {
                  isPasswordObscured = !isPasswordObscured;
                });
              },
              validator: (value) {
                if (value != null && value.length < 6) {
                  return 'A senha deve conter no mínimo 6 caracteres';
                }
                if (value != null && !value.contains(_upper)) {
                  return 'A senha deve conter pelo menos um caractere uppercase.';
                }
                if (value != null && !value.contains(_lower)) {
                  return 'A senha deve conter pelo menos um caractere lowercase.';
                }
                if (value != null && !value.contains(_numeric)) {
                  return 'A senha deve conter pelo menos um caractere numerico.';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: ElevatedButton(
              onPressed: () {},
              child: Center(
                child: Text(
                  'Criar Conta',
                  style: GoogleFonts.rokkitt(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class InputWidget extends StatelessWidget {
  String? hintText;
  IconData? prefixIcon;
  IconData? sufixIcon;
  bool obscureText;
  VoidCallback? suffixIconOnPressed;
  String? Function(String?)? validator;
  void Function(String)? onChanged;

  InputWidget({
    this.hintText,
    this.prefixIcon,
    this.sufixIcon,
    this.obscureText = false,
    this.suffixIconOnPressed,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        fillColor: Colors.grey[300],
        filled: true,
        focusColor: Colors.grey[300],
        hoverColor: Colors.grey[300],
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[800]),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.teal,
        ),
        suffixIcon: IconButton(
          icon: Icon(sufixIcon),
          color: AppColors.teal,
          onPressed: suffixIconOnPressed,
        ),
      ),
      validator: validator,
    );
  }
}


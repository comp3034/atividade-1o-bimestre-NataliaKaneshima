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
         body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.teal,
                height: size.width * 0.1,
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
                thickness: 2,
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
 bool isConfirmPasswordObscured = true;
 bool isPasswordObscured = true;
 String _password = '';

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
             onChanged: (value) {
               setState(() {
                 _password = value;
               });
             },
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: InputWidget(
             hintText: 'Confirmar senha',
             prefixIcon: Icons.lock,
             sufixIcon: isConfirmPasswordObscured
                 ? Icons.visibility_off
                 : Icons.visibility,
             obscureText: isConfirmPasswordObscured,
             suffixIconOnPressed: () {
               setState(() {
                 isConfirmPasswordObscured = !isConfirmPasswordObscured;
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
               if (value != _password) {
                 return 'A senha e confirmação de senha devem ser iguais.';
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
               heightFactor: 1.6,
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



// import 'package:flutter/material.dart';
// enum Auth {
//   signin,
//   signup,
// }//group name
// class RadioButtonCustom extends StatefulWidget {
//   const RadioButtonCustom({super.key});

//   @override
//   State<RadioButtonCustom> createState() => _RadioButtonCustomState();
// }

// class _RadioButtonCustomState extends State<RadioButtonCustom> {
//   Auth _auth = Auth.signup;

//   @override
//   Widget build(BuildContext context) {
//     return Radio(
//                   activeColor: Colors.black,
//                   value: 2,//asign a value
//                   groupValue: _auth,//group name
//                   onChanged: (Auth? val) {
//                     setState(() {
//                       _auth = val!;
//                     });
//                   },
//                 );
//   }
// }
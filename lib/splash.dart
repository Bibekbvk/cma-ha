import 'dart:async';
import 'home.dart';
import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds:3),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>home()
      ));
    });
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
         child: Text(
           "Quiz, For CMA/ HA\n Suitable For CMA/ HA/ ANM/ SN and others \n\n\n\n\n\n By: Bvk", textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold
        ), ) ,

      ),      
    );
  }
}
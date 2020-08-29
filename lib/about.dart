import "package:flutter/material.dart";

class about extends StatefulWidget {
  @override
  _aboutState createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Page'),
      ),
      body: ListView(
       children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
           child:Text("Developed by: Bibek Bhattari \nEmail: bhattaraibvk@gmail.com" +"    " +"\nInfected400@gmail.com", style: TextStyle(
             fontSize:18,
             color:Colors.blueAccent
           ),)


          ),

          
        ),

        Container(
          child:Text("") ,)




       ],



      ),
    );
  }
}
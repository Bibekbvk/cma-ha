import 'package:flutter/material.dart';
import 'package:quiz/home.dart';
import 'package:firebase_admob/firebase_admob.dart';
const String testDevice = '3D30C952BC6E818480B1DC2DD0D7327D';

class resultpage extends StatefulWidget {
  int marks;
  resultpage({Key key, @required this.marks}) : super(key : key);
  @override
  _resultpageState createState() => _resultpageState(marks);
}

class _resultpageState extends State<resultpage> {
  static const MobileAdTargetingInfo targetingInfo= MobileAdTargetingInfo(
     testDevices: testDevice != null ? <String>[testDevice]:null,
     nonPersonalizedAds: true,
     keywords: <String>['Book','quiz','education','course'],
  );
   BannerAd _bannerAd;
   InterstitialAd _interstitialAd;

   InterstitialAd createInterstitialAd(){
   return InterstitialAd(

     adUnitId: 'ca-app-pub-8800892441351115/8110080922',
     
     targetingInfo:targetingInfo,
     listener: (MobileAdEvent event) {
       print("InterstitialAd $event");
     },
   );
   
   @override  
     void initState(){
    FirebaseAdMob.instance.initialize(
      appId: 'ca-app-pub-8800892441351115~8764687047'
    );
     createInterstitialAd()..load()..show();
      super.initState();
     }
     @override
     void dispose(){
       _interstitialAd.dispose();
       super.dispose();
     }
   }
  int marks;
  _resultpageState(this.marks);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        
      ),
      drawer: Drawer(

        child:ListView(
          children:[Card(
            
            elevation: 20,
            
            child:InkWell(
              onTap:(){

              },
              
              child: 
            Text("About")),
          ),


          ],
        )
      ),
      body: ListView(

        children:[
          Card(
          child:Text("Total Marks: $marks / 100", style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700
          ),),
          
          ),
          RaisedButton(
            color: Colors.blueAccent,
            child: Text("Try other set"),
            
            onPressed: (){
              createInterstitialAd()..load()..show();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
       

            }),
            
          Text("Note:-Question and Answer are from different sources. So, the answer may be Varies.\n \n \n Developed by: Bibek Bhattarai")
        ]
      ),
    );
  }
}
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz/result.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = '3D30C952BC6E818480B1DC2DD0D7327D';
class loadjson
 extends StatelessWidget {
   String sets;
   loadjson(this.sets);
   String assettoload;
  
    setasset() {
    if (sets == "one") {
      assettoload = "assets/s1.json";
    } else if (sets == "two") {
      assettoload = "assets/s2.json";
    } else if (sets == "three") {
      assettoload = "assets/s3.json";
    } else if (sets == "four") {
      assettoload = "assets/s4.json";
    } else if (sets == "five") {
      assettoload = "assets/s5.json";
    } else if (sets == "six") {
      assettoload = "assets/s6.json";
    } else if (sets == "seven") {
      assettoload = "assets/s7.json";
       } else if (sets == "Eight") {
      assettoload = "assets/s8.json";
    } else if (sets == "Nine") {
      assettoload = "assets/s9.json";
    } else if (sets == "Ten") {
      assettoload = "assets/s10.json";
    } else if (sets == "Eleven") {
      assettoload = "assets/s11.json";
    } else if (sets == "Twelve") {
      assettoload = "assets/s12.json";
    } else if (sets == "thirteen") {
      assettoload = "assets/s13.json";
  
    } else {
      assettoload = "assets/s14.json";
    }
  }



  @override
  Widget build(BuildContext context) {
    setasset();
    return Scaffold(
      
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString(assettoload, cache:true),
        builder: (context, snapshot){
          List mydata = json.decode(snapshot.data.toString());
          if(mydata == null){
            return Center(
              child: Text("loading......")
            );
          }else{
           return quizpage(mydata : mydata);
          }
        }, 
      ),
    );
  }
}



class quizpage extends StatefulWidget {
  final mydata;

  quizpage({Key key, @required this.mydata }) : super(key : key);
  @override
  _quizpageState createState() => _quizpageState(mydata : mydata);
}

class _quizpageState extends State<quizpage> {
   static const MobileAdTargetingInfo targetingInfo= MobileAdTargetingInfo(
     testDevices: testDevice != null ? <String>[testDevice]:null,
     nonPersonalizedAds: true,
     keywords: <String>['Book','quiz','education','course'],
   );
   BannerAd _bannerAd;
   InterstitialAd _interstitialAd;
   
   BannerAd createbannerAd(){
   return BannerAd(

     adUnitId: BannerAd.testAdUnitId,
     size: AdSize.banner,
     targetingInfo: targetingInfo,
     listener: (MobileAdEvent event) {
       print("BannerAd $event");
     },
   );
   
   @override  
  void initState(){
    FirebaseAdMob.instance.initialize(
      appId: BannerAd.testAdUnitId);
      _bannerAd = createbannerAd()..load()..show();
      super.initState();
     }
     @override
     void dispose(){
       _bannerAd.dispose();
       super.dispose();
     }
   }
   List mydata;
    _quizpageState({this.mydata});

    Color colortoshow = Colors.greenAccent;
    Color right = Colors.green;
    Color wrong = Colors.red;
    int marks = 0;
    int i=1; 
    int timer = 30;
    String showtimer = "30";
    String correctanswer = "Answer";
     Map<String, Color> btnColor ={
     "a": Colors.greenAccent,
     "b": Colors.greenAccent,
     "c": Colors.greenAccent,
     "d": Colors.greenAccent,
     };
     
     bool canceltimer = false;


     

       @override
       void initState(){
         starttimer();
         super.initState();
       }
      
    
     

     void starttimer() async{
      const onesec = Duration(seconds:1);
      Timer.periodic(onesec, (Timer t) {
        setState(() {
         if(timer < 1){
           t.cancel();
           
           nextquestion();
         }else if( canceltimer == true){
           t.cancel();
         
         }
         else{
           timer = timer-1;
         }
         showtimer = timer.toString();
        });

       });
     }

    void nextquestion(){
      canceltimer = false;
      timer = 30;
     setState(() {
        if(i <50){
          correctanswer=mydata[2][i.toString()];
        i++;
        
      }else{

       Navigator.of(context).pushReplacement(MaterialPageRoute(
         builder:(context) => resultpage(marks : marks)
       ));
      }
      btnColor["a"]= Colors.greenAccent;
       btnColor["b"]= Colors.greenAccent;
        btnColor["c"]= Colors.greenAccent;
         btnColor["d"]= Colors.greenAccent;
     });
     starttimer();
      
    }

    void checkanswer(String k){
      if(mydata[2][i.toString()] == mydata[1][i.toString()][k]){
        marks= marks+2;
        colortoshow = right;
      }else{
        colortoshow = wrong;
      }
       setState(() {
        
       btnColor[k] = colortoshow;  
       canceltimer = true;
       

       });

     Timer(Duration (seconds: 1), nextquestion);
    }

    Widget choiceButton(String k){

      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: MaterialButton(onPressed:()=>checkanswer(k), 
        child: Text(mydata[1][i.toString()][k]),

        color: btnColor[k] ,
        minWidth: 250,
        height: 40,
        splashColor: Colors.greenAccent.shade700,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        )
      );
    }
  @override
  Widget build(BuildContext context) {
   

    return WillPopScope(
      onWillPop: (){
       return showDialog(context: context,
       builder: (context) => AlertDialog(
        title: Text("Quiz"),
        content: Text("You cannot leave the game......."),
        actions: [
          FlatButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("ok"))
        ],

       ),);

      },
      child: Scaffold(
             
      body: Column(
        children: [
          Expanded(
            child: Card(
              color:Colors.greenAccent,
              
              
              
            )
          ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
          child: Text(mydata[0][i.toString()])
            
          ),
          
          flex: 3,
        ),
        Expanded(
          child: Container(
            child:Column
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              choiceButton('a'),
              choiceButton('b'),
              choiceButton('c'),
              choiceButton('d'),
            ],)
          ),
          flex:6
        ),
        
        
          Expanded(
           child: Container(
             child:Text("Previous Answer:$correctanswer"),
           )
         ),
         
        
                Expanded(
                
                   child: Container(
                     
                     child:Text(showtimer),
                     
                   
                  ),
                  flex:1
                ),
        
                ],
        
                
              ),
        
              ),
            );
          }
        
          
}
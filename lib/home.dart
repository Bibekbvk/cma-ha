import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz/quizpage.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about.dart';
import 'package:firebase_admob/firebase_admob.dart';


const String testDevice = '3D30C952BC6E818480B1DC2DD0D7327D';



class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
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
List<String> sets =["one","two", "three", "four","five", "six", "seven", "Eight", "Nine", "Ten", "Eleven", "Twelve","thirteen","fourteen"];

  Widget customcard(String sets){
      return Padding(
        
       padding: EdgeInsets.symmetric(
         vertical:20.0,
         horizontal: 30.0,
       ),
         child: InkWell(
           onTap: (){
             createInterstitialAd()..load()..show();
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> loadjson(sets),));
           },
                    child: Material(
             
             borderRadius: BorderRadius.circular(33),
             color: Colors.greenAccent,
             elevation:10.0,
             child: Container(
            child: Column(
                
                children: [
              Padding(
               padding: EdgeInsets.all(20.0),
               child: ClipOval(
                 
                 child: Image (image:  AssetImage('images/set.png'),)
               ),
                  ),

                  Center(
                    child: Text( " Set: $sets \n Total Question: 50 \n Time per question: 30 seconds")
                  )
              ],)


             ),


           ),
         ),

      );


  }
  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setPreferredOrientations( [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: AppBar(
        title:Text("Loksewa Quiz(Health)")
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Image.asset('images/set.png'),
           Card(
             elevation:16,
             child: ListTile(
            
              title: Text("About", style: TextStyle(
               fontSize:22,
               fontWeight:FontWeight.w600
             ),),
              
               onTap: (){
                    createInterstitialAd()..load()..show();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>about()));


            


             },
             ),  ),
           Card(
             elevation:16,
             child: ListTile(
             onTap: (){

               Share.share("Please Download this app !! suitable for HA/ CMA / SN / ANM, https://play.google.com/store/apps/details?id=np.bvk.loksewahacma");
             },
             title: Text("share..", style: TextStyle(
               fontSize:22,
               fontWeight:FontWeight.w600
             ),),
              
             ),  ),
            Card(
             elevation:16,
             child: ListTile(
             onTap: (){
               launch('https://play.google.com/store/apps/details?id=np.bvk.loksewahacma');
             },
             title: Text("Rate....", style: TextStyle(
               fontSize:22,
               fontWeight:FontWeight.w600
             ),),
              
             ),  ),
          ],
          
        ),
        
      ),
      
      backgroundColor: Colors.white,
      body: ListView(
         children: <Widget>[
           customcard(sets[0]),
           customcard(sets[1]),
           customcard(sets[2]),
           customcard(sets[3]),
           customcard(sets[4]),
           customcard(sets[5]),
           customcard(sets[6]),
           customcard(sets[7]),
           customcard(sets[8]),
           customcard(sets[9]),
           customcard(sets[10]),
           customcard(sets[11]),
           customcard(sets[12]),
           customcard(sets[13]),



         ]


      ),
    );
  }
}
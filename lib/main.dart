import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:hafiz_proje/widget/giris_ekrani.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        return Sizer(
      builder: (context, orientation, deviceType) {
    return MaterialApp(
   
      debugShowCheckedModeBanner: false ,
      title: 'Flutter Demo',
      theme: ThemeData(
     
        primarySwatch: Colors.red,
      ),
      home: AnimatedSplashScreen(nextScreen: GirisEkrani(), splash:Image.asset('assets/images/h3.jpg',fit: BoxFit.cover,width: double.infinity,),
      duration: 5000,splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: Colors.black,
            splashIconSize:double.infinity,
             ) ,
    );
  }
  );}
}







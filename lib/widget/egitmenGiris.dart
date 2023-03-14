import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hafiz_proje/widget/egitmen_islem.dart';
import 'package:sizer/sizer.dart';
import '../core/colors/hexColor.dart';
import 'package:firebase_auth/firebase_auth.dart';



class EgitmenGiris extends StatefulWidget {
  const EgitmenGiris({super.key});

  @override
  State<EgitmenGiris> createState() => _EgitmenGirisState();
}

class _EgitmenGirisState extends State<EgitmenGiris> {


  late FirebaseAuth auth;

   
  String email = '';
  String sifre = '';  

   bool emailSecilimi = false;
   bool sifreSecilimi = false;
   bool sifreGoster = true;

   TextEditingController emailController = new TextEditingController();
   TextEditingController sifreController = new TextEditingController();
  
  @override
  void initState() {
    auth = FirebaseAuth.instance;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
    width: double.infinity,
    height: double.infinity,
    alignment: Alignment.center,
    child: Container(
      height: 60.h,
      width: 96.w,
      child: Column(children: [
        Image.asset('assets/images/internet.png', cacheWidth: 110,),
        SizedBox(height: 1.h,),
        Text('Eğitmen giriş sayfası',style: TextStyle(color: Colors.white70,fontSize: 15,  fontWeight: FontWeight.bold, fontFamily: 'ozelRoboto'),),
        SizedBox(height: 4.h,),


        Container(height: 8.h,width: 75.w, padding: const EdgeInsets.all(5.0), child:  TextField(
          controller: emailController,
          
          onChanged: (value) {
            setState(() {
              email = value;
              
              print(email);
            });
          },
          
          cursorColor: Colors.white54,
          style: TextStyle(color: Colors.white, fontFamily: 'ozelRoboto') ,
         
           decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            //labelText:  'Email',
            labelStyle: TextStyle(color: Colors.white70),
            hintText: 'Email',
            hintStyle: TextStyle(color: Colors.white60),
            prefixIcon:  Icon( Icons.email_outlined),
            prefixIconColor: Colors.white70,
            hoverColor: Colors.white60,
            focusColor: Colors.white60,
           
            counterStyle: TextStyle(color: Colors.white)
            
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: Colors.black
        ),
     
        ),
            SizedBox(height: 2.h),

           Container(height: 8.h,width: 75.w, padding: const EdgeInsets.all(5.0), child:  TextField(
          controller: sifreController,
           
          onChanged: (value) {
            setState(() {
              sifre = value;
              print(sifre);
              
            });
          },
          obscureText: sifreGoster,
          cursorColor: Colors.white54,
          style: TextStyle(color: Colors.white,fontFamily: 'ozelRoboto') ,
         
           decoration: InputDecoration(

            suffixIcon :IconButton( 
              icon: sifreGoster ? 
            
            Icon( Icons.visibility_off, color: Colors.white60, )

            : Icon(Icons.visibility,color: Colors.lightBlueAccent,),

             onPressed: () { setState(() {
               sifreGoster = !sifreGoster;
             }); },),

             enabledBorder: InputBorder.none,
            border: InputBorder.none,
            //labelText:  'Email',
            labelStyle: TextStyle(color: Colors.white70),
            hintText: 'Şifre',
            hintStyle: TextStyle(color: Colors.white60),
            prefixIcon:  Icon( Icons.lock_open_outlined),
            prefixIconColor: Colors.white70,
            hoverColor: Colors.white60,
            focusColor: Colors.white60,
           
            counterStyle: TextStyle(color: Colors.white)
            
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: Colors.black
        ),
       
        ),
         SizedBox(height: 4.h,),
        TextButton(
           onPressed: () {
              emailSifreKontrol();
             email = '';
             sifre = '';      
           },
           child: Text(
              "Giriş",
              style: TextStyle(
                color: Colors.white,
                 letterSpacing: 0.5,
                  fontSize: 16.0, 
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ozelRoboto'
                 ),
               ),
           style: TextButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 23, 28, 92),
            padding: const EdgeInsets.symmetric(
           vertical: 14.0, horizontal: 80),
         shape: RoundedRectangleBorder(
           borderRadius:
        BorderRadius.circular(12.0))))
        
      ]),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
         color: const Color.fromARGB(255, 171, 211, 250).withOpacity(0.4),
       
      ),
    ),
    decoration: BoxDecoration(
      
      gradient: LinearGradient(
         begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            
        colors: [
              //Color.fromARGB(255, 36, 70, 104).withOpacity(0.4)
              HexColor("#4b4293").withOpacity(0.9),
              HexColor("#4b4293").withOpacity(0.9),
              HexColor("#08418e").withOpacity(0.9),
              HexColor("#08418e").withOpacity(0.9)]
      ),
    ),
  ),
    );
  }
  
  void emailSifreKontrol() async{
    
    try {
      var kullaniciBilgiDogrumu = await auth.signInWithEmailAndPassword(email: email, password: sifre);
      debugPrint(kullaniciBilgiDogrumu.toString());
       Navigator.push(context, MaterialPageRoute(builder: (context) => EgitmenIslem(),));
       this.emailController.text ='';
       this.sifreController.text ='';

    }on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found'){

          debugPrint('kullanıcı bulunamadı');

          snackBarMessage('Kullanıcı bulunamadı');

      }else if(e.code == 'wrong-password'){

        debugPrint('şifre yalnış');
         snackBarMessage('Yanlış şifre');
      }
      else{
         snackBarMessage('Bilgileriniz hatalıdır, lütfen kontrol edin');
      }
    }
  }
  void snackBarMessage(String uyariMesaj){
    final snackBar = SnackBar(content: Text(uyariMesaj),duration: Duration(seconds: 3),action: SnackBarAction(label: 'Tamam', onPressed: (){}),);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hafiz_proje/widget/ogrenci_detay.dart';
import 'package:sizer/sizer.dart';

import '../core/colors/hexColor.dart';

class VeliGiris extends StatefulWidget {
  const VeliGiris({super.key});

  @override
  State<VeliGiris> createState() => _VeliGirisState();
}

class _VeliGirisState extends State<VeliGiris> {

 TextEditingController tcController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    String tcNo = '';



     return Scaffold(backgroundColor: Colors.red,
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
        Text('Veli giriş sayfası',style: TextStyle(color: Colors.white70, fontWeight:  FontWeight.bold,fontSize: 16,fontFamily: 'ozelRoboto'),),
        SizedBox(height: 4.h,),


        Container(height: 8.h,width: 75.w, padding: const EdgeInsets.all(5.0),child:  TextField(
            onChanged: (value) {
              tcNo = value;
              print(tcNo);
            },
          controller: tcController,
          keyboardType: TextInputType.number,
          cursorColor: Colors.white54,
          style: TextStyle(color: Colors.white) ,
         
           decoration: InputDecoration(
           
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            //labelText:  'Email',
            labelStyle: TextStyle(color: Colors.white70),
            hintText: 'Tc kimlik no',
            hintStyle: TextStyle(color: Colors.white60,fontFamily: 'ozelRoboto',fontSize: 16),
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
        SizedBox(height: 5.h,),
       TextButton(
           onPressed: () {
            methodOgrenciKontrol(tcNo,context);
                          
           },
           child: Text(
              "Sorgula",
              style: TextStyle(
                color: Colors.white,
                 letterSpacing: 0.5,
                  fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ozelRoboto'
                 ),
               ),
           style: TextButton.styleFrom(
            backgroundColor:  Color.fromARGB(255, 23, 28, 92),
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
  ),);
  }


void methodOgrenciKontrol(String tc,BuildContext context) async {
      
    final kisiVarmi = await FirebaseFirestore.instance.collection('ogrenciler').where('tc',isEqualTo: tc).get();
    
    if(kisiVarmi.docs.isEmpty){
        methodSnackbarMesaj('Kişi bulunamadı', context);
    }
    else{
         final gunlukDersQuery = await kisiVarmi.docs[0].reference.collection('gunlukDers').get();
         final gunlukDers1 = gunlukDersQuery.docs.map((doc) => doc.data()).toList();
      final ad = await kisiVarmi.docs[0].data()['ad'];
      final gunlukDers = gunlukDers1;
      final soyad = await kisiVarmi.docs[0].data()['soyad'];

      
      Navigator.push(context, MaterialPageRoute(builder: (context) => OgrenciDetay(ad: ad,soyad: soyad,gunlukDers: gunlukDers,tc: tc,)));
      this.tcController.text ='';
    }
    
     print(kisiVarmi.docs.isEmpty);
}

void methodSnackbarMesaj(String mesaj, BuildContext context){
      final snackBar = SnackBar(content: Text(mesaj),duration: Duration(seconds: 3),action: SnackBarAction(label: 'Tamam', onPressed: (){}),);
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
}
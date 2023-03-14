import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hafiz_proje/alert_dialog/alert_ogrenci_ekle.dart';
import 'package:hafiz_proje/alert_dialog/alert_ogrenci_sil.dart';
import 'package:sizer/sizer.dart';
import '../alert_dialog/alert_ogrenci_bilgi_gir.dart';
import '../core/colors/hexColor.dart';

class EgitmenIslem extends StatefulWidget {
  const EgitmenIslem({super.key});

  @override
  State<EgitmenIslem> createState() => _EgitmenIslemState();
}

class _EgitmenIslemState extends State<EgitmenIslem> {
 
  @override
  void initState() {
     
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return  Scaffold(
      key: _scaffoldKey,
      body:Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [


      TextButton(onPressed: (){
         showMyDialogOgrenciEkle(context);
      }, 

        child: Container(
          width: 40.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Öğrenci ekle',
        
                 style: TextStyle(
             fontFamily: 'ozelRoboto',color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
              SizedBox(width: 1.w,),
              Icon(Icons.add,color: Colors.black,size: 29,),
            ],
          ),
        )
                ,style: TextButton.styleFrom(backgroundColor: Colors.white54,
                elevation: 30,
                shadowColor: Colors.black,
                
                padding: const EdgeInsets.symmetric(

           vertical: 27.0, horizontal: 70),
           shape: RoundedRectangleBorder(
           borderRadius:
        BorderRadius.circular(12.0),
        side: BorderSide(width: 2,strokeAlign:BorderSide.strokeAlignCenter,))),),
            
            SizedBox(height: 5.h,),


      TextButton(onPressed: (){
            showDialogOgrenciSil(context,_scaffoldKey);
         }, 
        child: Container(
          width: 35.w,
          
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Öğrenci sil',
                 style: TextStyle(
                  
                    fontFamily: 'ozelRoboto',color: Colors.black,fontWeight: FontWeight.bold,fontSize: 19),
                    ),
                    SizedBox(width: 1.w,),
              Icon(Icons.delete,size: 25,color: Colors.black,)
            
              
            ],
          ),
        )
                ,style: TextButton.styleFrom(backgroundColor: Colors.white54,
                elevation: 30,
                shadowColor: Colors.black,
                
                padding: const EdgeInsets.symmetric(

           vertical: 30.0, horizontal: 78),
           shape: RoundedRectangleBorder(
           borderRadius:
        BorderRadius.circular(12.0),
        side: BorderSide(width: 2,strokeAlign:BorderSide.strokeAlignCenter,))),),


            SizedBox(height: 5.h,),

      TextButton(onPressed: (){
            showDialogOgrenciDers(context);
           }, 
         child: Container(
          width: 55.w,
           child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text('Öğrenci ders bilgisini gir',
                 style: TextStyle(
                  
                    fontFamily: 'ozelRoboto',color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 16),),
                SizedBox(width: 1.w,),
              Icon(Icons.edit,size: 25,color: Colors.black,)
             ],
           ),
         )
                ,style: TextButton.styleFrom(backgroundColor: Colors.white60,
                elevation: 30,
                shadowColor: Colors.black,
                
                padding: const EdgeInsets.symmetric(

           vertical: 28.0, horizontal: 43),
           shape: RoundedRectangleBorder(
           borderRadius:
        BorderRadius.circular(12.0),
        side: BorderSide(width: 2,strokeAlign:BorderSide.strokeAlignCenter,))),)
                 


    ]),  width: double.infinity, height: double.infinity, decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
        ,colors: [
          HexColor("#4b4293").withOpacity(0.9),
              HexColor("#4b4293").withOpacity(0.9),
              HexColor("#08418e").withOpacity(0.9),
              HexColor("#08418e").withOpacity(0.9)
      ])
    ),));
  }
  
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hafiz_proje/veri_tabani/ogrenci_ders_bilgi.dart';
import 'package:sizer/sizer.dart';

Future<void> showDialogOgrenciDers(BuildContext parentContext) async {
  String _tcNo='';
   TextEditingController _tcController = new TextEditingController();

  return showDialog<void>(
    context: parentContext,
    builder: (BuildContext context) {
      return  AlertDialog(
        title: Column(
          children: [
            const Text('Ögrenci ders bilgisini gir'),
            SizedBox(height: 2.h),
            
          ],
        ),
        
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
      

           TextField(
            controller: _tcController,
            onChanged: (value) {
              _tcNo = value;
            },
              cursorColor: Colors.black,
               keyboardType: TextInputType.number,
            decoration: InputDecoration(
              
              hoverColor: Colors.black,
              hintText: 'TC. Kimlik no'
            ),
          ),
            ],
          ),
        ),
        actions: <Widget>[
          
                 Center(child: const Text('Günlük alınması gereken ders',style: TextStyle(fontSize: 14),)),
                 SizedBox(height: 2.h,),
               Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   TextButton(onPressed: (){
                    methodDersAlindi(_tcNo,context);
                   }, 
                         child: Text('Alındı',
                            style: TextStyle(
                             
                    fontFamily: 'ozelRoboto',color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),)
                      ,style: TextButton.styleFrom(backgroundColor: Colors.blue,
                      elevation: 30,
                      shadowColor: Colors.black,
                      
                      padding: const EdgeInsets.symmetric(
             
                            vertical: 13.0, horizontal: 33),
                            shape: RoundedRectangleBorder(
                            borderRadius:
                         BorderRadius.circular(12.0),)),),


                 SizedBox(width: 2,),
                
                TextButton(onPressed: (){
                  methodDersAlinmadi(_tcNo,context);
                  }, 
                         child: Text('Alınmadı',
                            style: TextStyle(
                             
                    fontFamily: 'ozelRoboto',color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)
                      ,style: TextButton.styleFrom(backgroundColor: Colors.red,
                      elevation: 30,
                      shadowColor: Colors.black,
                      
                      padding: const EdgeInsets.symmetric(
             
                            vertical: 13.0, horizontal: 26),
                            shape: RoundedRectangleBorder(
                            borderRadius:
                         BorderRadius.circular(12.0),)),),
                 ],
               ),
        ],
      );
    },
  );
}

Future<void> methodDersAlindi(String tc,BuildContext context) async {
  final kisiVarmi = await FirebaseFirestore.instance.collection('ogrenciler').where('tc',isEqualTo: tc).get();

  if(tc == ''){
    methodSnackbarMesaj('Tc Kimlik no alanı boş geçilemez', context);
  }
  else if(kisiVarmi.docs.isEmpty){
    methodSnackbarMesaj('Kişi bulunamadı', context);
  }
   else{
        OgrenciDersBilgi.ogrenciDersBilgisiGir("1",tc);
        methodSnackbarMesaj('Ders bilgisi başarıyla kaydedildi', context);

        print('gönderildi');
   }
  Navigator.of(context, rootNavigator: true).pop();
}

Future<void> methodDersAlinmadi(String tc,BuildContext context) async {
      final kisiVarmi = await FirebaseFirestore.instance.collection('ogrenciler').where('tc',isEqualTo: tc).get();

  if(tc == ''){

    methodSnackbarMesaj('Tc Kimlik no alanı boş geçilemez', context);
  }
  else if(kisiVarmi.docs.isEmpty){
    methodSnackbarMesaj('Kişi bulunamadı', context);
  }
  else{
      OgrenciDersBilgi.ogrenciDersBilgisiGir("0",tc);
      print('göderildi');
      methodSnackbarMesaj('Ders bilgisi başarıyla kaydedildi', context);

   }
  Navigator.of(context, rootNavigator: true).pop();
}

void methodSnackbarMesaj(String mesaj, BuildContext context){
      final snackBar = SnackBar(content: Text(mesaj),duration: Duration(seconds: 3),action: SnackBarAction(label: 'Tamam', onPressed: (){}),);
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
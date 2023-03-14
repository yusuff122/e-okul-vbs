import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hafiz_proje/veri_tabani/ogrenci_sil.dart';
import 'package:sizer/sizer.dart';

Future<void> showDialogOgrenciSil(BuildContext parentContext, GlobalKey<ScaffoldState> _scaffoldKey) async {
  TextEditingController tcController = new TextEditingController();
  String tc = '';

  return showDialog<void>(
    context: parentContext,
    builder: (BuildContext context) {
      
      return  AlertDialog(
        title: Column(
          children: [
             Text('Ögrenci Sil'),
            SizedBox(height: 2.h),
            const Text('Lütfen silmek istediğiniz öğrencinin Tc. kimlik numarasını giriniz',style: TextStyle(fontSize: 12),)
          ],
        ),
        
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
      

           TextField(
             onChanged: (value) {
               tc = value;
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
          
             Center(
               child: TextButton(onPressed:()  {

                 methodOgrenciSil(tc,context,_scaffoldKey);
               // Navigator.of(context, rootNavigator: true).pop();
                
                }, 
                     child: Text('Sil',
                        style: TextStyle(
                         
                fontFamily: 'ozelRoboto',color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),)
                  ,style: TextButton.styleFrom(backgroundColor: Colors.amber,
                  elevation: 30,
                  shadowColor: Colors.black,
                  
                  padding: const EdgeInsets.symmetric(
             
                        vertical: 13.0, horizontal: 60),
                        shape: RoundedRectangleBorder(
                        borderRadius:
                     BorderRadius.circular(12.0),)),),
             )

        ],
      );
    },
  );
}

void methodOgrenciSil(String tcNo,BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey)async {

    final kisiVarmi = await FirebaseFirestore.instance.collection('ogrenciler').where('tc',isEqualTo: tcNo).get();

    if( tcNo != "" && kisiVarmi.docs.isNotEmpty){
      OgrenciSil.ogrenciSil(tcNo,context);
      methodSnackbarMesaj('Öğrenci başarıyla silndi', context);
  }
  
  else{
   /* final snackBar = SnackBar(content: Text('Tc Kimlik numarası alanı boş bırakılamaz'),duration: Duration(seconds: 3),action: SnackBarAction(label: 'Tamam', onPressed: (){}),);
         ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
    
    

    tcNo=="" ? methodSnackbarMesaj('Tc Kimlik numarası alanı boş bırakılamaz',context) : methodSnackbarMesaj('Kişi bulunamadı ',context); 
  }
  Navigator.of(context, rootNavigator: true).pop();
}

void methodSnackbarMesaj(String mesaj, BuildContext context){
      final snackBar = SnackBar(content: Text(mesaj),duration: Duration(seconds: 3),action: SnackBarAction(label: 'Tamam', onPressed: (){}),);
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

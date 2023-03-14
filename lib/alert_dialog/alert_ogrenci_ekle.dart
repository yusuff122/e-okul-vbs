import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hafiz_proje/veri_tabani/ogrenci_ekle.dart';

Future<void> showMyDialogOgrenciEkle(BuildContext parentContext) async {

  TextEditingController isimController = new TextEditingController();
    TextEditingController soyIsimController = new TextEditingController();
      TextEditingController tcController = new TextEditingController();


  String isim = '';
  String soyisim = '';
  String tcKimlikNo = '';

  return showDialog<void>(
    context: parentContext,
    builder: (BuildContext context) {
      return  AlertDialog(
        title:  Text('Ögrenci Ekleme'),
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[

            TextField(
              controller: isimController,
             onChanged: (value) {
              isim = value;
               print(isim);
             },
              cursorColor: Colors.black,
             
            decoration: InputDecoration(
              
              hoverColor: Colors.black,
              hintText: 'Ad'
            ),
          ),
           TextField(
            controller: soyIsimController,
            onChanged: (value) {
              soyisim = value;
            },
            
              cursorColor: Colors.black,
              
            decoration: InputDecoration(
              
              hoverColor: Colors.black,
              hintText: 'Soyad'
            ),
          ),
//          SizedBox(height: 6),
           TextField(
            controller: tcController,
            onChanged: (value) {
              tcKimlikNo = value;
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
               child: TextButton(onPressed: (){
                
                ogrenciEkleMethod(isim,soyisim,tcKimlikNo,context);
                Navigator.of(context, rootNavigator: true).pop();
                
                }, 
                     child: Text('Kaydet',
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

void ogrenciEkleMethod(String ad,String soyad,String tc,BuildContext context) {
  if(ad != "" && soyad != ""&& tc != ""){
    OgrenciEkle.ogrenciEkle(ad, soyad, tc);
    methodSnackbarMesaj('Kişi başarıyla kaydedildi', context);
  }
  else{
     methodSnackbarMesaj('Lütfen bütün alanları doldurun', context);
  }
}

void methodSnackbarMesaj(String mesaj, BuildContext context){
      final snackBar = SnackBar(content: Text(mesaj),duration: Duration(seconds: 3),action: SnackBarAction(label: 'Tamam', onPressed: (){}),);
         ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
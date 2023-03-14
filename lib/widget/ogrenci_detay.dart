import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hafiz_proje/widget/graph/pie_chart.dart';
import 'package:sizer/sizer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../core/colors/hexColor.dart';
import 'package:intl/intl.dart';


class OgrenciDetay extends StatefulWidget {
  String ad ="";
  String soyad = "";
  List gunlukDers =[];
  String tc = "";

   OgrenciDetay({required this.ad, required this.soyad, required this.gunlukDers, required this.tc});

  @override
  State<OgrenciDetay> createState() => _OgrenciDetayState();
}

class _OgrenciDetayState extends State<OgrenciDetay> {

     final List<String> items = [
    '1 hafta',
    '1 ay',
    '3 ay',
    '6 ay',
  ];

  final dataRef = FirebaseFirestore.instance.collection('ogrenciler');
final DateTime now = DateTime.now();

  String secilenItem = '';
  int alinanDers =0;
  int alinmayanDers =0;
  
  @override
  void initState() {
   secilenItem = items[1];
      print(widget.tc);
      print(widget.soyad);
      alinanDers = widget.gunlukDers.where((element) => element['ders_alindimi']== '1').length;
      alinmayanDers = widget.gunlukDers.where((element) => element['ders_alindimi']== '0').length;
      print(widget.gunlukDers[0]['tarih'].toString());
      //print(alinanDers);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body:  Container(
        child: CustomScrollView(
          physics: PageScrollPhysics(), 
          slivers: [

              SliverList(delegate: SliverChildBuilderDelegate((context, index) {

                  return Column(children: [
                     SizedBox(height: 5.h,),
                  
                    Container(width: 70.w, height: 10.h,child:  Column(
                      
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
              Text('Ad: ${widget.ad}',style: TextStyle(fontSize: 18,fontFamily: 'ozelRoboto',fontWeight: FontWeight.bold),),
              SizedBox(height: 1.h,),
              Text(' Soyad: ${widget.soyad}',style: TextStyle(fontSize: 17,fontFamily: 'ozelRoboto',fontWeight: FontWeight.bold),),
              SizedBox(width: 10.w,)
                      ],
                    ), decoration: BoxDecoration(
                       color: Colors.white70,
                       borderRadius: BorderRadius.circular(8),
                    ),),
                  
                     SizedBox(height: 5.h,),
                  
                     DropdownButtonHideUnderline(child: DropdownButton2(
                 hint: Row(
                  children: const [
                    Icon(
                      Icons.list,
                      size: 30,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                     Text(
                        'Select Item',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    
                  ],
                ),
                      
                items: items.map((item)=> DropdownMenuItem<String>(value: item, child: Text(item),)).toList(),
                value: secilenItem,
                      
                onChanged: (value) async {
           
                secilenItem = value.toString();
                 print(secilenItem);
                      DateTime startDate;

                    switch (secilenItem) {
                      case '1 hafta':
                        startDate = now.subtract(Duration(days: 7));
                        break;
                      case '1 ay':
                        startDate = now.subtract(Duration(days: 30));
                        break;
                      case '3 ay':
                        startDate = now.subtract(Duration(days: 90));
                        break;
                      case '6 ay':
                        startDate = now.subtract(Duration(days: 180));
                        break;
                      default:
                        startDate = now.subtract(Duration(days: 30));
                    }

              final snapshot = await FirebaseFirestore.instance.collection('ogrenciler').where('tc',isEqualTo: widget.tc).get();
              final gunlukDersQuery = await snapshot.docs[0].reference.collection('gunlukDers').where('tarih',isGreaterThanOrEqualTo: startDate).get();

                int alinan = 0;
                int alinmayan = 0;
                alinanDers =0;
                alinmayanDers =0;
                widget.gunlukDers = [];
                gunlukDersQuery.docs.forEach((doc) {
                  if (doc['ders_alindimi'] == '1') {
                    alinan++;
                  } else {
                    alinmayan++;
                  }
               });
           
              setState(() {
                alinanDers = alinan;
                alinmayanDers = alinmayan;
                widget.gunlukDers = gunlukDersQuery.docs.map((doc) => doc.data()).toList();
              });
               print(alinanDers);
              print(alinmayanDers);
                  
                },
              icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                ),
                     iconSize: 17,
                iconEnabledColor: Colors.yellow,
                iconDisabledColor: Colors.grey,
                buttonHeight: 50,
                buttonWidth: 180,
                buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                buttonDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                  color: Colors.redAccent,
                 
                  
                ),
                buttonElevation: 2,
                itemHeight: 40,
                itemPadding: const EdgeInsets.only(left: 14, right: 14),
                dropdownMaxHeight: 200,
                dropdownWidth: 180,
                dropdownPadding: null,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.yellow,
                ),
                dropdownElevation: 8,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                offset: const Offset(-20, 0),
                      )
                      ),
                      SizedBox(height: 7.h,),
                      Container(
                      
                      height: 45.h, width: double.infinity, child:  OgreciGrafik(alinanDers: alinanDers,alinmayanDers: alinmayanDers,)),
                    
                    
                    Container(width: 50.w, height: 7.h,child:  
              Center(child: Text('Ders Detayları',style: TextStyle(fontSize: 18,fontFamily: 'ozelRoboto',fontWeight: FontWeight.bold),)),
              
                      
                     decoration: BoxDecoration(
                       color: Colors.white70,
                       borderRadius: BorderRadius.circular(8),
                    ),),
            
                     SizedBox(height: 3.h,),
              ],);


;
                },childCount: 1)),
                      

              SliverList(delegate: SliverChildBuilderDelegate((context, index) {
                   return Card(
                    color: Colors.white60,
                      elevation: 5,
                      child: ListTile(
                      
                      title: Text('Ders Tarihi',style: TextStyle(color: Colors.black,fontFamily: 'ozelRoboto',fontSize: 16,fontWeight: FontWeight.bold),),
                      subtitle: Text(
                         DateTime.fromMillisecondsSinceEpoch( widget.gunlukDers[index]['tarih'].seconds * 1000).day.toString() + "/" +
                         DateTime.fromMillisecondsSinceEpoch(widget.gunlukDers[index]['tarih'].seconds * 1000).month.toString() + "/" +
                       DateTime.fromMillisecondsSinceEpoch(widget.gunlukDers[index]['tarih'].seconds * 1000).year.toString(),
 
                        style: TextStyle(color: Colors.black,fontFamily: 'ozelRoboto',fontSize: 15,fontWeight: FontWeight.bold),),
                       leading: widget.gunlukDers[index]['ders_alindimi'] == "1" ? Icon(
                        Icons.check_circle_outlined,color: Color.fromARGB(255, 40, 107, 42) 
                        ,size: 40,) :
                        Icon(
                        Icons.highlight_off,color: Color.fromARGB(255, 201, 0, 0) 
                        ,size: 40,),
                    
                       trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                          Text('Ders Durumu',style: TextStyle(color: Colors.black,fontFamily: 'ozelRoboto',fontSize: 15,fontWeight: FontWeight.bold),),
                           Text(
                             widget.gunlukDers[index]['ders_alindimi'] == "1" ? 'Alındı' : 'Alınmadı',
                           style: TextStyle(
                            color:  widget.gunlukDers[index]['ders_alindimi'] == "1"? Color.fromARGB(255, 21, 107, 24) :  Color.fromARGB(255, 201, 0, 0)  ,fontFamily: 'ozelRoboto',
                            fontWeight: FontWeight.bold,fontSize: 17),),
                         ],
                       ),
                       
                      ),
                    );
                },childCount: widget.gunlukDers.length))
          ],
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
      )
   );
  }
  Future<void> getGunlukDers(String tcsi , int alinan, int alinmayan) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('ogrenciler')
      .where('tc', isEqualTo: tcsi)
      .get();
  List<DocumentSnapshot> documents = querySnapshot.docs;
  List<Map<String, dynamic>> gunlukDersleri = [];
  List<Map<String, dynamic>> gunlukDersleri1 = [];
  DateTime oneWeekAgo = DateTime.now().subtract(Duration(days: 1));
  
  for (DocumentSnapshot document in documents) {
      
    List<dynamic> gunlukDersList = document['gunlukDers'];

    for (Map<String, dynamic> gunlukDers in gunlukDersList) {

    DateTime dersTarihi = (gunlukDers['tarih'] as Timestamp).toDate();

      if (dersTarihi.isAfter(oneWeekAgo) && gunlukDers['ders_alindimi'] == '0') {
        
        gunlukDersleri.add(gunlukDers);
        alinmayan =0;
        alinmayan += gunlukDers.length;
        this.alinmayanDers =0;
        this.alinmayanDers = alinmayan;
      }
      else if(dersTarihi.isAfter(oneWeekAgo) && gunlukDers['ders_alindimi'] == '1'){
        gunlukDersleri1.add(gunlukDers);
        alinan =0;
        alinan+= gunlukDersleri1.length;
        this.alinanDers =0;
        this.alinanDers = alinan;
      }
    }
  }
  // gunlukDersleri listesi burada kullanılabilir
}
} 






/*
 case '1 ay':
              setState(() {
                  alinanDers = widget.gunlukDers.where((element) => element['ders_alindimi']== '1' && element['tarih'] > DateTime.now().subtract(Duration(days: 30))).length;
                  alinmayanDers = widget.gunlukDers.where((element) => element['ders_alindimi']== '0' && element['tarih'] > DateTime.now().subtract(Duration(days: 30))).length;
              });
              break;








                switch (secilenItem) {
    case '1 hafta':
      final alinanDersCount = widget.gunlukDers.where((element) => element['ders_alindimi']== '1' && element['tarih'] > DateTime.now().subtract(Duration(days: 7))).length;
      final alinmayanDersCount = widget.gunlukDers.where((element) => element['ders_alindimi']== '0' && element['tarih'] > DateTime.now().subtract(Duration(days: 7))).length;

      setState(() {
        alinanDers = alinanDersCount;
        alinmayanDers = alinmayanDersCount;
      });
      break;

    case '1 ay':
      final alinanDersCount = widget.gunlukDers.where((element) => element['ders_alindimi']== '1' && element['tarih'] > DateTime.now().subtract(Duration(days: 30))).length;
      final alinmayanDersCount = widget.gunlukDers.where((element) => element['ders_alindimi']== '0' && element['tarih'] > DateTime.now().subtract(Duration(days: 30))).length;

      setState(() {
        alinanDers = alinanDersCount;
        alinmayanDers = alinmayanDersCount;
      });
      break;

    // Add other cases as needed
  }*/
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OgrenciDersBilgi{

    static Future<void> ogrenciDersBilgisiGir(String dersBilgi,tc) async {
         FirebaseFirestore firestore = FirebaseFirestore.instance;
         DateTime now = DateTime.now();
         
         
    print(now);
    try {
      final veri = {'ders_alindimi': dersBilgi, 'tarih': now};
   
     final kisi =await firestore.collection('ogrenciler').where('tc',isEqualTo: tc).get();
        kisi.docs.forEach((document){
          document.reference.collection('gunlukDers').add(veri);
      });
      
    } catch (e) {
      debugPrint('Öğrenci eklenirken hata oluştu: $e');
    }
  }
}























/*


  CollectionReference derslerRef = firestore.collection('ogrenciler');
     DocumentReference dersBelgesiRef = derslerRef.doc('gunlukDers');
     dersBelgesiRef.update({'alan': FieldValue.arrayUnion([veri])});







final firestoreInstance = FirebaseFirestore.instance;

void addDailyLesson(int value) {
  DateTime now = DateTime.now();
  DailyLesson dailyLesson = DailyLesson(value, now);

  firestoreInstance.collection("dailyders").add({
    "value": dailyLesson.value,
    "date": dailyLesson.date,
  })
  .then((value) => print("Daily Lesson Added"))
  .catchError((error) => print("Failed to add daily lesson: $error"));
}



 */
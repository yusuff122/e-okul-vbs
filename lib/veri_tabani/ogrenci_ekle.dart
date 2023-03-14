import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OgrenciEkle {
  static Future<void> ogrenciEkle(String ad, String soyad, String tc) async {
    List gunlukDers=[];
    DateTime dateTime = DateTime.now();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // "ogrenciler" koleksiyonuna referans alınır
    CollectionReference ogrencilerRef = firestore.collection('ogrenciler');

    try {
      // "ogrenciler" koleksiyonuna yeni bir belge (yani yeni bir öğrenci) eklenir
      await ogrencilerRef.add({
        'ad': ad,
        'soyad': soyad,
        'tc': tc,
      });
      

      debugPrint('Öğrenci eklendi: $ad $soyad');
    } catch (e) {
      debugPrint('Öğrenci eklenirken hata oluştu: $e');
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OgrenciSil {
  static Future<void> ogrenciSil(String tc,BuildContext context) async {
    print('ogrenci sil veri tabani $tc');
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    try {
          final silinecekKisi =await firestore.collection('ogrenciler').where('tc',isEqualTo: tc).get();
          silinecekKisi.docs.forEach((document){
            document.reference.delete();
          });
          print('kullanıcı başarıyla silindi');

    } catch (e) {
      debugPrint('Öğrenci silinirken hata oluştu: $e');
    }
  }
}

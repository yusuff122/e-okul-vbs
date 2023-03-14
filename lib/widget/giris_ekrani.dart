import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:hafiz_proje/widget/egitmenGiris.dart';
import 'package:hafiz_proje/widget/veliGiris.dart';

import '../core/colors/hexColor.dart';
class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
   Widget? _child;
   @override
  void initState() {
    _child = EgitmenGiris();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 137, 171, 230),
          body:  _child,
          bottomNavigationBar: FluidNavBar(
            
            icons: [
            FluidNavBarIcon(
              icon: Icons.home,
              backgroundColor: Color(0xFF4285F4),
            ),
             FluidNavBarIcon(
              icon: Icons.person,
              backgroundColor: Color(0xFF4285F4),
            )
          ],
          onChange: _sayfaGecis,
          style: FluidNavBarStyle(iconUnselectedForegroundColor: Colors.white,barBackgroundColor: HexColor("#4b4293").withOpacity(0.6)),
          scaleFactor: 1.5,
          defaultIndex: 0,
           /* itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),*/
          ),
    );
  }

  void _sayfaGecis(int index) {
     setState(() {
      switch (index) {
        case 0:
          _child = EgitmenGiris();
          break;
        case 1:
          _child = VeliGiris();
          break;
      }
       _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
  });
  
  }
}
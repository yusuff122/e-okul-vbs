import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hafiz_proje/core/colors/hexColor.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sizer/sizer.dart';

class OgreciGrafik extends StatefulWidget {
  int alinanDers =0;
  int alinmayanDers =0;
  OgreciGrafik({required this.alinanDers, required this.alinmayanDers});

  @override
  State<OgreciGrafik> createState() => _OgreciGrafikState();
}

class _OgreciGrafikState extends State<OgreciGrafik> {
 

  final colorList = <Color>[
      Color.fromARGB(255, 51, 219, 0),
  Color.fromARGB(255, 236, 38, 12),
  /*Color(0xFF55efc4),
  Color(0xFFffeaa7),
  Color(0xFFa29bfe),
  Color(0xFFfd79a8),
  Color(0xFFe17055),*
  Color(0xFF00b894),*/
  ];

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
  Map<String, double> dataMap = {
    "Alınan": double.parse(widget.alinanDers.toString()),
    "Alınmayan": double.parse(widget.alinmayanDers.toString()),
  };
    return Scaffold(
       //backgroundColor: HexColor("#08418e").withOpacity(0.9),
          
      body: Container(
        height: 45.h, width: double.infinity, 
       
        child: PieChart(
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width / 1.7,
          chartType: ChartType.disc,
          baseChartColor: Colors.grey[300]!,
          colorList: colorList,
          ringStrokeWidth: 32,
          legendOptions: LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: true,
            legendShape: BoxShape.circle,
           
          ),
           
        ),
        decoration: BoxDecoration(
          
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            
            colors: [
            
             HexColor("#4b4293").withOpacity(0.9),
             HexColor("#08418e").withOpacity(0.9)
          ])
        ),
      ),
    );
  }
}
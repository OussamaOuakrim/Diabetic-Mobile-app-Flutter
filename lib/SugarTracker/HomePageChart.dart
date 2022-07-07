import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageChart extends StatefulWidget {
  HomePageChart({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageChartState createState() => _HomePageChartState();
}

class _HomePageChartState extends State<HomePageChart> {
  List<SalesData> _chartData;
  TooltipBehavior _tooltipBehavior;
  
  @override
  void initState() {
    getChartData();
    
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
        child: Scaffold(
            body: SfCartesianChart(
      title: ChartTitle(text: 'Analyse du mesure du glucémie'),
      legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        LineSeries<SalesData,int>(
            name: 'Glucémie',
            dataSource: _chartData,
            xValueMapper: (SalesData sales, _) => sales.day,
            yValueMapper: (SalesData sales, _) => sales.sugarVal,
            dataLabelSettings: DataLabelSettings(isVisible: true),
            enableTooltip: true)
      ],
     /* primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}M',
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),*/
    )));
  }
/*
  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(2017, 25),
      SalesData(2018, 12),
      SalesData(2019, 24),
      SalesData(2020, 18),
      SalesData(2021, 30)
    ];
    return chartData;
  }
*/
  getChartData() async {
    FirebaseAuth auth =FirebaseAuth.instance ;
    String uid = auth.currentUser.uid.toString();
    List<SalesData> fdata=[SalesData(2,20),SalesData(2,20),SalesData(2,20),SalesData(2,20),SalesData(2,20),
    SalesData(2,20),SalesData(2,20),SalesData(2,20),SalesData(2,20),SalesData(2,20)];
    for (var i=1 ; i<11;i++){
       DocumentSnapshot variable = await FirebaseFirestore.instance.collection('Sugar').doc('Juin').collection(uid).doc(i.toString()).get();
       fdata[i-1].day = i ;
       fdata[i-1].sugarVal = double.tryParse(variable["SugarVal"]);    
    }
    _chartData= fdata;  
  }
}

class SalesData {
  SalesData(this.day, this.sugarVal);
   num day;
   double sugarVal;
}
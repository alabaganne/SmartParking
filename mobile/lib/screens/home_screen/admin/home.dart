import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile/screens/login_screen/login.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white60 ,
        actions: [ElevatedButton(onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const Login()));
        }, style: ElevatedButton.styleFrom(primary: Colors.red), child: const Text('Log Out'),)],),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String name = "radwan";
  String place = "B1";
  String date = "12/02/1999";
  String price = "30";

  @override
  Widget build(BuildContext context) {

    return ListView.builder(itemCount: 6,itemBuilder: (context, index){
      if(index == 0){
        return Overfill();
      }
      return Padding(padding: const EdgeInsets.all(8),
        child: Material(
          elevation: 8,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50)
            ),
            height: 150,
            child: Slidable(
              endActionPane: ActionPane(motion: ScrollMotion(),
              children: [
                SlidableAction(onPressed: (context){

                },
                backgroundColor: const Color(0xff791818),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: "Remove",
                )
              ],

              ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Client Name: ${name}"),
                        Text("Place: ${place}"),
                        Text("Reservation Date: ${date}")
                      ],),
                     Text("${price} dt")
                  ],),
              ),
            ),
          ),),
        );
    });
  }
}

class Overfill extends StatefulWidget {
  const Overfill({Key? key}) : super(key: key);

  @override
  State<Overfill> createState() => _OverfillState();
}

class _OverfillState extends State<Overfill> {

  TooltipBehavior? _tooltipBehavior;
  List<_ChartData>? chartData;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    chartData = <_ChartData>[
      _ChartData(
          'Full', 3500, const Color.fromRGBO(235, 97, 143, 1), 'Block A'),
      _ChartData(
          'Full', 5000, const Color.fromRGBO(97, 235, 198, 1.0), 'Block B'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildAngleRadialBarChart();
  }

  /// Retunrs the circular charts with radial series.
  SfCircularChart _buildAngleRadialBarChart() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return SfCircularChart(
        key: GlobalKey(),
        legend: Legend(
            toggleSeriesVisibility: false,
            iconHeight: 20,
            iconWidth: 20,
            overflowMode: LegendItemOverflowMode.wrap),
        title:
        ChartTitle(text:'Parking Fullness Percentage %'),
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
            angle: 0,
            radius: '0%',
            height: '35%',
            width: orientation == Orientation.landscape
                ? '65%'
                : '55%',
            widget: Column(
              children: const <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: 0),
                    child: Text('Empty -',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:15))),
                Padding(
                    padding: EdgeInsets.only(
                        top:0)),
                Text('6 spots',
                    softWrap: false,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14))
              ],
            ),
          ),
        ],
        series: _getRadialBarSeries(),
        tooltipBehavior: _tooltipBehavior,
        onTooltipRender: (TooltipArgs args) {

          // ignore: cast_nullable_to_non_nullable
          args.text = chartData![args.pointIndex as int].text ;
              // ignore: cast_nullable_to_non_nullable
        });
  }

  /// Returns radial bar series with legend.
  List<RadialBarSeries<_ChartData, String>> _getRadialBarSeries() {
    final List<RadialBarSeries<_ChartData, String>> list =
    <RadialBarSeries<_ChartData, String>>[
      RadialBarSeries<_ChartData, String>(
          maximumValue: 6000,
          radius: '100%',
          gap: '3%',
          dataSource: chartData,
          cornerStyle: CornerStyle.bothCurve,
          xValueMapper: (_ChartData data, _) => data.x,
          yValueMapper: (_ChartData data, _) => data.y,
          pointColorMapper: (_ChartData data, _) => data.color,
          dataLabelMapper: (_ChartData data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(isVisible: true))
    ];
    return list;
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.color, this.text);

  final String x;
  final num? y;
  final Color color;
  final String text;
}
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile/models/reservations.dart';
import 'package:mobile/screens/login_screen/login.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../helper/invoker.dart';


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
  void initState() {
    // TODO: implement initState
    super.initState();
    Reservations reservations = Provider.of<Reservations>(context, listen: false);
    Invoker.get('/api/reservations').then((value){
     reservations.setList = (value as List).map((e) =>
         Reservation(id: e["id"], matricule: e["matricule"], name: e["name"],
             price: e["price"], noHours: e["noHours"],
             placeId: e["placeId"], date: e["created"])
     ).toList();
    });
  }

  Future<void> onRefresh() async {
    Reservations reservations = Provider.of<Reservations>(context, listen: false);

    dynamic value = await Invoker.get('/api/reservations');
      reservations.setList = (value as List).map((e) =>
          Reservation(id: e["id"], matricule: e["matricule"], name: e["name"],
              price: e["price"], noHours: e["noHours"],
              placeId: e["placeId"], date: e["created"])
      ).toList();

  }
  @override
  Widget build(BuildContext context) {

    return Consumer<Reservations>(
      builder: (context, reservations, child) {
        return RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView.builder(itemCount: reservations.getList.length + 1,itemBuilder: (context, index){
            if(index == 0){
              return Overfill(len: reservations.getList.length,);
            }
            index -= 1;
            Reservation reservation = reservations.getList[index];
            return Padding(padding: const EdgeInsets.all(8),
              child: Material(
                elevation: 8,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  height: 150,
                  child: Slidable(
                    endActionPane: ActionPane(motion: const ScrollMotion(),
                    children: [
                      SlidableAction(onPressed: (context){
                        Invoker.delete('/api/reservations/${reservation.id}').then((value){
                          reservations.removeReservation(reservation);
                        });
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
                              (reservation.name != null)?
                              Text("Client Name: ${reservation.name}")
                              :Row(
                                children: const [
                                  Text("Client Name: "),
                                  Text("Unknown", style: TextStyle(color: Colors.red),)
                                ],
                              ),

                              Text("Place: ${reservation.placeId}"),
                              Text("Reservation Date: ${reservation.reservationDate}"),
                              (reservation.noHours != null)?
                              Text("number of hours: ${reservation.noHours}")
                              :Row(
                                children: const [
                                  Text("number of hours: "),
                                  Text("N/A", style: TextStyle(color: Colors.red),)
                                ],
                              )
                            ],),
                          (reservation.price != null)?
                           Text("${reservation.price} dt")
                            :const Text("N/A", style: TextStyle(color: Colors.red),),

                        ],),
                    ),
                  ),
                ),),
              );
          }),
        );
      }
    );
  }
}

class Overfill extends StatefulWidget {
  Overfill({Key? key, required this.len}) : super(key: key);
  int len;
  @override
  State<Overfill> createState() => _OverfillState();
}

class _OverfillState extends State<Overfill> {

  TooltipBehavior? _tooltipBehavior;
  List<_ChartData>? chartData;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chartData = <_ChartData>[
      _ChartData(
          'Full', 0, const Color.fromRGBO(194, 97, 235, 1.0), 'Block A'),

      _ChartData(
          'Full', widget.len, const Color.fromRGBO(97, 235, 198, 1.0), 'Block B'),
    ];
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
            height: '50%',
            width: orientation == Orientation.landscape
                ? '65%'
                : '55%',
            widget: Column(
              children:  <Widget>[
                const Padding(
                    padding: EdgeInsets.only(
                        top: 0),
                    child: Text('Empty -',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:15))),
                const Padding(
                    padding: EdgeInsets.only(
                        top:0)),
                Text('${10 - widget.len} spots',
                    softWrap: false,
                    style: const TextStyle(
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
          strokeWidth: 1,
          maximumValue: 10,
          radius: '100%',
          gap: '1%',
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
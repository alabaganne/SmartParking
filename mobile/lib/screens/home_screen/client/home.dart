import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile/screens/home_screen/client/add_reservation.dart';
import 'package:provider/provider.dart';

import '../../../helper/invoker.dart';
import '../../../models/reservations.dart';
import '../../../models/user.dart';
import '../../login_screen/login.dart';

class ClientHome extends StatefulWidget {
  const ClientHome({Key? key}) : super(key: key);

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(actions: [ElevatedButton(onPressed: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const Login()));
      }, style: ElevatedButton.styleFrom(primary: Colors.red), child: const Text('Log Out'),)],),
      body: const Body(), floatingActionButton: FloatingActionButton(onPressed: (){
      Navigator.of(context).push (
        MaterialPageRoute (
          builder: (BuildContext context) => const AddReservation(),
        ),
      ).then((value){
        setState((){

        });
      });
    }, child: const Padding(
      padding: EdgeInsets.all(12.0),
      child: Icon(Icons.add),
    ),),);
  }
}



class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Reservations reservations = Provider.of<Reservations>(context, listen: false);
    User user = Provider.of<User>(context, listen: false);

    Invoker.get('/api/reservations/', query: {'userId': user.id.toString()}).then((value){
      reservations.setList = (value as List).map((e) =>
          Reservation(id: e["id"], matricule: e["matricule"], name: e["name"],
              price: e["price"], noHours: e["noHours"],
              placeId: e["placeId"], date: e["created"])
      ).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<Reservations>(
      builder: (context, reservations, child) {
        return ListView.builder(itemCount: reservations.getList.length, itemBuilder: (context, index){
          Reservation reservation = reservations.getList[index];
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Material(
              elevation: 15,
              child: Slidable(
                endActionPane: ActionPane(motion: const ScrollMotion(),
                  children: [
                    SlidableAction(onPressed: (context){
                      Invoker.delete('/api/reservations/${reservation.id}').then((value){
                        print(value);
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
                  title: SizedBox(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          Text("${reservation.matricule}"),
                          Row(
                            children: [
                              const Text("Place: "),
                              Text("${reservation.placeId}", style: const TextStyle(color: Colors.red),)
                            ],
                          )
                        ],),
                         Text("${reservation.placeId} dt", style: const TextStyle(color: Colors.green),)
                      ],
                    ),
                  ),

                ),
              ),
            ),
          );
        });
      }
    );
  }
}

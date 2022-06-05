import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobile/screens/home_screen/client/add_reservation.dart';

import '../../login_screen/login.dart';

class ClientHome extends StatelessWidget {
  const ClientHome({Key? key}) : super(key: key);

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
      );
    }, child: const Padding(
      padding: EdgeInsets.all(12.0),
      child: Icon(Icons.add),
    ),),);
  }
}



class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index){
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Material(
          elevation: 15,
          child: Slidable(
            endActionPane: ActionPane(motion: const ScrollMotion(),
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
              title: SizedBox(
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      Text("123 TUN 1234"),
                      Row(
                        children: [
                          Text("Place: "),
                          Text("B1", style: TextStyle(color: Colors.red),)
                        ],
                      )
                    ],),
                    const Text("23 dt", style: TextStyle(color: Colors.green),)
                  ],
                ),
              ),

            ),
          ),
        ),
      );
    });
  }
}

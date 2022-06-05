
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helper/invoker.dart';
import '../../../models/reservations.dart';
import '../../../models/user.dart';

class AddReservation extends StatelessWidget {
  const AddReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Reservation"),),
      body: const Body(),
    );
  }
}


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}



class _BodyState extends State<Body> {
    
  @override
  initState(){
    super.initState();
    matriculeController = TextEditingController();
    noHoursController = TextEditingController();
    Invoker.get('/api/places').then((value){
      setState((){
        places = List<int>.from(value.map((e) => (e["id"] as int)));
        place = places.first;
      });
    });
  }

  List<int> places = [];
  int? place;
  late TextEditingController matriculeController;
  late TextEditingController noHoursController;
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 50,),

             TextField(
              controller: matriculeController,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                  ),
                  label: Text('Matricule')
              ),
            ),
            const SizedBox(height: 25,),
             TextField(
              keyboardType: TextInputType.number,
              controller: noHoursController,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                  ),
                  label: Text('Number of Hours')
              ),
            ),
            const SizedBox(height: 25,),
            (places.isEmpty)?
                const Text("Sorry There is no empty places")
             :DropdownButton<int>(isExpanded: true, value: place ,items: places.map((e) => DropdownMenuItem<int>(value: e,
              child: Text(e.toString()),)).toList(), onChanged: (value){
               setState((){
                 place = value;
               });
            }),
            const SizedBox(height: 25,),
            ElevatedButton(onPressed:(places.isEmpty)?null: (){
              String mat = matriculeController.text;
              String hours = noHoursController.text;
              if(mat.isEmpty || hours.isEmpty){
                showDialog(context: context,
                    builder: (_){
                    return AlertDialog(title: const Text("Error"),
                    content: SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('please fill all fields'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                              }, child: const Text("oK"))
                            ],
                          )
                        ],
                      ),
                    ),
                    );
                    });
                return;
              }
              User user = Provider.of<User>(context, listen: false);
              Invoker.post('/api/reservations', {
                  'userId': user.id.toString(),
                  'matricule': mat,
                  'noHours': hours,
                   'placeId': place.toString(),
              }, decodeResponse: false).then((value){
                Reservations reservations = Provider.of<Reservations>(context, listen: false);

                Invoker.get('/api/reservations/', query: {'userId': user.id.toString()}).then((value){
                  reservations.setList = (value as List).map((e) =>
                      Reservation(id: e["id"], matricule: e["matricule"], name: e["name"],
                          price: e["price"], noHours: e["noHours"],
                          placeId: e["placeId"], date: e["created"])
                  ).toList();
                });
                  Navigator.of(context).pop("add");
              });
            }, child: const Padding(
              padding: EdgeInsets.all(13.0),
              child: Text('ADD'),
            )),
          ],
        ),
      ),
    );
  }
}

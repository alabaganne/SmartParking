
import 'package:flutter/material.dart';

import '../../../helper/invoker.dart';

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
    Invoker.get('/api/places').then((value){
      setState((){
        places = List<int>.from(value.map((e) => (e["id"] as int)));
        place = places.first;
      });
    });
  }

  List<int> places = [];
  int? place;
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 50,),

            const TextField(
              decoration: InputDecoration(
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
            const TextField(
              decoration: InputDecoration(
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
            ElevatedButton(onPressed: (){

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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/screens/login_screen/login.dart';


class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
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
    Future.delayed(const Duration(seconds: 5), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return const Login();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: height*.08,),
        SvgPicture.asset('assets/images/undraw_by_my_car_ttge.svg', height:height*.4 ,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Best Parking Spots', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 2),),
              const Padding(
                padding: EdgeInsets.all(13.0),
                child: Text('Roast walnut patiently, then mix with ketchup and serve fully in cooker.', textAlign: TextAlign.center,),
              ),
              SizedBox(height: height*.08,),
              const CircularProgressIndicator()
            ],
          ),
        ),
      ],
    );
  }
}

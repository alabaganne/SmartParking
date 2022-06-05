import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/screens/home_screen/admin/home.dart';
import 'package:mobile/screens/home_screen/client/home.dart';
import 'package:mobile/screens/signup_screen/signup.dart';

import '../../constants.dart';
import '../../helper/invoker.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [ElevatedButton(onPressed: (){
        showDialog(context: context, builder: (_){
          TextEditingController controller = TextEditingController();

          return AlertDialog(title: const Text("enter your ip"),
          content: SizedBox(height: 100,child: Column(children: [ TextField(controller: controller,), Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: (){
                Ip.serverHost = "${controller.text}:3000";
                print(Ip.serverHost);
                Navigator.of(context).pop();
              }, child:  Text("Ok")),
            ],
          )],),),);});
      }, child: const Padding(padding: EdgeInsets.all(18),))],),
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
  bool obscure = false;
  late TextEditingController cinController;
  late TextEditingController passwordController;

  @override
  initState(){
    super.initState();
    cinController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height*.01,),
            SvgPicture.asset('assets/images/undraw_city_driver_re_9xyv.svg', height: height*.4,),

            TextField(
              controller: cinController,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
                ),
                label: Text('CIN')
              ),
            ),
            const SizedBox(height: 25,),
            TextField(
              controller: passwordController,
              obscureText: obscure,
              decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    child: Icon(obscure?Icons.remove_red_eye:Icons.visibility_off),
                    onTap: (){
                      setState((){
                        obscure = !obscure;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  label: const Text('password')
              ),
            ),            const SizedBox(height: 25,),
            ElevatedButton(onPressed: (){
              // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
              //   return const ClientHome();
              // }));
             Invoker.post('/api/login', {
               'cin': cinController.text,
               'password': passwordController.text
             }).then((value){
               if(value.containsKey("errorCode")){
                 print("invalid");
                  showDialog(context: context, builder: (context){
                   return AlertDialog(title: const Text("Invalid Credentials"),
                     content: SizedBox(height: 100,
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [const Text("CIN or Password are wrong", style: TextStyle(letterSpacing: 1.4),),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [
                                 TextButton(onPressed: (){Navigator.of(context).pop();},
                                     child: const Text("Ok")),
                               ],
                             )
                           ],
                         )
                     ),
                   );
                 });
                 return;
               }
               if (!value.containsKey('role')){
                 return;
               }
               if(value["role"]  == "admin"){
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                   return const AdminHome();
                 }));
               }else{
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                   return const ClientHome();
                 }));
               }
             });
            }, child: const Padding(
              padding: EdgeInsets.all(13.0),
              child: Text('Login'),
            )),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  const Text("you don't have an account?"),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return const SignUp();
                      }));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Sign Up", style: TextStyle(letterSpacing: 1.5, color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


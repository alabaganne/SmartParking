import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helper/invoker.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

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
  bool obscure = true;

  TextEditingController cinController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 25,),
            SvgPicture.asset('assets/images/undraw_sign_in_re_o58h.svg', height: height*0.4,),
             TextField(
              controller: cinController,
              keyboardType: TextInputType.number,
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
                controller: nameController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                  ),
                  label: Text('Full Name')
              ),
            ),
            const SizedBox(height: 25,),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                  ),
                  label: Text('Phone Number')
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
            ),
            const SizedBox(height: 25,),
            ElevatedButton(onPressed: (){
              String cin = cinController.text;
              String name = nameController.text;
              String password = passwordController.text;
              if(cin.isEmpty || name.isEmpty || password.isEmpty){
                showDialog(context: context, builder: (context){
                  return AlertDialog(title: const Text("Error"),
                    content: SizedBox(height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [const Text("please fill all the fields", style: TextStyle(letterSpacing: 1.4),),
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
              Invoker.post('/api/register', {
                'cin': cin,
                'name': name,
                'password': password
              }, decodeResponse: false).then((value){
                  if(value["result"] != "created"){

                  }else{
                    Navigator.of(context).pop();
                  }
              });
            }, child: const Padding(
              padding: EdgeInsets.all(13.0),
              child: Text('Sign Up'),
            )),
          ],
        ),
      ),
    );
  }
}

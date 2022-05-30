import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            const TextField(
              decoration: InputDecoration(
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
            const TextField(
              decoration: InputDecoration(
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
            const TextField(
              decoration: InputDecoration(
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

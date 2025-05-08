import 'package:flutter/material.dart';
import 'package:medical_user_app/view/ad_screen.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 74,
            ),
            Image.asset('assets/login.png'),
            SizedBox(
              height: 20,
            ),
            Text('Welcome',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 5,
            ),
            Text('Your Health Is Our Priority',style: TextStyle(fontSize: 20),),
            SizedBox(
              height: 301,
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AdScreen()));
            }, child: Image.asset('assets/loading.png'),)
          ],
        ),
      ),
    );
  }
}

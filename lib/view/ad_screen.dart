import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_user_app/view/start_screen.dart';

class AdScreen extends StatelessWidget {
  const AdScreen({super.key});

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
            Align(
              alignment: Alignment.topRight,
              child: Text(
                'Skip',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Image.asset('assets/ad_img.png'),
            SizedBox(
              height: 20,
            ),
            Text(
              'Order Medicines To',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Your Door Steps',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Your Health Is Our Priority',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 180,
            ),
            Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                    color: Color(0XFF5931DD),
                    borderRadius: BorderRadius.circular(100)),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => StartScreen()));
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 24,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

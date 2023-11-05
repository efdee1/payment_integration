import 'package:flutter/material.dart';
import 'package:payment_integration/UI/home.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff0d0c22),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Center(
              child: Image.network(
                'https://media.istockphoto.com/id/1205148147/vector/checkmark-icon-check-mark-vector-isolated-illustration.jpg?s=612x612&w=0&k=20&c=OybmJBTh6t2B9N6B2k3vSPjcDFmqG9rFrRvTI42jKFA=',
                height: height * 0.4,
                width: width * 0.4,
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              message,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                      (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.blue[900], // Change the button color as needed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        25), // Adjust the radius as needed
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            )
          ],
        ),
      )),
    );
  }
}

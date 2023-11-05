import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:payment_integration/UI/payment_success.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _amountcontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  String publicKey = 'pk_test_28f5f7d9803b80bcce6cfb7e196e8a81afb2ee79';
  String message = '';
  final plugin = PaystackPlugin();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    plugin.initialize(publicKey: publicKey);
  }

  void makePayment() async {
    int price = int.parse(_amountcontroller.text) * 100;
    Charge charge = Charge()
      ..amount = price
      ..reference = '${DateTime.now()}'
      // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = _emailcontroller.text
      ..currency = 'NGN';
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    if (response.status == true) {
      message = 'payment successful. Ref: ${response.reference}';
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => PaymentSuccessful(message: message)),
            (route) => false);
      } else {
        print(response.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d0c22),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      //borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://assets.mycast.io/actor_images/actor-djimon-hounsou-115914_large.jpg?1596365111',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back',
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 16,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'James',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                    ),
                    child: const Icon(Icons.notifications),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                        controller: _amountcontroller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter an amount";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelStyle: (const TextStyle(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                const BorderSide(width: 1, color: Colors.grey),
                          ),
                          hintStyle: const TextStyle(
                              fontSize: 16.0, color: Colors.grey),
                          prefix: const Text('NGN '),
                          hintText: '1000',
                          labelText: 'Amount',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: _emailcontroller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter an email";
                          }
                          return null;
                        },
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                        decoration: InputDecoration(
                          hintText: 'example@gmail.com',
                          labelStyle: (const TextStyle(color: Colors.grey)),
                          hintStyle: const TextStyle(
                              fontSize: 16.0, color: Colors.grey),
                          labelText: 'Email',
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                const BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            makePayment();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors
                                .blue[900], // Change the button color as needed
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  25), // Adjust the radius as needed
                            ),
                          ),
                          child: const Text(
                            'Make payment',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}

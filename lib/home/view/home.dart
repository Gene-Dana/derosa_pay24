import 'package:derosa_pay26/home/models/payment.dart';
import 'package:derosa_pay26/make_payment/view/make_payment.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Image? logo;

  @override
  void initState() {
    super.initState();

    logo = Image.asset('logo_light.png');
  }

  // Caching the image
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(logo!.image, context);
  }

  @override
  Widget build(BuildContext context) {
    const id = 'DeRosa';
    const title = 'Feb 15 - Feb 21';
    const price = '345';
    final timeStamp = DateTime.now().toString();

    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            // this is a comment
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                // ignore: sized_box_for_whitespace
                child:
                    Container(width: 200, child: Image.asset('logo_light.png')),
              )
            ],
            backgroundColor: Colors.white,
            title: const Text(
              'Invoice $title',
              style: TextStyle(
                color: Color(0xff2A3066),
              ),
            ),
          ),
          body: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MakePayment.route(
                          Payment(
                            id: id,
                            title: title,
                            price: price,
                            timeStamp: timeStamp,
                          ),
                        ),
                      );

                      if (!mounted) return;
                      Navigator.of(context).pop();

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text('Payment Complete!'),
                          ),
                        );
                    },
                    child: const Text('Make Payment of \$$price'),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

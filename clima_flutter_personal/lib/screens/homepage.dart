import 'dart:io';
import 'package:flutter/material.dart';

import 'loading_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool activeConnection = false;
  Future checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          activeConnection = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        activeConnection = false;
      });
    }
  }

  @override
  void initState() {
    checkUserConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Clima',
              style: TextStyle(
                fontSize: 50.0,
                fontFamily: 'Spartan MB',
                color: Colors.blue,
              ),
            ),
            const Icon(
              Icons.cloudy_snowing,
              size: 200.0,
              color: Colors.blue,
            ),
            OutlinedButton(
              onPressed: () {
                checkUserConnection();
                print(activeConnection);

                setState(() {
                  activeConnection == true
                      ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoadingScreen()))
                      : showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Center(
                              child: Text(
                                'App needs Internet Connection!',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            content: const Text(
                              'Please connect your device to the internet and try again',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w400),
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  // navigation after pressing yes
                                  setState(() {
                                    checkUserConnection();
                                    print(activeConnection);

                                    activeConnection == true
                                        ? Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoadingScreen()))
                                        : Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage()));
                                  });
                                },
                                child: const Text("I'm connected"),
                              ),
                            ],
                          ),
                        );
                });
              },
              child: const Text(
                'Proceed',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Spartan MB',
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

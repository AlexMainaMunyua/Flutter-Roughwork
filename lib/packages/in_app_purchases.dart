import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_pay/google_pay.dart';

class SubscribeToGroup extends StatefulWidget {
  const SubscribeToGroup({Key? key}) : super(key: key);

  @override
  _SubscribeToGroupState createState() => _SubscribeToGroupState();
}

class _SubscribeToGroupState extends State<SubscribeToGroup> {
  String _googlePayToken = 'Unknown';
  String _platformVersion = 'Unknown';

  // @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GooglePay.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';

    }

    await GooglePay.initializeGooglePay(
        "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");

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        title: Text(
          "Subscribe",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "You Are Subscribing To:",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Group Name",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 40,
              ),
              Text("Group info here. Blah Blah Blah",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
              SizedBox(
                height: 40,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "\$5.99",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: " per month",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400))
              ])),
              SizedBox(
                height: 40,
              ),
              Text("Total Member: 10,032",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: onButtonPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Subscribe now!",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onButtonPressed() async {
    setState(() {
      _googlePayToken = "Fetching";
    });
    try {
      await GooglePay.openGooglePaySetup(
          price: "5.0",
          onGooglePaySuccess: onSuccess,
          onGooglePayFailure: onFailure,
          onGooglePayCanceled: onCancelled);
      setState(() {
        _googlePayToken = "Done Fetching";
      });
    } on PlatformException catch (ex) {
      setState(() {
        _googlePayToken = "Failed Fetching";
      });
    }
  }

  void onSuccess(String token) {
    setState(() {
      _googlePayToken = token;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=> WelcomeToGroup()));
  }

  void onFailure() {
    setState(() {
      _googlePayToken = "Failure";
    });
  }

  void onCancelled() {
    setState(() {
      _googlePayToken = "Cancelled";
    });
  }
}

class WelcomeToGroup extends StatelessWidget {
  const WelcomeToGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Welcome to",
                      style: TextStyle(fontSize: 24),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Group Name!",
                        style: TextStyle(
                            fontSize: 48, fontWeight: FontWeight.bold))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Please wait while we route you back to the App.",
                        style: TextStyle(fontSize: 14))),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: Text("YOU ARE SUBSCRIBED!",
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w500))),
              SizedBox(
                height: 50,
              ),
              Center(
                  child: CircleAvatar(
                radius: 40,
                child: Icon(
                  Icons.check,
                  size: 40,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:intent_for_package/intent_for_package.dart';
import 'package:flutter/material.dart';
import 'package:platform/platform.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: new Builder(
        // Create an inner BuildContext so that the onPressed methods
        // can refer to the Scaffold with Scaffold.of().
        builder: (BuildContext context) {
          Widget body;
          if (const LocalPlatform().isAndroid) {
            body = Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: const Text(
                      'Check if Sky Map is installed',
                    ),
                    onPressed: () async {
                      bool canLaunch = await IntentForPackage(
                        package: 'com.google.android.stardroid',
                      ).canLaunch();
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text('Sky Map is ${canLaunch ? '' : 'not'} installed'),
                      ));
                    },
                  ),
                  RaisedButton(
                    child: const Text(
                      'Open SkyMap or Google Play if not installed',
                    ),
                    onPressed: () async => IntentForPackage(
                          package: 'com.google.android.stardroid',
                          storeUrl:
                              'https://play.google.com/store/apps/details?id=com.google.android.stardroid',
                        ).launch(),
                  ),
                ],
              ),
            );
          } else {
            body = const Text('This plugin only works with Android');
          }
          return Center(child: body);
        },
      ),
    );
  }
}

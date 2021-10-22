import 'package:flutter/material.dart';
import 'package:kraken/kraken.dart';
import 'package:kraken_devtools/kraken_devtools.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Kraken kraken = Kraken(
      bundleURL:
          'http://kraken.oss-cn-hangzhou.aliyuncs.com/demo/guide-styles.js',
      devToolsService: ChromeDevToolsService(),
    );

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: kraken);
  }
}

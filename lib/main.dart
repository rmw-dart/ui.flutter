import 'package:flutter/material.dart';
import 'package:kraken/kraken.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Kraken kraken = Kraken(
        bundleURL:
            'http://kraken.oss-cn-hangzhou.aliyuncs.com/demo/guide-styles.js');

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: kraken);
  }
}

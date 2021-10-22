import 'package:flutter/material.dart';
import 'package:kraken/kraken.dart';
import 'package:kraken_devtools/kraken_devtools.dart';
import 'const.dart';
import 'dart:ui' show window;

const COLOR_WHITE = Color(0xffffffff);

void main() {
  runApp(Init());
}

class Init extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQueryData.fromWindow(window);

    final kraken = Kraken(
      bundlePath: 'dist/main.js',
      devToolsService: isDev ? ChromeDevToolsService() : null,
      background: COLOR_WHITE,
      viewportHeight: window.physicalSize.height / window.devicePixelRatio,
    );

    return MaterialApp(
        title: 'rmw.link',
        theme: ThemeData(),
        home: Container(
            padding: EdgeInsets.only(top: screen.padding.top), child: kraken));
  }
}

import 'package:flutter/material.dart';
import 'package:kraken/kraken.dart';
import 'package:kraken_devtools/kraken_devtools.dart';
import 'const.dart';
import 'dart:ui' show window;
import 'package:flutter/services.dart';

void main() {
  runApp(Init());
}

class Init extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 设置顶部状态栏颜色
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0x00ffffff),
        statusBarIconBrightness: Brightness.dark));
    final screen = MediaQueryData.fromWindow(window);

    final kraken = Kraken(
      bundlePath: 'dist/main.js',
      devToolsService: isDev ? ChromeDevToolsService() : null,
      background: Colors.white,
    );

    return MaterialApp(
        title: 'rmw.link',
        theme: ThemeData(),
        home: Container(
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsets.only(top: screen.padding.top),
            child: kraken));
  }
}

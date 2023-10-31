import 'package:adv_flutter_4pm/provider/connectivity_provider.dart';
import 'package:adv_flutter_4pm/provider/web_provider.dart';
import 'package:adv_flutter_4pm/views/screens/homepage.dart';
import 'package:adv_flutter_4pm/views/screens/web_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WebProvider(),
        ),
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomePage(),
          'web': (context) => const WebView(),
        },
      ),
    ),
  );
}

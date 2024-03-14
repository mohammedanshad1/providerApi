import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_rest_api/providerApi/provider.dart';
import 'package:provider_rest_api/providerApi/uiscreen.dart';

void main() {
  runApp(DevicePreview(
      builder: (BuildContext context) => MaterialApp(
            home: const MyApp(),
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
          )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ModelsProvider(),
      child: MaterialApp(
        title: 'Provider API Call',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const UiPage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio_demo/player_sreen/player_screen.dart';
import 'package:provider/provider.dart';

import 'providers/player_provider.dart';

void main() {
  runApp(
    MultiProvider(
      child: const MyApp(),
      providers: [
        ChangeNotifierProvider(
          create: (_) => PlayerProvider(),
        ),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.red,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PlayerScreen(),
    );
  }
}

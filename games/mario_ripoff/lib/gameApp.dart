import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mario_ripoff/constans.dart';
import 'package:mario_ripoff/mainGame.dart';

class GameApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final MainGame game;

  void initState() {
    super.initState();
    game = MainGame();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.teal,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: FittedBox(
              child: SizedBox(
                width: gameWidth,
                height: gameHeight,
                child: GameWidget(game: game),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

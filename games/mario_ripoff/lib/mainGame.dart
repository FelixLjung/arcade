import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mario_ripoff/Player.dart';
import 'package:mario_ripoff/constans.dart';
import 'package:mario_ripoff/obsticle.dart';

class MainGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {
  MainGame({super.children})
    : super(
        world: GameWorld(),
        camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        ),
      );
}

class GameWorld extends World {
  @override
  Future<void> onLoad() async {
    add(Obsticle(0,0,250,30));
    add(Player());
  }
}

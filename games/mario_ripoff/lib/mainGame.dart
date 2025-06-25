import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' as flutter_material;
import 'package:flutter/services.dart';
import 'package:mario_ripoff/Player.dart';
import 'package:mario_ripoff/camera.dart';
import 'package:mario_ripoff/constans.dart';
import 'package:mario_ripoff/levels/editor.dart';
import 'package:mario_ripoff/levels/lvl1.dart';
import 'package:mario_ripoff/obsticle.dart';

class MainGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection, TapCallbacks, PointerMoveCallbacks, PanDetector, ScrollDetector {
    late Editor editor;

  MainGame({super.children})
    : super(
        world: World(),
        camera: CameraComponent.withFixedResolution(width: gameWidth, height: gameHeight))
       {
    Player player = new Player(Vector2(-250, 0));

    Camera dscamera = Camera(width: gameWidth, height: gameHeight, player: player);
    GameWorld world = GameWorld(player);
    this.camera = dscamera;
    this.world = world;
    editor = Editor(world);

  } 



    @override
  void onTapDown(TapDownEvent event) {
    print("Down");
    editor.press(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    print("up");
    editor.release();
  }


  // By default, Flame's gesture system may block pointer move events while a tap is held.
  // To work around this, you can use the raw pointer events from Flutter directly.
  // Add a RawKeyboardListener or a Listener widget in your Flutter widget tree,
  // or override the onPanUpdate method if you want continuous updates during a drag.

  @override
  void onPanUpdate(DragUpdateInfo info) {
    // This will be called continuously while dragging, even if a tap is held.
    print(info.eventPosition.global);
    editor.move(info.eventPosition.widget);
  }

  @override
  void onScroll(PointerScrollInfo info) {
    print(info.scrollDelta.global.y);
    double x = info.scrollDelta.global.y;
    camera.moveBy(Vector2(x,0));
  }
}


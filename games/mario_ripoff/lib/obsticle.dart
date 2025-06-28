import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:mario_ripoff/levels/editor.dart';

class Obsticle extends RectangleComponent with HoverCallbacks, TapCallbacks{
  late Editor editor;
  @override
  Obsticle(double posX, double posY, double width, double height, Editor editor) {
    this.position = Vector2(posX, posY);
    this.size = Vector2(width, height);
    this.setColor(Colors.deepOrange);
    this.anchor = Anchor.topLeft;
    this.editor = editor;
  }

  FutureOr<void> onLoad() {
    add(RectangleHitbox()..isSolid = true);
    return super.onLoad();
  }

@override
  void onHoverEnter() {
    this.setColor(Colors.blue);
  }

  @override
  void onHoverExit() {
    this.setColor(Colors.deepOrange);
  }

  @override
  void onTapDown(TapDownEvent event) {
    print("Pressed Component yeah");
    editor.setObsticle(this);

    // editor.currentObs = this;
    // editor.moving = true;
  }

    @override
  void onTapUp(TapUpEvent event) {
    print("Unpressed!");

    editor.currentObs = null;
    editor.moving = false;
  }





  
  
}

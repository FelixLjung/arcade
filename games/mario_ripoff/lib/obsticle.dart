import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Obsticle extends RectangleComponent with HoverCallbacks{
  @override
  Obsticle(double posX, double posY, double width, double height) {
    this.position = Vector2(posX, posY);
    this.size = Vector2(width, height);
    this.setColor(Colors.deepOrange);
    this.anchor = Anchor.topLeft;
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

  
}

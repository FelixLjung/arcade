import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Obsticle extends RectangleComponent {
  @override
  Obsticle(double posX, double posY, double width, double height) {
    this.position = Vector2(posX, posY);
    this.size = Vector2(width, height);
    this.setColor(Colors.deepOrange);
  }

  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }
}

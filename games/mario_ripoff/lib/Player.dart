import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Player extends RectangleComponent {
  Player() {
    this.size = Vector2(100, 100);
    this.setColor(Colors.green);
  }

  double direction = 0;
  double speed = 50;
  @override
  FutureOr<void> onLoad() {
    add(
      KeyboardListenerComponent(
        keyDown: {
          LogicalKeyboardKey.keyA: (keysPressed) {
            print("A");
            move(-1);
            return true;
          },
          LogicalKeyboardKey.keyD: (keysPressed) {
            move(1);
            return true;
          },
          LogicalKeyboardKey.space: (keysPressed) {
            jump();
            return true;
          },
        },
        keyUp: {
          LogicalKeyboardKey.keyA: (keysPressed) {
            resetMove();
            return true;
          },
          LogicalKeyboardKey.keyD: (keysPressed) {
            resetMove();
            return true;
          },
        },
      ),
    );

    return super.onLoad();
  }

  void move(double dir) {
    print("moving with " + dir.toString());
    // position.add(Vector2(dir * speed, 0));
    direction = dir;
  }

  void jump() {
    position.add(Vector2(0, -100));
  }

  void resetMove() {
    direction = 0;
  }

  @override
  void update(double dt) {
    if (position.y < 0) {
      position.y += 100 * dt;
    }

    if (direction != 0) {
      Vector2 movement = Vector2(direction * speed * dt, 0);
      position.add(movement);
    }
  }
}

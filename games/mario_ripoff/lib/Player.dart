import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mario_ripoff/obsticle.dart';

class Player extends RectangleComponent with CollisionCallbacks{
  Player() {
    this.position = Vector2(-250, 0);
    this.size = Vector2(100, 100);
    this.setColor(Colors.green);

  }

  

  double direction = 0;
  double speed = 100;
  double acc = 1;

  bool jumping = false;

  double maxAcc = 5;
  double runMaxAcc = 10;
  final double runningSpeed = 200;
  final double walkingSpeed = 100;
  final double maxJumpHeight = 250;

  double gravityConstant = 350;
  double gravityAcc = 1;

  double jumpSpeed = 900;

  double jumpHeight = 0;

  double jumpAcc = 1;
  
  bool collisionR = false;
  bool collisionL = false;

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
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
          LogicalKeyboardKey.space: (keysPressed) {
            // resetJump();
            return true;
          }
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
    // position.add(Vector2(0, -100));
    jumpHeight = position.y - maxJumpHeight;
    jumping = true;
  }

  void resetMove() {
    direction = 0;
    acc = 1;
  }

  @override
  void update(double dt) {
    Gravity(dt);

    
    applyMove(dt);
    ApplyJump(dt);
  }

  void ApplyJump(double dt) {
    if (jumping) {
      position.y -= jumpSpeed * dt * 1/jumpAcc;
      jumpAcc += dt*0.25;
      print("Jumping" + jumpAcc.toString());
      if (jumpAcc > 1.32)  {
        jumping = false;
        jumpAcc = 1;
      }
      // if (position.y < jumpHeight) {
      //   jumping = false;
      //   jumpAcc = 1;
      // }
    }
  }

  void Gravity(double dt) {
    if (position.y < 0) { // TODO: better ground detection
      position.y += gravityConstant * dt * gravityAcc;
      gravityAcc+=dt*2;
    } else {
      gravityAcc = 1;
    }

  }
  
  void resetJump() {
    jumping = false;
    jumpAcc = 1;
  }
  
  void applyMove(double dt) {

    if (direction != 0) {
      if (direction > 0 && collisionR) return;
      if (direction < 0 && collisionL) return;

      Vector2 movement = Vector2(direction * speed * dt * acc, 0);
      position.add(movement);
      if (acc < maxAcc) acc += dt * 4;
    }
  }


    @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      //...
    } else if (other is Obsticle) {
      if (other.position.x > this.position.x) {
        collisionR = true;

      } else {
        collisionL = true;
      }
      print("Player hit wall");
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Obsticle) {
      if (other.position.x > this.position.x) {
        collisionR = false;

      } else {
        collisionL = false;
      }
    }
  }

}



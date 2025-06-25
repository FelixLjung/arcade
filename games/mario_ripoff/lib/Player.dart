import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mario_ripoff/obsticle.dart';
import 'dart:math';


class Player extends RectangleComponent with CollisionCallbacks{
  Player(Vector2 spawnPosition) {
    this.position = spawnPosition;
    this.spawnPosition = spawnPosition;
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
  bool collisionT = false;
  bool collisionB = false;
  
  late Vector2 spawnPosition;

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    add(
      KeyboardListenerComponent(
        keyDown: {
          LogicalKeyboardKey.keyA: (keysPressed) {
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
            resetMove(-1);
            return true;
          },
          LogicalKeyboardKey.keyD: (keysPressed) {
            resetMove(1);
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
    if (direction == -dir) acc = 1;
    direction = dir;
  }

  void jump() {
   
    jumpHeight = position.y - maxJumpHeight;
    jumping = true;
  }

  void resetMove(int dir) {
    if (direction == dir) {
      acc = 1;
      direction = 0;

    }
  }

  @override
  void update(double dt) {
    Gravity(dt);
    
    applyMove(dt);
    ApplyJump(dt);
    super.update(dt);
  }

  void ApplyJump(double dt) {
    if (jumping) {
      
      position.y -= jumpSpeed * dt * 1/jumpAcc;
      jumpAcc += dt*0.25;

    } else {
      jumpAcc = 1;
    }
  }

  void Gravity(double dt) {
    if (collisionB == false) { // TODO: better ground detection
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
  
      respawn();
    } 
   
    if (other is Obsticle) {
      Vector2 p1 = intersectionPoints.elementAt(0);
      Vector2 p2 = intersectionPoints.elementAt(1);
      // print(intersectionPoints.length);
      if ((p1.y - p2.y).abs() < 2) { // almost same y-value, therefor standing on ground
        collisionB = true; 
        jumping = false;
  
      } 
      if ((p1.x - p2.x).abs() < 2) { // almost same x-value, hitting side
          if (this.position.x < p1.x) {
            collisionR = true;
          } else {
            collisionL = true;
          }
      }




  
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

      if (other.position.y < this.position.y) {
        collisionT = false;
      } else {
        collisionB = false;
        // print("No bottom");
      }
    }
  }
  
  void respawn() {
    acc = 1;
    jumpAcc = 1;
    direction = 0;
    gravityAcc = 1;
    position = spawnPosition;
    jumping = false;

  }
  


}



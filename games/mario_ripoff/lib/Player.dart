import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mario_ripoff/obsticle.dart';
import 'dart:math';


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
  bool collisionT = false;
  bool collisionB = false;

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
  }

  void ApplyJump(double dt) {
    if (jumping) {
      
      position.y -= jumpSpeed * dt * 1/jumpAcc;
      jumpAcc += dt*0.25;
      // if (jumpAcc > 1.32)  {
      //   jumping = false;
      //   jumpAcc = 1;
      // }
      // if (collisionB == true)  {
      //   print("aborting jump");
      //   jumping = false;}

      // if (position.y < jumpHeight) {
      //   jumping = false;
      //   jumpAcc = 1;
      // }
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
      print(movement.x);
      position.add(movement);
      if (acc < maxAcc) acc += dt * 4;
    }
  }


    @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    //print(intersectionPoints);
    if (other is Obsticle) {
      Vector2 p1 = intersectionPoints.elementAt(0);
      Vector2 p2 = intersectionPoints.elementAt(1);

      if ((p1.y - p2.y).abs() < 2) { // almost same y-value, therefor standing on ground
        collisionB = true; 
        jumping = false;
  
      } 

      // if (other.position.x > this.position.x) {
      //   collisionR = true;

      // }
      //  else {
      //   collisionL = true;
      // }

      // if (other.position.y < this.position.y) {
      //   collisionT = true;
      // } else {
      //   collisionB = true;
      // }


      // print("Player hit wall");
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
        print("No bottom");
      }
    }
  }

}



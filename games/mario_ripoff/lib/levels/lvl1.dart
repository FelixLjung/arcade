
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:mario_ripoff/Player.dart';
import 'package:mario_ripoff/levels/editor.dart';
import 'package:mario_ripoff/obsticle.dart';

class GameWorld extends World {
  late Player player;
  late Editor editor;
  GameWorld(Player player) {
    this.player = player;
    
  }


  // Obsticle ob1 = Obsticle(0, 0, width, height);
  @override
  Future<void> onLoad() async {
    // add(ScreenHitbox());
    
    add(editor); 
    add(Obsticle(-420, 100, 150, 30, editor));
    add(Obsticle(-250, 200, 450, 30,editor));
    add(Obsticle(0, 100, 250, 30,editor));
    add(Obsticle(350, 75, 400, 30,editor));
    // addToWorld(Obsticle(100, 100, 50, 50));

    add(player);
  }

  Future<void> addToWorld(Obsticle obsticle) async{
    print("adding");
    await add(obsticle);
  }
}
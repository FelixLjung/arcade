import 'package:flame/components.dart';
import 'package:mario_ripoff/Player.dart';
import 'package:mario_ripoff/constans.dart';

class Camera extends CameraComponent {
  Camera({width, height,required Player player} ) {
    this.player = player;
  }
  late Player player;
  @override
  void update(double dt) {

    if (player.position.x > 0 ) {
      viewport.position.x = -player.position.x;
    }

    super.update(dt);
  }
}
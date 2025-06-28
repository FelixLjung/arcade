import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/geometry.dart';
import 'package:mario_ripoff/constans.dart';
import 'package:mario_ripoff/levels/lvl1.dart';
import 'package:mario_ripoff/obsticle.dart';

class Editor extends RectangleComponent with PointerMoveCallbacks {
  late GameWorld world;

  Obsticle? currentObs = null;
  late bool moving = false;

  Editor(GameWorld world) {
    // this.size = Vector2(1000,1000);
    this.world = world;
  }

  Future<void> spawnObsticle(double x, double y) async {
    // await world.addToWorld(Obsticle(x, y, width, height));
    Obsticle(x, y, 250, 50, this).addToParent(world);
    print("adding obs to $x, $y");
  }

  @override
  void press(TapDownEvent event) {
    print(event.localPosition);
    Vector2 convertedCords = convertCoordinates(
      event.localPosition.x,
      event.localPosition.y,
    );
    Obsticle? obs = touchedObsticle(convertedCords);
    if (obs != null) {
      currentObs = obs;
      moving = true;
      print("Touching $obs");
    } else {
      spawnObsticle(convertedCords.x, convertedCords.y);
    }
  }

  void release() {
    moving = false;
  }

  Obsticle? touchedObsticle(Vector2 coords) {
    for (final child in world.children) {
      if (child is Obsticle) {
        if (child.toRect().contains(coords.toOffset())) {
          // You can perform additional logic here, e.g., select or highlight the obstacle
          return child;
        }
      }
    }

    return null;
  }

  Vector2 convertCoordinates(double x, double y) {
    return Vector2((x - gameWidth / 2), y - gameHeight / 2);
  }

  Vector2 convertCoordinatesV2(Vector2 coords) {
    return Vector2((coords.x - gameWidth / 2), coords.y - gameHeight / 2);
  }

  @override
  void update(double dt) {}

  void move(Vector2 localPosition) {
    print("${moving} and ${currentObs}");
    if (moving && currentObs != null) {
      // Vector2 pos = convertCoordinatesV2(localPosition);
      currentObs?.position+=localPosition;
      print("Moving object");
    }
  }

  void setObsticle(Obsticle obs) {
    currentObs = obs;
    moving = true;
    print("Setting obsticle");
  }
}

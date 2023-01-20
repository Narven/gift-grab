import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:gift_grab/constants/globals.dart';
import 'package:gift_grab/gift_grab_game.dart';

class IceCube extends SpriteComponent
    with HasGameRef<GiftGrabGame>, CollisionCallbacks {
  final double _spriteHeight = 100;
  final Vector2 startPosition;

  late Vector2 _velocity;
  double speed = 300;
  double degree = pi / 180;

  IceCube({required this.startPosition});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.iceCubeSprite);
    height = width = _spriteHeight;
    position = startPosition;
    anchor = Anchor.center;

    double spawnAngle = _getSpawnAngle();

    final double vx = cos(spawnAngle * degree) * speed;
    final double vy = sin(spawnAngle * degree) * speed;

    _velocity = Vector2(vx, vy);

    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is ScreenHitbox) {
      final Vector2 collision = intersectionPoints.first;
      if (collision.x == 0 || collision.x == gameRef.size.x) {
        _velocity.x = -_velocity.x;
        _velocity.y = _velocity.y;
      }

      if (collision.y == 0 || collision.y == gameRef.size.y) {
        _velocity.x = _velocity.x;
        _velocity.y = -_velocity.y;
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += _velocity * dt;
  }

  double _getSpawnAngle() {
    final random = Random().nextDouble();
    return lerpDouble(0, 360, random)!;
  }
}

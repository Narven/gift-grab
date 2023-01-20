import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:gift_grab/components/ice_cube.dart';
import 'package:gift_grab/constants/globals.dart';
import 'package:gift_grab/gift_grab_game.dart';

enum MovementState {
  idle,
  slideLeft,
  slideRight,
  frozen,
}

class Santa extends SpriteGroupComponent<MovementState>
    with HasGameRef<GiftGrabGame>, CollisionCallbacks {
  final double _spriteHeight = 100;
  final double _speed = 500;
  late double _rightBound;
  late double _leftBound;
  late double _upBound;
  late double _downBound;

  bool _isFrozen = false;
  final Timer _timer = Timer(3);

  JoystickComponent joystick;

  Santa({required this.joystick});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Sprite santaIdle = await gameRef.loadSprite(Globals.santaIdleSprite);
    Sprite santaLeftSlide =
        await gameRef.loadSprite(Globals.santaSlideLeftSprite);
    Sprite santaRightSlide =
        await gameRef.loadSprite(Globals.santaSlideRightSprite);
    Sprite santaFrozen = await gameRef.loadSprite(Globals.santaFreezeSprite);

    sprites = {
      MovementState.idle: santaIdle,
      MovementState.slideLeft: santaLeftSlide,
      MovementState.slideRight: santaRightSlide,
      MovementState.frozen: santaFrozen,
    };

    _rightBound = gameRef.size.x - 45;
    _leftBound = 45;
    _upBound = 55;
    _downBound = gameRef.size.y - 85;

    current = MovementState.idle;

    position = gameRef.size / 2;
    height = _spriteHeight;
    width = _spriteHeight * 1.42;
    anchor = Anchor.center;

    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (joystick.direction == JoystickDirection.idle) {
      current = MovementState.idle;
      return;
    }

    if (!_isFrozen) {
      if (x >= _rightBound) {
        x = _rightBound - 1;
      }

      if (x <= _leftBound) {
        x = _leftBound + 1;
      }

      if (y <= _upBound) {
        y = _upBound + 1;
      }

      if (y >= _downBound) {
        y = _downBound - 1;
      }

      bool movingLeft = joystick.relativeDelta[0] < 0;

      if (movingLeft) {
        current = MovementState.slideLeft;
      } else {
        current = MovementState.slideRight;
      }

      position.add(joystick.relativeDelta * _speed * dt);
    } else {
      _timer.update(dt);
      if (_timer.finished) {
        _unfreezeSanta();
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is IceCube) {
      _freezeSanta();
    }
  }

  void _unfreezeSanta() {
    _isFrozen = false;
    current = MovementState.idle;
  }

  void _freezeSanta() {
    if (_isFrozen) return;

    FlameAudio.play(Globals.freezeSound);
    _isFrozen = true;
    current = MovementState.frozen;
    _timer.start();
  }
}

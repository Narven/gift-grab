import 'package:flame/components.dart';
import 'package:gift_grab/constants/globals.dart';
import 'package:gift_grab/gift_grab_game.dart';

class Background extends SpriteComponent with HasGameRef<GiftGrabGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.backgroundSprite);
    size = gameRef.size;
  }
}

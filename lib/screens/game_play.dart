import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:gift_grab/gift_grab_game.dart';
import 'package:gift_grab/screens/game_over_menu.dart';

final GiftGrabGame _game = GiftGrabGame();

class GamePlay extends StatelessWidget {
  const GamePlay({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: _game,
      overlayBuilderMap: {
        GameOverMenu.ID: (BuildContext context, GiftGrabGame gameRef) =>
            GameOverMenu(gameRef: gameRef)
      },
    );
  }
}

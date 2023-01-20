import 'package:flutter/material.dart';
import 'package:gift_grab/constants/globals.dart';
import 'package:gift_grab/gift_grab_game.dart';

class GameOverMenu extends StatelessWidget {
  const GameOverMenu({
    super.key,
    required this.gameRef,
  });

  final GiftGrabGame gameRef;
  // ignore: constant_identifier_names
  static const String ID = 'GameOverMenu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/${Globals.backgroundSprite}',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Game Over',
                    style: TextStyle(fontSize: 100),
                  ),
                ),
                SizedBox(
                  width: 400,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(ID);
                      gameRef.reset();
                      gameRef.resumeEngine();
                    },
                    child: const Text(
                      'Play Again?',
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

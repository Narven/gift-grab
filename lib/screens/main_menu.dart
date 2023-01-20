import 'package:flutter/material.dart';
import 'package:gift_grab/constants/globals.dart';
import 'package:gift_grab/screens/game_play.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({
    super.key,
  });

  // ignore: constant_identifier_names
  static const String ID = 'MainMenu';

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
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const GamePlay()),
                    );
                  },
                  child: const Text(
                    'Play Again?',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

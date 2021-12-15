import 'package:flame_collision_detection/core_game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final game = CoreGame();

  runApp(GameWidget(
    game: game,
    // overlayBuilderMap: {
    //   'PauseMenu': (ctx, game) {
    //     return Text('A pause menu');
    //   },
    // },
  ));
}

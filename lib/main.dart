import 'dart:io';

import 'package:flame/game.dart';
import 'package:flame_collision_detection/core_game.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final game = CoreGame();

  runApp(
    GameWidget(
      game: game,
      overlayBuilderMap: {
        'Info': (ctx, game) {
          return Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            height: 150.0,
            child: Center(
              child: Text(
                _getInstructions(),
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      },
    ),
  );
}

String _getInstructions() {
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      return 'Tap on the screen to move the square.';
    } else {
      return 'Move the mouse to move the square';
    }
  } catch (_) {
    return 'Move the mouse to move the square';
  }
}

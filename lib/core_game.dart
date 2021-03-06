import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_collision_detection/obstacle.dart';
import 'package:flame_collision_detection/player.dart';

class CoreGame extends FlameGame
    with HasCollidables, MouseMovementDetector, TapDetector {
  // ********************************* VARS ******************************** //

  late final Player _player;

  Vector2 _target = Vector2.zero();

  //***************************** PUBLIC METHODS *************************** //

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    overlays.add('Info');

    final obstacle = Obstacle();
    await add(obstacle);
    obstacle.position = canvasSize / 2.0 - obstacle.size / 2.0;

    _player = Player(this);
    await add(_player);
  }

  @override
  void update(double delta) {
    super.update(delta);
    _player.moveTo(_target);
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    _target = info.eventPosition.game;
  }

  @override
  void onTapDown(TapDownInfo info) {
    _target = info.eventPosition.game;
  }
}

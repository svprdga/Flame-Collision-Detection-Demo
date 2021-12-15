import 'package:flame/game.dart';
import 'package:flame_collision_detection/player.dart';
import 'package:flame/input.dart';

class CoreGame extends FlameGame
    with HasCollidables, MouseMovementDetector, TapDetector {
  // ********************************* VARS ******************************** //

  late final Player _player;

  Vector2 _target = Vector2.zero();

  //***************************** PUBLIC METHODS *************************** //

  @override
  Future<void> onLoad() async {
    await super.onLoad();

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
}

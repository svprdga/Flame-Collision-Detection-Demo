import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_collision_detection/core_game.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with HasHitboxes, Collidable {
  // ****************************** CONSTANTS ****************************** //

  static const double _sizeSide = 64.0;
  static const double _acceleration = 5.0;

  // ***************************** INJECTED VARS *************************** //

  final CoreGame _game;

  // ********************************* VARS ******************************** //

  late final Rect _rect;
  late final Paint _paint;

  Vector2 _movementVector = Vector2.zero();

  // ***************************** CONSTRUCTORS **************************** //

  Player(this._game) {
    _rect = const Rect.fromLTWH(0.0, 0.0, _sizeSide, _sizeSide);
    _paint = Paint()..color = const Color(0xAA03A9F4);
  }

  //***************************** PUBLIC METHODS *************************** //

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = Vector2(_sizeSide, _sizeSide);
    addHitbox(HitboxRectangle());
  }

  @override
  void update(double delta) {
    super.update(delta);
    position += _movementVector * delta;

    // Never let the player go outside the screen
    if (position.x < 0.0) position.x = 0.0;
    if (_right() > _game.canvasSize.x) position.x = _game.canvasSize.x - size.x;
    if (position.y < 0.0) position.y = 0.0;
    if (_bot() > _game.canvasSize.y) position.y = _game.canvasSize.y - size.y;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(_rect, _paint);
  }

  void moveTo(Vector2 target) {
    _movementVector = (target -
            Vector2(position.x + size.x / 2.0, position.y + size.y / 2.0)) *
        _acceleration;
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is ScreenCollidable) {
      // debugPrint('Collision with the screen');
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    if (other is ScreenCollidable) {}
  }

  double _right() => position.x + size.x;

  double _bot() => position.y + size.y;
}

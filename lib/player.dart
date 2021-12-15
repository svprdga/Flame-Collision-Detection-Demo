import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with HasHitboxes, Collidable {
  // ****************************** CONSTANTS ****************************** //

  static const double _sizeSide = 128.0;
  static const double _acceleration = 5.0;

  // ********************************* VARS ******************************** //

  late final Rect _rect;
  late final Paint _paint;

  Vector2 _movementVector = Vector2.zero();

  // ***************************** CONSTRUCTORS **************************** //

  Player() {
    _rect = Rect.fromLTWH(0.0, 0.0, _sizeSide, _sizeSide);
    _paint = Paint()..color = Colors.lightBlue;
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
}

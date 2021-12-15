import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_collision_detection/player.dart';
import 'package:flutter/material.dart';

class Obstacle extends PositionComponent with HasHitboxes, Collidable {
  // ****************************** CONSTANTS ****************************** //

  static const double _sizeSide = 64.0;

  // ********************************* VARS ******************************** //

  late final Rect _rect;
  late final Paint _noCollisionPaint;
  late final Paint _collisionPaint;

  bool _isColliding = false;

  // ***************************** CONSTRUCTORS **************************** //

  Obstacle() {
    _rect = const Rect.fromLTWH(0.0, 0.0, _sizeSide, _sizeSide);
    _noCollisionPaint = Paint()..color = Colors.grey;
    _collisionPaint = Paint()..color = Colors.white;
  }

  //***************************** PUBLIC METHODS *************************** //

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = Vector2(_sizeSide, _sizeSide);
    addHitbox(HitboxRectangle());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(_rect, _isColliding ? _collisionPaint : _noCollisionPaint);
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is Player) {
      _isColliding = true;
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    if (other is Player) {
      _isColliding = false;
    }
  }
}

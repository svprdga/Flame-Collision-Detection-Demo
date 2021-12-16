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
  Vector2 _oldPosition = Vector2.zero();

  final List<Component> _collidingLeft = [];
  final List<Component> _collidingTop = [];
  final List<Component> _collidingRight = [];
  final List<Component> _collidingBot = [];

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
    _oldPosition = position.clone();
    super.update(delta);
    // position += _movementVector * delta;
    applyMovement(delta);

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

  void applyMovement(double delta) {
    double x = _movementVector.x;
    double y = _movementVector.y;

    if ((x < 0.0 && _collidingLeft.isNotEmpty) ||
        (x > 0.0 && _collidingRight.isNotEmpty)) {
      x = 0.0;
    }

    if ((y > 0.0 && _collidingBot.isNotEmpty) ||
        (y < 0.0 && _collidingTop.isNotEmpty)) {
      y = 0.0;
    }

    position += Vector2(x, y) * delta;
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    double? x;
    double? y;

    // Detect left collisions
    final otherRight = other.position.x + other.size.x;
    if (position.x <= otherRight && _oldPosition.x > otherRight) {
      x = otherRight;
      _collidingLeft.add(other);
    }

    // Detect top collisions
    final otherBot = other.position.y + other.size.y;
    if (position.y <= otherBot && _oldPosition.y > otherBot) {
      y = otherBot;
      _collidingTop.add(other);
    }

    // Detect right collisions
    if (_right() >= other.position.x && _oldRight() < other.position.x) {
      x = other.position.x - size.x;
      _collidingRight.add(other);
    }

    // Detect bottom collisions
    if (_bot() >= other.position.y && _oldBot() < other.position.y) {
      y = other.position.y - size.y;
      _collidingBot.add(other);
    }

    // Compensate position
    if (x != null) {
      position.x = x;
    }
    if (y != null) {
      position.y = y;
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    for (final list in [
      _collidingLeft,
      _collidingTop,
      _collidingRight,
      _collidingBot,
    ]) {
      if (list.contains(other)) {
        list.remove(other);
      }
    }
  }

  double _right() => position.x + size.x;

  double _oldRight() => _oldPosition.x + size.x;

  double _bot() => position.y + size.y;

  double _oldBot() => _oldPosition.y + size.y;
}

class SnaplistController {

  final int? initialPosition;

  PositionChanged? positionChanged;

  SnaplistController({
    this.initialPosition
  });

  setPosition(int position, {bool animate = false}) {
    if (positionChanged != null) {
      positionChanged!(position, animate);
    }
  }
}

typedef PositionChanged(int position, bool animate);

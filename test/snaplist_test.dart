import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:snaplist/snaplist_bloc.dart';
import 'package:snaplist/snaplist_events.dart';

import 'event_matchers.dart';

void main() {
  test("full scroll test", () {
    final bloc = SnapListBloc(
        itemsCount: 10,
        separatorProvider: (index, data) => Size(10.0, 10.0),
        sizeProvider: (index, data) => Size(50.0, 50.0),
        swipeVelocity: 0.0,
        centerOffset: 0.0,
        infiniteScroll: true);

    bloc.offsetStream.listen(expectAsync1(
        (event) => expect(event, OffsetMatcher(OffsetEvent(-10.0, 40.0, 0, 1))),
        count: 1));

    bloc.snipStartStream.listen(expectAsync1(
        (event) => expect(event, SnipStartMatcher(SnipStartEvent(-10.0, 60.0, 40.0))),
        count: 1));

    bloc.positionStream.listen(expectAsync1(
        (event) => expect(event, PositionChangeMatcher(PositionChangeEvent(1))),
        count: 1));

    bloc.swipeStartSink.add(StartEvent(0.0, 50.0));
    bloc.swipeUpdateSink.add(UpdateEvent(30.0, 10.0));
    bloc.swipeEndSink.add(EndEvent(Offset(1000.0, 1000.0)));

    bloc.snipFinishSink.add(SnipFinishEvent());
  });

  test("explicit item set test", () {
    final bloc = SnapListBloc(
        itemsCount: 10,
        separatorProvider: (index, data) => Size(10.0, 10.0),
        sizeProvider: (index, data) => Size(50.0, 50.0),
        swipeVelocity: 0.0,
        centerOffset: 0.0,
        infiniteScroll: false);

    bloc.explicitPositionChangeStream.listen(
        expectAsync1((event) => expect(event.newPosition, 180), count: 1));
    bloc.explicitPositionChangeSink.add(ExplicitPositionChangeEvent(3, false));
  });
}

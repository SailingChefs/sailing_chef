import 'package:flutter_test/flutter_test.dart';
import 'package:sailing_chefs/app/app.locator.dart';


void main() {
  group('VideoPlayerViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:sailing_chefs/app/app.locator.dart';

void main() {
  group('CullinaryschoolServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

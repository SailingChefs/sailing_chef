import 'package:flutter_test/flutter_test.dart';
import 'package:sailing_chefs/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('UserDetailsViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

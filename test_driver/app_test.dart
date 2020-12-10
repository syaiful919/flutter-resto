import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Testing App', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    test('Scroll to last restaurant', () async {
      // wait for fetch data from api
      await Future.delayed(Duration(seconds: 5));

      final listFinder = find.byValueKey('main-list');
      final lastItem = find.byValueKey("vfsqv0t48jkfw1e867");
      final lastItemName = 'Gigitan Makro';

      await driver.scrollUntilVisible(listFinder, lastItem);
      expect(await driver.getText(lastItem), lastItemName);
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart' as app;

void main() {
  for (final w in [320.0, 360.0, 390.0, 430.0, 500.0, 800.0, 1400.0]) {
    testWidgets('no overflow at $w px', (t) async {
      t.view.physicalSize = Size(w, 900);
      t.view.devicePixelRatio = 1;
      addTearDown(t.view.reset);
      app.main();
      await t.pump(const Duration(seconds: 2));

      expect(find.text('Contact'), findsWidgets);
    });
  }
}

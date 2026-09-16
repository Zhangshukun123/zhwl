import 'dart:io';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zhwlzlxt_project/Controller/ultrasonic_controller.dart';
import 'package:zhwlzlxt_project/page/shenJing_page.dart';
import 'package:zhwlzlxt_project/utils/event_bus.dart';
import 'package:zhwlzlxt_project/utils/language_value.dart';
import 'package:zhwlzlxt_project/widget/popup_menu_btn.dart';

void main() {
  final captureKey = GlobalKey();
  Finder menuItem(String label) => find.ancestor(
      of: find.text(label),
      matching: find.byWidgetPredicate((w) => w is PopupMenuItem));
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    // Match Android's real text metrics instead of the test-only Ahem font.
    final configFile = File('.dart_tool/package_config.json').absolute;
    final config = jsonDecode(await configFile.readAsString());
    final flutter = (config['packages'] as List)
        .firstWhere((package) => package['name'] == 'flutter');
    final sdk = Directory.fromUri(configFile.uri.resolve(flutter['rootUri']))
        .parent.parent;
    final bytes = await File(
      '${sdk.path}/bin/cache/artifacts/material_fonts/roboto-regular.ttf',
    ).readAsBytes();
    await (FontLoader('Roboto')..addFont(Future.value(ByteData.sublistView(bytes))))
        .load();
  });
  setUp(() {
    eventBus = EventBus();
    Get.put(UltrasonicController());
  });
  tearDown(() {
    eventBus.destroy();
    Get.reset();
  });

  Future<void> show(WidgetTester tester, Size size, Widget child,
      {Locale locale = const Locale('en', 'US'), double textScale = 1}) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(RepaintBoundary(key: captureKey, child: GetMaterialApp(
      translations: LanguageValue(),
      theme: ThemeData(fontFamily: 'Roboto'),
      locale: locale,
      home: Builder(builder: (context) {
        ScreenUtil.init(context, designSize: const Size(960, 600));
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(textScale),
          ),
          child: Scaffold(body: Center(child: child)),
        );
      }),
    )));
    await tester.pumpAndSettle();
  }

  for (final size in [
    const Size(800, 480),
    const Size(960, 600),
    const Size(1920, 1200),
  ]) {
    testWidgets('Original button geometry and single-line text at $size', (tester) async {
      String? selected;
      await show(tester, size, PopupMenuBtn(
        index: 5,
        patternStr: 'Complete Denervation',
        enabled: true,
        popupListener: (value) => selected = value,
      ));
      expect(find.text('Complete Denervation'), findsOneWidget);
      final labelWidget = tester.widget<Text>(find.text('Complete Denervation'));
      expect(labelWidget.maxLines, 1);
      expect(labelWidget.overflow, TextOverflow.ellipsis);
      expect(labelWidget.style!.fontSize, 14.sp);
      final popup = tester.widget<PopupMenuButton<String>>(
        find.byWidgetPredicate((w) => w is PopupMenuButton));
      expect(popup.constraints, isNull, reason: 'Keep the original menu width limit');
      final outer = find.ancestor(
          of: find.byWidgetPredicate((w) => w is PopupMenuButton),
          matching: find.byWidgetPredicate((w) => w is Container &&
              w.margin == const EdgeInsets.only(left: 30)));
      expect(outer, findsOneWidget);
      final container = tester.widget<Container>(outer);
      expect(container.constraints!.maxWidth, 200.w);
      expect(container.constraints!.maxHeight, 50.h);
      final buttonRect = tester.getRect(find.byWidgetPredicate((w) => w is PopupMenuButton));
      final labelRect = tester.getRect(find.text('Complete Denervation'));
      expect(buttonRect.inflate(0.1).contains(labelRect.topLeft), isTrue);
      expect(buttonRect.inflate(0.1).contains(labelRect.bottomRight), isTrue);
      expect(tester.takeException(), isNull);
      await tester.tap(find.byWidgetPredicate((w) => w is PopupMenuButton));
      await tester.pumpAndSettle();
      for (final label in ['Complete Denervation', 'Partial Denervation']) {
        final item = menuItem(label);
        expect(item, findsOneWidget);
        final text = find.descendant(of: item, matching: find.text(label));
        final paragraph = tester.renderObject<RenderParagraph>(text);
        expect(paragraph.maxLines, 1);
        expect(paragraph.overflow, TextOverflow.ellipsis);
        // Text stays on one line within the unchanged item, using ellipsis if needed.
        final rect = tester.getRect(text);
        final itemRect = tester.getRect(item);
        expect(itemRect.inflate(0.1).contains(rect.topLeft), isTrue);
        expect(itemRect.inflate(0.1).contains(rect.bottomRight), isTrue);
        expect(rect.left, greaterThanOrEqualTo(0));
        expect(rect.right, lessThanOrEqualTo(size.width));

      }
      expect(tester.takeException(), isNull);
      await tester.tap(find.descendant(of: menuItem('Partial Denervation'),
          matching: find.text('Partial Denervation')));
      await tester.pumpAndSettle();
      expect(selected, 'Partial Denervation');
      expect(find.text('Partial Denervation'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Actual two-channel mode row stays inside both cards', (tester) async {
    await show(tester, const Size(800, 480), const ShenJingPage());
    expect(tester.takeException(), isNull);
    final menus = find.byWidgetPredicate((w) => w is PopupMenuButton);
    expect(menus, findsNWidgets(2));
    for (var channel = 0; channel < 2; channel++) {
      await tester.tap(menus.at(channel));
      await tester.pumpAndSettle();
      if (channel == 0 && const bool.fromEnvironment('CAPTURE_MODE_LAYOUT')) {
        await tester.runAsync(() async {
          final boundary = captureKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
          final image = await boundary.toImage(pixelRatio: 2);
          final data = await image.toByteData(format: ui.ImageByteFormat.png);
          await File('.codex_changes/20260915_mode_text_only/MENU_PREVIEW.png')
              .writeAsBytes(data!.buffer.asUint8List());
          image.dispose();
        });
      }
      await tester.tap(find.descendant(of: menuItem('Partial Denervation'),
          matching: find.text('Partial Denervation')));
      await tester.pumpAndSettle();
      expect(find.text('Partial Denervation'), findsNWidgets(channel + 1));
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('Chinese mode and disabled state remain unchanged', (tester) async {
    await show(tester, const Size(960, 600), PopupMenuBtn(
      index: 5, patternStr: '完全失神经', enabled: false,
      popupListener: (_) => fail('Disabled mode must not change'),
    ), locale: const Locale('zh', 'CN'));
    expect(find.text('完全失神经'), findsOneWidget);
    await tester.tap(find.byWidgetPredicate((w) => w is PopupMenuButton));
    await tester.pumpAndSettle();
    expect(find.byWidgetPredicate((w) => w is PopupMenuItem), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Large text uses ellipsis without growing the menu', (tester) async {
    await show(tester, const Size(800, 480), Align(
      alignment: Alignment.topRight,
      child: PopupMenuBtn(index: 5, patternStr: 'Complete Denervation',
          enabled: true, popupListener: (_) {}),
    ), textScale: 2);
    await tester.tap(find.byWidgetPredicate((w) => w is PopupMenuButton));
    await tester.pumpAndSettle();
    final text = find.descendant(of: menuItem('Complete Denervation'),
        matching: find.text('Complete Denervation'));
    final paragraph = tester.renderObject<RenderParagraph>(text);
    final rect = tester.getRect(text);
    expect(rect.left, greaterThanOrEqualTo(0));
    expect(rect.right, lessThanOrEqualTo(800));
    expect(paragraph.maxLines, 1);
        expect(paragraph.overflow, TextOverflow.ellipsis);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Frequency menu keeps original numeric values and MHz unit', (tester) async {
    String? selected;
    await show(tester, const Size(960, 600), PopupMenuBtn(
      index: 1, patternStr: '1', enabled: true,
      popupListener: (value) => selected = value,
    ));
    expect(find.text('MHz'), findsOneWidget);
    await tester.tap(find.byWidgetPredicate((w) => w is PopupMenuButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('3'));
    await tester.pumpAndSettle();
    expect(selected, '3');
    expect(Get.find<UltrasonicController>().ultrasonic.frequency.value, 3);
    expect(find.text('MHz'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Resizing keeps the original menu width cap', (tester) async {
    await show(tester, const Size(960, 600), PopupMenuBtn(
      index: 5, patternStr: 'Complete Denervation',
      enabled: true, popupListener: (_) {},
    ));
    tester.view.physicalSize = const Size(1920, 1200);
    await tester.pumpAndSettle();
    await tester.tap(find.byWidgetPredicate((w) => w is PopupMenuButton));
    await tester.pumpAndSettle();
    final item = menuItem('Complete Denervation');
    expect(tester.getSize(item).width, lessThanOrEqualTo(280));
    expect(tester.takeException(), isNull);
  });
}

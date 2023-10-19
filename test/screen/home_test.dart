import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screen/home.dart';

// コンテントの作成
Widget createHomeScreen() => ChangeNotifierProvider<Favorites>(
  create: (context) => Favorites(),
  child: const MaterialApp(
    home: HomePage(),
  ),
);

void main() {
  group('ホームページウィジェットのテスト', () {
    testWidgets('ListView をフレームワークが検出できること',  (tester) async {
      await tester.pumpWidget(createHomeScreen());

      // 起動時にItem 0のテキストを持つウィジェットが１つ存在するかの確認
      expect(find.text('Item 0'), findsOneWidget);
      await tester.fling(
        find.byType(ListView), 
        const Offset(0, -200),
        3000
      );
      await tester.pumpAndSettle();
      expect(find.text('Item 0'), findsNothing);
    });

    testWidgets('アイコンボタンのテスト', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byIcon(Icons.favorite), findsNothing);
      await tester.tap(find.byIcon(Icons.favorite_border).first);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Added to favorites.'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsWidgets);
      await tester.tap(find.byIcon(Icons.favorite).first);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Removed from favorites.'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });
  });
}

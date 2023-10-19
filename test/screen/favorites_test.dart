
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/models/favorites.dart';
import 'package:testing_app/screen/favorites.dart';

late Favorites favoritesList;

Widget createFavoritesScreen() => ChangeNotifierProvider<Favorites>(
  create: (context) {
    favoritesList = Favorites();
    return favoritesList;
  },
  child: const MaterialApp(
    home: FavoritesPage(),
  ),
);

void addItems() {
  for (var i = 0; i < 10; i += 2) {
    favoritesList.add(i);
  }
}

void main() {
  group('FavoritesPageウィジェットのテスト', () {
      testWidgets('ListViewが現れるかのテスト', (tester) async {
        await tester.pumpWidget(createFavoritesScreen());
        addItems();
        await tester.pumpAndSettle();
        expect(find.byType(ListView), findsOneWidget);
      });

      testWidgets('削除ボタンのテスト', (tester) async {
        await tester.pumpWidget(createFavoritesScreen());
        addItems();
        await tester.pumpAndSettle();
        var totalItems = tester.widgetList(find.byIcon(Icons.close)).length;
        await tester.tap(find.byIcon(Icons.close).first);
        await tester.pumpAndSettle();
        expect(tester.widgetList(find.byIcon(Icons.close)).length,lessThan(totalItems));
        expect(find.text('お気に入りから削除されました'), findsOneWidget);
      });
  });
}

import 'package:test/test.dart';
import 'package:testing_app/models/favorites.dart';

void main() {
  group('Testing App Provider', () {
    var favorites = Favorites();

    test('35番のお気に入りを追加した際に、リストに追加されていること', () {
      var number = 35;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
    });

    test('45番のお気に入りを削除した際に、リストから45が取り除かれていること', () {
      var number = 45;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
      favorites.remove(number);
      expect(favorites.items.contains(number), false);
    });
  });
}

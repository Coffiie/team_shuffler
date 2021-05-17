import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:team_shuffler/add_player/add_player_viewmodel.dart';
import 'package:team_shuffler/global/enums/save_status.dart';
import 'package:team_shuffler/global/services/database_manager.dart';
import 'package:team_shuffler/global/models/player.dart';

class MockDatabaseManager extends Mock implements DatabaseManager {}

class MockPlayer extends Mock implements Player {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('AddPlayerViewModel', () {
    AddPlayerViewModel model;
    setUp(() {
      model = AddPlayerViewModel();
    });

    tearDown(() {
      model.dispose();
    });
    group('Upon Initialize', () {
      test('name controller should be empty', () {
        final String name = model.nameController.text;
        expect(name.isEmpty, true);
      });

      test('name error field should be null', () {
        final String nameError = model.errorText;
        expect(nameError == null, true);
      });

      test('player rating should be 0', () {
        final int rating = model.rating;
        expect(rating, 0);
      });

      test('player rating error text should be empty', () {
        final String ratingError = model.ratingErrorText;
        expect(ratingError.isEmpty, true);
      });
    });

    group('On save', () {
      MockDatabaseManager manager;
      setUp(() async {
        manager = MockDatabaseManager();
        await manager.openDb();
      });

      test('Should save valid name and rating to database', () async {
        String name = 'Rawaha';
        int rating = 2;
        when(manager.insertPlayer(Player(name: name, rating: rating)))
            .thenAnswer((realInvocation) => Future.value(1));
        final SaveStatus saved = await model.save(name, rating, manager);
        expect(saved, SaveStatus.success);
      });

      test('Should not save invalid name and rating to database', () async {
        String name;
        int rating;
        when(manager.insertPlayer(Player(name: name, rating: rating)))
            .thenAnswer((realInvocation) => Future.value(1));
        manager = null;
        final SaveStatus saved = await model.save(name, rating, manager);
        expect(saved, SaveStatus.invalidInput);
      });
    });
  });
}

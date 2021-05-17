import 'package:flutter_test/flutter_test.dart';
import 'package:team_shuffler/global/services/validator.dart';

void main() {
  group('Validator should', () {
    test('validate name', () {
      Validator validator = Validator();
      String name = 'Rawaha';
      expect(validator.validateName(name), true);
    });

    test('validate name', () {
      Validator validator = Validator();
      String name = '';
      expect(validator.validateName(name), false);
    });

    test('validate name2', () {
      Validator validator = Validator();
      String name;
      expect(validator.validateName(name), false);
    });

    test('invalidate rating', () {
      Validator validator = Validator();
      int rating;
      expect(validator.validateRating(rating), false);
    });

    test('invalidate rating2', () {
      Validator validator = Validator();
      int rating = -1;
      expect(validator.validateRating(rating), false);
    });

    test('validate rating', () {
      Validator validator = Validator();
      int rating = 3;
      expect(validator.validateRating(rating), true);
    });

    test('validate rating2', () {
      Validator validator = Validator();
      int rating = 1;
      expect(validator.validateRating(rating), true);
    });

    test('validate rating3', () {
      Validator validator = Validator();
      int rating = 2;
      expect(validator.validateRating(rating), true);
    });

    test('invalidate rating3', () {
      Validator validator = Validator();
      int rating = 0;
      expect(validator.validateRating(rating), false);
    });

    test('invalidate rating4', () {
      Validator validator = Validator();
      int rating = 5;
      expect(validator.validateRating(rating), false);
    });
  });
}

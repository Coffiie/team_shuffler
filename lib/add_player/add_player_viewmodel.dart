import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:team_shuffler/global/di/locator.dart';
import 'package:team_shuffler/global/enums/save_status.dart';
import 'package:team_shuffler/global/services/database_manager.dart';
import 'package:team_shuffler/global/services/validator.dart';
import 'package:team_shuffler/global/models/player.dart';
import 'package:team_shuffler/main.dart';

class AddPlayerViewModel extends BaseViewModel {
  //ui
  TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;
  set nameController(TextEditingController val) {
    _nameController = val;
    notifyListeners();
  }

  //logic

  String _errorText;
  String get errorText => _errorText;
  set errorText(String val) {
    _errorText = val;
    notifyListeners();
  }

  String _ratingErrorText = '';
  String get ratingErrorText => _ratingErrorText;
  set ratingErrorText(String val) {
    _ratingErrorText = val;
    notifyListeners();
  }

  int _rating = 0;
  int get rating => _rating;
  set rating(int val) {
    _rating = val;
    notifyListeners();
  }

  Future<SaveStatus> save(
      String name, int rating, DatabaseManager manager) async {
    if (name == null || rating == null || manager == null) {
      return SaveStatus.invalidInput;
    }
    final Player player = Player(name: name, rating: rating);
    final int insertedId = await manager.insertPlayer(player);
    if (insertedId != -1) {
      return SaveStatus.success;
    } else {
      return SaveStatus.error;
    }
  }

  Future<void> handleSave() async {
    errorText = null;
    final String name = nameController.text.trim();
    final int rating = this.rating;
    final Validator validator = Validator();
    if (validator.validateName(name)) {
      if (validator.validateRating(rating)) {
        final DatabaseManager databaseManager = locator<DatabaseManager>();
        final SaveStatus saveStatus = await save(name, rating, databaseManager);
        _displayRelevantDialogue(saveStatus);
        _goBack();
      } else {
        ratingErrorText = 'Please fill rating for this player';
      }
    } else {
      errorText = 'Please enter a valid name';
    }
  }

  void _displayRelevantDialogue(SaveStatus saveStatus) {
    _handleSnackbar();

    const SnackBar errorSnackbar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Oops! There was some error while saving!',
          style: TextStyle(color: Colors.white),
        ));

    const SnackBar successSnackbar = SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'Player has been saved!',
          style: TextStyle(color: Colors.white),
        ));

    if (saveStatus == SaveStatus.error) {
      rootScaffoldMessengerKey.currentState.showSnackBar(errorSnackbar);
    } else if (saveStatus == SaveStatus.success) {
      rootScaffoldMessengerKey.currentState.showSnackBar(successSnackbar);
    }
  }

  void _handleSnackbar() {
    rootScaffoldMessengerKey.currentState.hideCurrentSnackBar();
  }

  void _goBack() {
    NavigationService navigationService = locator<NavigationService>();
    navigationService.back();
  }
}

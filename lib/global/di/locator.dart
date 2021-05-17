import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:team_shuffler/global/services/database_manager.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<DialogService>(DialogService());
  locator.registerSingleton<SnackbarService>(SnackbarService());
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<DatabaseManager>(DatabaseManager());
}

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  service.registerSnackbarConfig(SnackbarConfig(
    backgroundColor: Colors.green,
    mainButtonTextColor: Colors.black,
  ));
}
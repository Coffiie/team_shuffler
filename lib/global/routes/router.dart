import 'package:flutter/material.dart';
import 'package:team_shuffler/add_player/add_player_view.dart';
import 'package:team_shuffler/global/routes/routes.dart';
import 'package:team_shuffler/shuffle/shuffle_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case addPlayerView:
      return MaterialPageRoute(builder: (context) => AddPlayerView());
    case shuffleView:
      return MaterialPageRoute(builder: (context) => ShuffleView());
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: SafeArea(
            child: Center(
              child: Text('No path for ${settings.name}'),
            ),
          ),
        ),
      );
  }
}

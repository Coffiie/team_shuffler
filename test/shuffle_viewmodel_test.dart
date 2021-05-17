import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:team_shuffler/global/models/team.dart';
import 'package:team_shuffler/shuffle/shuffle_viewmodel.dart';
import 'package:team_shuffler/global/models/player.dart';

import 'add_player_viewmodel_test.dart';

void main() {
  //feature: shuffle view model should get all list from db
  //shuffle view model should initialize the list as empty
  //feature: shuffle view model should shuffle teams (currently we will random with equal scores)
  //feature: shuffle view model should update individual players
  //feature: shuffle view model should delete individual players

  ShuffleViewModel model;
  List<Player> mockPlayerList;
  setUp(() {
    model = ShuffleViewModel();
    mockPlayerList = [
      Player(name: 'Rawaha', id: 1, rating: 3),
      Player(name: 'Sayed', id: 2, rating: 3),
      Player(name: 'Burhan', id: 3, rating: 1),
      Player(name: 'Faiq', id: 4, rating: 1),
      Player(name: 'Ahmed', id: 5, rating: 2),
      Player(name: 'Hassan', id: 6, rating: 2)
    ];
  });

  group('ShuffleViewModel should - ', () {
    group('initialize - ', () {
      test('player list as empty', () {
        final List<Player> playerList = model.playerList;
        expect(playerList.isEmpty, true);
      });
    });

    group('shuffle teams - ', () {
      test('only if players are even and non empty', () {
        final List<Player> evenTestList = [];
        final bool isEven = model.arePlayersEven(evenTestList);
        expect(isEven, false);
      });

      test(' Shuffle teams',(){
        final List<Player> evenTestList = mockPlayerList;
        final List<Team> teams = model.shufflePlayers(evenTestList);
        //teams score should be equal
        var teamAScore = 0;
        var teamBScore = 0;
        teams[0].players.forEach((element) {teamAScore+=element.rating; });
        teams[1].players.forEach((element) {teamBScore+=element.rating;});
        expect(teamAScore, teamBScore);
      });
    });
  });
}

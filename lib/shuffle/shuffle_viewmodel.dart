import 'package:stacked/stacked.dart';
import 'package:team_shuffler/global/di/locator.dart';
import 'package:team_shuffler/global/models/player.dart';
import 'package:team_shuffler/global/models/team.dart';
import 'package:team_shuffler/global/services/database_manager.dart';

class ShuffleViewModel extends BaseViewModel {
  //logic

  List<Player> _playerList = [];
  List<Player> get playerList => _playerList;
  set playerList(List<Player> val) {
    _playerList = val;
    notifyListeners();
  }

  bool _isGettingPlayerList = false;
  bool get isGettingPlayerList => _isGettingPlayerList;
  set isGettingPlayerList(bool val) {
    _isGettingPlayerList = val;
    notifyListeners();
  }

  Future<void> initShuffleView() async {
    final DatabaseManager manager = locator<DatabaseManager>();
    playerList = await getAllPlayers(manager);
  }

  Future<List<Player>> getAllPlayers(DatabaseManager manager) async {
    isGettingPlayerList = true;
    final List<Player> playerList = await manager.getAllPlayers();
    isGettingPlayerList = false;
    return playerList;
  }

  bool arePlayersEven(List<Player> playerList) {
    if (playerList == null || playerList.isEmpty) {
      return false;
    }
    if (playerList.length % 2 == 0) {
      return true;
    } else {
      return false;
    }
  }

  List<Team> shufflePlayers(List<Player> playerList) {
    final int teamDivider = playerList.length ~/ 2;
    bool hasEqualScore = false;
    Team teamA;
    Team teamB;
    int teamAScore;
    int teamBScore;
    int count = 0;
    while (!hasEqualScore) {
      playerList.shuffle();
      teamAScore = 0;
      teamBScore = 0;
      teamA = Team(players: playerList.getRange(0, teamDivider).toList());
      teamB = Team(
          players:
              playerList.getRange(teamDivider, playerList.length).toList());
      for (int i = 0; i < teamA.players.length; i++) {
        teamAScore = teamA.players[i].rating;
        teamBScore = teamB.players[i].rating;
      }
      if (count == 100) {
        //we can't find a solution mainly because rating is not ideal
        break;
      }
      if (teamAScore == teamBScore) {
        hasEqualScore = true;
      } else {
        count += 1;
      }
    }
    return [teamA, teamB];
  }
}

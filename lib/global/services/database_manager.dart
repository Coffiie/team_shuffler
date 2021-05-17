import 'package:sqflite/sqflite.dart';
import 'package:team_shuffler/global/models/player.dart';

class DatabaseManager {
  //profile data
  final String playerTableName = 'playerTable';
  final String playerName = 'name';
  final String playerRating = 'rating';
  final String playerId = 'id';

  Database _dbClient;

  Future<String> _getPath() async {
    final String databasesPath = await getDatabasesPath();
    final String path = '$databasesPath/demo.db';
    return path;
  }

  Future<void> openDb() async {
    final String path = await _getPath();
    _dbClient = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table

      final String CREATE_TABLE_QUERY =
          'CREATE TABLE $playerTableName ($playerId INTEGER PRIMARY KEY, $playerName TEXT, $playerRating INTEGER)';

      await db.execute(CREATE_TABLE_QUERY);
    });
  }

  Future<int> insertPlayer(Player player) async {
    final int result = await _dbClient.insert(playerTableName, player.toJson());
    return result;
  }

  Future<int> updatePlayer(Player player) async {
    final int result = await _dbClient.update(playerTableName, player.toJson(),
        where: '$playerId = ?', whereArgs: [player.id]);
    return result;
  }

  Future<List<Player>> getAllPlayers() async {
    final List<Map<String, Object>> result =
        await _dbClient.query(playerTableName, columns: [
      playerId,
      playerName,
      playerRating,
    ]);

    List<Player> list = [];
    for (final res in result) {
      list.add(Player(
          id: res['id'],
          name: res['name'],
          rating: res['rating']));
    }
    return list;
  }

  Future<int> deleteUser(int id) async {
    final int result = await _dbClient
        .delete(playerTableName, where: '$playerId = ?', whereArgs: [id]);
    return result;
  }
}

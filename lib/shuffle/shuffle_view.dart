import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:team_shuffler/add_player/add_player_view.dart';
import 'package:team_shuffler/global/routes/routes.dart';

class ShuffleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCupertinoModalBottomSheet(
            elevation: 10,
            context: context,
            builder: (context) => AddPlayerView(),
          );
        },
        tooltip: 'Add player',
        child: const Icon(Icons.add),
      ),
      body: Container(),
    );
  }
}

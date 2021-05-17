import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:team_shuffler/add_player/add_player_viewmodel.dart';
import 'package:team_shuffler/global/widgets/input_widget.dart';

class AddPlayerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPlayerViewModel>.reactive(
        builder: (context, model, _) => Scaffold(
              backgroundColor: Colors.black45,
              body: Column(
                children: [
                  AppBar(
                    leadingWidth: MediaQuery.of(context).size.width * 0.20,
                    leading: TextButton(
                        onPressed: () async {
                          await model.handleSave();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('Save',
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.green, fontSize: 25)),
                        )),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('Cancel',
                                style:
                                    GoogleFonts.sourceSansPro(fontSize: 25))),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 16),
                    child: Row(
                      children: [
                        Text('Enter player name',
                            style: Theme.of(context).textTheme.headline5),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, left: 16, right: 16, bottom: 16),
                    child: InputWidget(
                      labelText: 'Name',
                      keyboardType: TextInputType.name,
                      controller: model.nameController,
                      errorText: model.errorText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          'Rating',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 16),
                    child: Row(
                      children: [
                        RatingBar.builder(
                          minRating: 1,
                          itemCount: 3,
                          itemSize: 30,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            model.rating = rating.toInt();
                          },
                        ),
                      ],
                    ),
                  ),
                  if (model.ratingErrorText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16),
                      child: Row(
                        children: [
                          Text(
                            model.ratingErrorText,
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
        viewModelBuilder: () => AddPlayerViewModel());
  }
}

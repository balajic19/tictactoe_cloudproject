import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe_cloudproject/models/userscores.dart';
import 'package:tictactoe_cloudproject/screens/one_player_game_screen/bloc/one_player_bloc.dart';

import 'package:tictactoe_cloudproject/utils/db.dart' as score_database;

class GameCounter extends StatefulWidget {
  const GameCounter({Key? key}) : super(key: key);

  @override
  State<GameCounter> createState() => _GameCounterState();
}

class _GameCounterState extends State<GameCounter> {
  @override
  Widget build(BuildContext context) {
    String abbreviation = "";
    late User user;
    @override
    void initState() {
      user = FirebaseAuth.instance.currentUser!;
      super.initState();
    }

    return BlocBuilder<OnePlayerBloc, OnePlayerState>(
      //the win counter will only change when game is starting or game is over
      /// therefore only build this widget when state is [GameInitilize] or GameOver
      buildWhen: (previous, current) {
        return current is OnePlayerGameOver || current is OnePlayerInitialState;
      },
      builder: (context, state) {
        int xWins = 0;
        int oWins = 0;
        int draw = 0;
        // Create a CollectionReference called users that references the firestore collection
        CollectionReference scores =
            FirebaseFirestore.instance.collection('singlePlayer');
        var user = FirebaseAuth.instance.currentUser!;
        final database = score_database.openDB();
        if (state is OnePlayerInitialState) {
          xWins = state.xWin;
          oWins = state.oWin;
          draw = state.draw;
        } else if (state is OnePlayerGameOver) {
          xWins = state.xWins;
          oWins = state.oWins;
          draw = state.draws;
          if (state.winner == "x") {
            Score score = Score(
                id: 0,
                abbreviation: user.displayName ?? user.email ?? "NA",
                userScore: xWins);
            score_database.manipulateDatabase(score, database);

            // Call the user's CollectionReference to add a new user

            addScore() async {
              await scores
                  .doc("Xwins")
                  .set({
                    "id": "0",
                    "Name": "${user.email ?? user.displayName ?? "User X"}",
                    "abbreviation": user.email ?? user.displayName ?? "NA",
                    "userScore": "${xWins}" // 42
                  })
                  .then((value) => print("score Added"))
                  .catchError((error) => print("Failed to add score: $error"));
            }

            addScore();
            print("=========>DB saved");
          } else if (state.winner == "o") {
            Score score = Score(
                id: 1,
                abbreviation: user.email ?? user.displayName ?? "NA",
                userScore: oWins);
            score_database.manipulateDatabase(score, database);

            // Call the user's CollectionReference to add a new user
            addScore() async {
              await scores
                  .doc("Owins")
                  .set({
                    "id": "1",
                    "Name": "User O",
                    "abbreviation": user.email ?? user.displayName ?? "NA",
                    "userScore": "${oWins}", // 42/ 42
                  })
                  .then((value) => print("score Added"))
                  .catchError((error) => print("Failed to add score: $error"));
            }

            addScore();
            print("=========>DB saved");
          } else if (state.winner == "draw") {
            Score score = Score(
                id: 1,
                abbreviation: user.email ?? user.displayName ?? "NA",
                userScore: draw);

            score_database.manipulateDatabase(score, database);

            // Call the user's CollectionReference to add a new user
            addScore() async {
              await scores
                  .doc("draws")
                  .set({
                    "id": "1",
                    "Name": "Draw",
                    "abbreviation": user.email ?? user.displayName ?? "NA",
                    "userScore": "${draw}", // 42// 42
                  })
                  .then((value) => print("score Added"))
                  .catchError((error) => print("Failed to add score: $error"));
            }

            addScore();
            print("=========>DB saved");
          }
        }
        if (state is OnePlayerInitialState || state is OnePlayerGameOver) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/x.png",
                      width: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${xWins.toString()} Wins"),
                  ],
                ),
              )),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/o.png",
                      width: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${oWins.toString()} Wins"),
                  ],
                ),
              )),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/draw.png",
                      width: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${draw.toString()} Draw"),
                  ],
                ),
              ))
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}

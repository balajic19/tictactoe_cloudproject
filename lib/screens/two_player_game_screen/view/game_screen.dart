import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe_cloudproject/screens/two_player_game_screen/bloc/two_player_bloc.dart';

import 'current_turn.dart';
import 'game_board.dart';
import 'game_counter.dart';

/// Screen to play the game.
class TwoPlayerGameScreen extends StatelessWidget {
  const TwoPlayerGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TwoPlayerBloc(),
        child: BlocBuilder<TwoPlayerBloc, TwoPlayerState>(
          builder: (context, state) {
            // Listen to changes in state.
            return BlocListener<TwoPlayerBloc, TwoPlayerState>(
              listener: (context, state) {
                // if game is over then show dailog of winner or draw
                if (state is TwoPlayerGameOver) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (dailogContext) {
                        return AlertDialog(
                          title: const Text("Game Over"),
                          actions: [
                            TextButton.icon(
                              label: const Text("Replay"),
                              onPressed: () {
                                // on pressing replay add event of [GameInitilize] and pop the dailog.
                                BlocProvider.of<TwoPlayerBloc>(context)
                                    .add(TwoPlayerGameInitilize());
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.restart_alt),
                            ),
                            TextButton(
                              child: const Text("Home"),
                              onPressed: () {
                                // on pressing Home pop dailog and [TwoPlayer].
                                Navigator.pop(dailogContext);
                                Navigator.pop(context);
                              },
                            )
                          ],
                          content: state.winner != "draw"
                              // if game is not draw then show winner x or O
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    state.winner == "x"
                                        // if X is winner show X on dailog.
                                        ? Image.asset(
                                            "assets/images/x.png",
                                            width: 30,
                                          )
                                        // If O is winner show O on dailog.
                                        : Image.asset(
                                            "assets/images/o.png",
                                            width: 30,
                                          ),
                                    const Text(
                                      "Wins",
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                )
                              //if game is draw show draw.
                              : const Text("Draw"),
                        );
                      });
                }
              },
              child: SafeArea(
                child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      // This will show the number of times x and o wins and number of time they are draw
                      Expanded(flex: 1, child: GameCounter()),
                      // This is the 3x3 matrix of game
                      Expanded(flex: 3, child: GameBoard()),
                      // This will show whose player turn is it
                      Expanded(
                          flex: 1,
                          child: CurrentTurn(
                            isXTurn: true,
                          )),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }
}

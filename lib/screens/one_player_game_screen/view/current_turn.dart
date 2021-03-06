import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe_cloudproject/screens/one_player_game_screen/bloc/one_player_bloc.dart';

class CurrentTurn extends StatelessWidget {
  const CurrentTurn({required this.isXTurn, Key? key}) : super(key: key);

  // used to show image base on x or O turn
  final bool isXTurn;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      BlocBuilder<OnePlayerBloc, OnePlayerState>(builder: (context, state) {
        if (state.isXTurn) {
          return Image.asset(
            "assets/images/x.png",
            width: 30,
          );
        } else {
          return Image.asset(
            "assets/images/o.png",
            width: 30,
          );
        }
      }),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Turn", style: TextStyle(fontSize: 20)),
      )
    ]);
  }
}

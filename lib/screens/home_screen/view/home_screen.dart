import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tictactoe_cloudproject/constants/style.dart';
import 'package:tictactoe_cloudproject/extensions/extensions.dart';
import 'package:tictactoe_cloudproject/screens/home_screen/bloc/home_screen_bloc/homescreen_bloc.dart';
import 'package:tictactoe_cloudproject/screens/home_screen/bloc/theme_bloc/bloc/theme_bloc.dart';
import 'package:tictactoe_cloudproject/screens/home_screen/view/popupmenu.dart';

import 'creating_game_dailog.dart';
import 'join_game_dailog.dart';
import 'option_dailog.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            text: 'Tic',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ), // default text style
            children: <TextSpan>[
              TextSpan(
                text: ' Tac ',
                style: TextStyle(
                  fontSize: 40,

                  /// if we don't declare color explicitly,
                  /// it will take default color blue accent
                  color: Colors.blue,

                  /// if we use the same fontFamily, that will also
                  /// make it italic, bold and blue
                  //fontFamily: 'Allison',
                ),
              ),
              TextSpan(
                text: 'Toe ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    BlocProvider.of<ThemeBloc>(context)
                        .add(ThemeChanged(state is! DarkTheme));
                  },
                  icon: state is DarkTheme
                      ? const Icon(
                          Icons.light_mode,
                          color: Colors.orange,
                        )
                      : const Icon(
                          Icons.dark_mode,
                          color: Colors.black,
                        ));
            },
          ),
          BlocConsumer<ThemeBloc, ThemeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    showPopupMenu(context);
                  },
                  icon: state is DarkTheme
                      ? Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.more_vert,
                          color: Colors.black,
                        ));
            },
          )
        ],
      ),
      body: BlocProvider<HomeScreenBloc>(
        create: (context) {
          return HomeScreenBloc();
        },
        child: BlocListener<HomeScreenBloc, HomeScreenState>(
          listener: (context, state) {
            if (state is ShowOptionDailogState) {
              showDialog(
                  context: context,
                  builder: (dailogContext) {
                    return BlocProvider.value(
                      value: BlocProvider.of<HomeScreenBloc>(context),
                      child: const OptionDailog(),
                    );
                  });
            } else if (state is ShowJoinGameDailogState) {
              showDialog(
                  context: context,
                  builder: (dailogContext) {
                    return const JoinGameDailog();
                  });
            } else if (state is ShowCreatingGameDailogState) {
              showDialog(
                  context: context,
                  builder: (dailogContext) {
                    return const CreatingGameDailog();
                  });
            }
          },
          child: const HomeScreenView(),
        ),
      ),
    );
  }
}

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          style: textButtonStyle,
          onPressed: () {
            // Navigate to OnePlayerScreen
          },
          child: Text("One Player",
              style: Theme.of(context).textTheme.headline6?.boldText),
        ),
        ElevatedButton(
          style: textButtonStyle,
          onPressed: () {
            // Navigate to TwoPlayerGameScreen
          },
          child: Text("Two Player",
              style: Theme.of(context).textTheme.headline6?.boldText),
        ),

        ElevatedButton(
          style: textButtonStyle,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TeamStandings()));
          },
          child: Text("Tournaments",
              style: Theme.of(context).textTheme.headline6?.boldText),
        ),

        ElevatedButton(
          style: textButtonStyle,
          onPressed: () {
            // Navigate to LoadingScreen()
          },
          child: Text("High Scores",
              style: Theme.of(context).textTheme.headline6?.boldText),
        )
        //TODO : make game play online

        // ElevatedButton(
        //     onPressed: () {
        //       BlocProvider.of<HomeScreenBloc>(context)
        //           .add(ShowOptionDailogEvent());
        //     },
        //     child: const Text("Play in Room")),
      ],
    ));
  }
}

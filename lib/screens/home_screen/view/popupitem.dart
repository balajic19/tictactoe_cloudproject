import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe_cloudproject/screens/home_screen/bloc/theme_bloc/bloc/theme_bloc.dart';

class PopUpMenuTile extends StatelessWidget {
  const PopUpMenuTile({Key? key, required this.title, this.isActive = false})
      : super(key: key);
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          width: 8,
        ),
        BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
          return Text(
            title,
            style: state is LightTheme
                ? Theme.of(context).textTheme.headline6!.copyWith(
                    color: isActive ? Color(0xff000000) : Color(0xff000000))
                : Theme.of(context).textTheme.headline6!.copyWith(
                    color: isActive ? Color(0xffffffff) : Color(0xffffffff)),
          );
        }),
      ],
    );
  }
}

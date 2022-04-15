import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe_cloudproject/screens/Profile/view.dart';
import 'package:tictactoe_cloudproject/screens/home_screen/view/popupitem.dart';
import 'package:tictactoe_cloudproject/screens/login/login.dart';

final _auth = FirebaseAuth.instance;
showPopupMenu(BuildContext context) {
  showMenu<int>(
    context: context,
    position: RelativeRect.fromLTRB(25.0, 25.0, 0.0,
        0.0), //position where you want to show the menu on screen
    items: [
      PopupMenuItem<int>(
          value: 1,
          child: PopUpMenuTile(
            isActive: true,
            title: 'Profile',
          )),
      PopupMenuItem<int>(
          value: 2,
          child: PopUpMenuTile(
            isActive: true,
            title: 'Tournaments',
          )),
      PopupMenuItem<int>(
          value: 3,
          child: PopUpMenuTile(
            title: 'Logout',
          )),
    ],
    elevation: 8.0,
  ).then((itemSelected) async {
    if (itemSelected == 0) {
      // AutoRouter.of(context).push(ChatRoute(user: profile));
    } else if (itemSelected == 1) {
      //
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ProfilePage()));
    } else if (itemSelected == 2) {
      //
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => TeamStandings()));
    } else if (itemSelected == 3) {
      //
      _auth.signOut();
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Login()));
    }
  });
}

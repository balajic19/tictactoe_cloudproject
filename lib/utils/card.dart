import 'package:flutter/material.dart';
import 'package:tictactoe_cloudproject/models/team_model.dart';
import 'package:tictactoe_cloudproject/utils/const.dart';

class TeamStandingCard extends StatelessWidget {
  final Team team;
  const TeamStandingCard(this.team);

  @override
  Widget build(BuildContext context) {
    TextStyle standingTextStyle = TextStyle(
      fontSize: 22,
      color: CustomColors.firebaseGrey,
    );
    return InkWell(
      onTap: () {
        //  Navigator.of(context).pushNamed(TeamDetails.routeName, arguments: team);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Material(
          color: CustomColors.secondaryColor,
          borderRadius: BorderRadius.circular(20),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    team.abbreviation!,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: standingTextStyle,
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Container(),
                // ),
                Expanded(
                  flex: 1,
                  child: Text(
                    (team.matchesPlayed).toString(),
                    style: standingTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    team.matchesWon.toString(),
                    style: standingTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    team.matchesLost.toString(),
                    style: standingTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    team.points.toString(),
                    style: standingTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    team.points.toString(),
                    style: standingTextStyle,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

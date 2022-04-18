import 'package:flutter/material.dart';
import 'package:tictactoe_cloudproject/models/team_model.dart';
import 'package:tictactoe_cloudproject/screens/tournaments/provider.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_cloudproject/utils/card.dart';
import 'package:tictactoe_cloudproject/utils/const.dart';

class TeamStandings extends StatefulWidget {
  const TeamStandings({Key? key}) : super(key: key);

  @override
  _TeamStandingsState createState() => _TeamStandingsState();
}

class _TeamStandingsState extends State<TeamStandings> {
  List<Team> teams = [];
  bool _isInit = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<Teams>(
        context,
        listen: false,
      ).fetchAndSetTeams().then(
            (value) => setState(
              () => _isLoading = false,
            ),
          );
    }
    _isInit = false;
  }

  TextStyle standingTextStyle = TextStyle(
    fontSize: 18,
    color: CustomColors.firebaseGrey,
  );

  @override
  Widget build(BuildContext context) {
    teams = Provider.of<Teams>(
      context,
      listen: false,
    ).teams;
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Container(
        color: CustomColors.firebaseNavy.withOpacity(0.6),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                'Tournaments',
                style: TextStyle(
                  color: CustomColors.firebaseOrange,
                  fontSize: 22,
                ),
                textAlign: TextAlign.left,
              ),
              centerTitle: true,
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                // title: Text(
                //   'Standings',
                //   style: TextStyle(
                //     color: CustomColors.primaryColor,
                //     fontSize: 22,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                background: Container(
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
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
                            'Name',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: CustomColors.firebaseYellow,
                            ),
                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: Container(),
                        // ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'MP',
                            style: TextStyle(
                              fontSize: 20,
                              color: CustomColors.firebaseYellow,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'MW',
                            style: TextStyle(
                              fontSize: 20,
                              color: CustomColors.firebaseYellow,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'ML',
                            style: TextStyle(
                              fontSize: 20,
                              color: CustomColors.firebaseYellow,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'PT',
                            style: TextStyle(
                              fontSize: 20,
                              color: CustomColors.firebaseYellow,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  // if (index == 0) {
                  //   return
                  // } else {
                  return Container(
                    child: Material(
                        color: CustomColors.secondaryColor,
                        child: TeamStandingCard(teams[index])),
                  );
                  // }
                },
                childCount: teams.length,
              ),
            ),
          ],
        ),
      );
    }
  }
}

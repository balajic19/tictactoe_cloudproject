import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tictactoe_cloudproject/models/team_model.dart';

class Teams with ChangeNotifier {
  List<Team> teams = [];

  Team getTeam(String index) {
    return teams.firstWhere((e) => e.userUid == index);
  }

  Future<void> fetchAndSetTeams() async {
    //  final teamRef = FirebaseFirestore.instance.collection('Team').withConverter<Team>(
    //     fromFirestore: (snapshot, _) => Team.fromJson(snapshot.data()!),
    //     toFirestore: (team, _) => team.toJson(),
    //   );
    //         teams = await teamRef.doc("QAaXqU5zaKGlnEFQLIdS").get().then((snapshot) => snapshot.data()!);

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Team');

    QuerySnapshot allDataQuerySnapshot = await _collectionRef.get();

    teams = allDataQuerySnapshot.docs
        .map((doc) => doc.data())
        .toList()
        .map((e) => Team.fromMap(e as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  Future<void> updateTeam(Team t) async {
    CollectionReference teams = FirebaseFirestore.instance.collection('Team');
    await teams.doc(t.userUid).update(t.toMap()).then((_) {
      // print("Data Updated in firebase for team id - " + t.userUid);
    });
    await fetchAndSetTeams();
    notifyListeners();
  }

  Future<void> addTeam(Team t) async {
    CollectionReference teams = FirebaseFirestore.instance.collection('Team');
    String uid = t.userUid!;
    await teams.doc(uid).set(t.toMap());
    await fetchAndSetTeams();
    notifyListeners();
    return;
  }

  Future<String> getImageUrl(String id) async {
    String imageUrl = await firebase_storage.FirebaseStorage.instance
        .ref('TeamLogos/$id/image')
        .getDownloadURL();
    // print(imageUrl);
    return imageUrl;
    // Within your widgets:
    // Image.network(downloadURL);
  }
}

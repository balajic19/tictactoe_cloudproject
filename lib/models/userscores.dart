class Score {
  final int? id;
  final String? abbreviation;
  final int? userScore;

  Score({this.id, this.abbreviation, this.userScore});

  Map<String, dynamic> toMap() {
    return {
//      'id': id,
      'scoreDate': abbreviation,
      'userScore': userScore,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.

  @override
  String toString() {
    return '$userScore,$abbreviation,$id';
  }
}

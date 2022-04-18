class Team {
  final String? abbreviation;
  final String? matchesPlayed;
  final String? matchesWon;
  final String? matchesDrawn;
  final String? matchesLost;
  final String? points;
  final String? userUid;

  Team(
      {this.abbreviation,
      this.matchesPlayed,
      this.matchesWon,
      this.matchesDrawn,
      this.matchesLost,
      this.points,
      this.userUid});
  Team copyWith({
    String? abbreviation,
    String? matchesPlayed,
    String? matchesWon,
    String? matchesLost,
    String? matchesDrawn,
    String? points,
    String? userUid,
  }) {
    return Team(
      abbreviation: abbreviation ?? this.abbreviation,
      matchesPlayed: matchesPlayed ?? this.matchesPlayed,
      matchesWon: matchesWon ?? this.matchesWon,
      matchesLost: matchesLost ?? this.matchesLost,
      matchesDrawn: matchesDrawn ?? this.matchesDrawn,
      points: points ?? this.points,
      userUid: userUid ?? this.userUid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'abbreviation': abbreviation,
      'matchesPlayed': matchesPlayed,
      'matchesWon': matchesWon,
      'matchesLost': matchesLost,
      'matchesDrawn': matchesDrawn,
      'points': points,
      'userUid': userUid,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      abbreviation: map['abbreviation'],
      matchesPlayed: map['matchesPlayed'],
      matchesWon: map['matchesWon'] ?? 0,
      matchesLost: map['matchesLost'] ?? 0,
      matchesDrawn: map['matchesDrawn'] ?? 0,
      points: map['points'] ?? 0,
      userUid: map['userUid'] ?? 0,
    );
  }
  Team.fromJson(Map<String, Object?> json)
      : this(
          abbreviation: json['abbreviation']! as String,
          matchesPlayed: json['matchesPlayed']! as String,
          matchesWon: json['matchesWon']! as String,
          matchesLost: json['matchesLost']! as String,
          matchesDrawn: json['matchesDrawn']! as String,
          points: json['points']! as String,
          userUid: json['userUid']! as String,
        );
  Map<String, Object?> toJson() {
    return {
      'abbreviation': abbreviation,
      ' matchesPlayed': matchesPlayed,
      'matchesWon': matchesWon,
      'matchesLost': matchesLost,
      'matchesDrawn': matchesDrawn,
      'points': points,
      'userUid': userUid,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Team &&
        other.abbreviation == abbreviation &&
        other.matchesPlayed == matchesPlayed &&
        other.matchesWon == matchesWon &&
        other.matchesLost == matchesLost &&
        other.matchesDrawn == matchesDrawn &&
        other.points == points &&
        other.userUid == userUid;

  }

  @override
  int get hashCode {
    return abbreviation.hashCode ^
        matchesPlayed.hashCode ^
        matchesWon.hashCode ^
        matchesLost.hashCode ^
        matchesDrawn.hashCode ^
        points.hashCode^
        userUid.hashCode;
  }
}

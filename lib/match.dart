class Match {
  int matchId;
  String opponent1;
  String opponent2;
  String tournament;
  Map<String, dynamic> stream;
  DateTime date;

  Match.fromJson(Map<String, dynamic> json) {
    matchId = json['matchid'];
    opponent1 = json['opponent1'];
    opponent2 = json['opponent2'];
    tournament = json['tournament'];
    stream = json['stream'];

    var dateFromJson = json['date'] + 'z';
    date = DateTime.parse(dateFromJson).toLocal();
  }
}
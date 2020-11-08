class Match {
  int matchId;
  String opponent1;
  String opponent2;
  var date;
  String tournament;
  Map<String, dynamic> stream;

  Match.fromJson(Map<String, dynamic> json):
      matchId = json['matchid'],
      opponent1 = json['opponent1'],
      opponent2 = json['opponent2'],
      date = json['date'],
      tournament = json['tournament'],
      stream = json['stream'];
}
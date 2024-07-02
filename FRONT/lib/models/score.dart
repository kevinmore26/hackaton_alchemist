import 'dart:convert';

Score scoreFromJson(String str) => Score.fromJson(json.decode(str));

String scoreToJson(Score data) => json.encode(data.toJson());

class Score {
  int? body;
  String? date;
  String? dateTime;
  int? depression;
  int? feelings;
  int? idPersona;
  dynamic idUserDacadoo;
  int? indulgences;
  int? lifestyle;
  int? mindfulness;
  int? movement;
  int? nutrition;
  int? obesity;
  String? platform;
  int? score;
  int? sleep;
  int? smoking;
  int? stress;
  int? wellness;

  Score({
    this.body,
    this.date,
    this.dateTime,
    this.depression,
    this.feelings,
    this.idPersona,
    this.idUserDacadoo,
    this.indulgences,
    this.lifestyle,
    this.mindfulness,
    this.movement,
    this.nutrition,
    this.obesity,
    this.platform,
    this.score,
    this.sleep,
    this.smoking,
    this.stress,
    this.wellness,
  });

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        body: json["body"],
        date: json["date"],
        dateTime: json["dateTime"],
        depression: json["depression"],
        feelings: json["feelings"],
        idPersona: json["idPersona"],
        idUserDacadoo: json["idUserDacadoo"],
        indulgences: json["indulgences"],
        lifestyle: json["lifestyle"],
        mindfulness: json["mindfulness"],
        movement: json["movement"],
        nutrition: json["nutrition"],
        obesity: json["obesity"],
        platform: json["platform"],
        score: json["score"],
        sleep: json["sleep"],
        smoking: json["smoking"],
        stress: json["stress"],
        wellness: json["wellness"],
      );

  static List<Score> fromJsonList(List<dynamic> jsonList) {
    List<Score> toList = [];

    jsonList.forEach((item) {
      Score score = Score.fromJson(item);
      toList.add(score);
    });

    return toList;
  }

  Map<String, dynamic> toJson() => {
        "body": body,
        "date": date,
        "dateTime": dateTime,
        "depression": depression,
        "feelings": feelings,
        "idPersona": idPersona,
        "idUserDacadoo": idUserDacadoo,
        "indulgences": indulgences,
        "lifestyle": lifestyle,
        "mindfulness": mindfulness,
        "movement": movement,
        "nutrition": nutrition,
        "obesity": obesity,
        "platform": platform,
        "score": score,
        "sleep": sleep,
        "smoking": smoking,
        "stress": stress,
        "wellness": wellness,
      };
}

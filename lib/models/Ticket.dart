class Ticket {
  final int number;
  final String departure_time;
  final String date;
  final String flying_time;
  final Place from;
  final Place to;

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      number: json["number"],
      departure_time: json["departure_time"],
      date: json["date"],
      flying_time: json["flying_time"],
      from: Place.fromJson(json["from"]),
      to: Place.fromJson(json["to"]),
    );
  }

  Ticket(
      {required this.number,
      required this.departure_time,
      required this.date,
      required this.flying_time,
      required this.from,
      required this.to});
}

class Place {
  final String code;
  final String name;

  Place({required this.code, required this.name});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(code: json["code"], name: json["name"]);
  }
}

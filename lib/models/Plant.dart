class Plant {
  final String id;
  final String title;
  final String imageUrl;
  final String waterNeeds;
  final String location;
  final Set<String> frequency;
  final String time;
  DateTime? nextIrrigation;
  int? plantId;

  Plant({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.waterNeeds,
    required this.location,
    required this.frequency,
    required this.time,
    this.nextIrrigation,
    this.plantId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'waterNeeds': waterNeeds,
      'location': location,
      'frequency': frequency,
      'time': time,
    };
  }
}

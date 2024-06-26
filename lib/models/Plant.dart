class Plant {
  final String title;
  final String imageUrl;
  final int waterNeeds;
  final String location;
  final Set<String> frequency;
  final String time;

  Plant({
    required this.title,
    required this.imageUrl,
    required this.waterNeeds,
    required this.location,
    required this.frequency,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'waterNeeds': waterNeeds,
      'location': location,
      'frequency': frequency,
      'time': time,
    };
  }
}

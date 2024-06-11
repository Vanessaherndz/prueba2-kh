class Doctor {
  String id;
  String name;
  String specialty;
  String schedule;
  bool availability;
  String photoUrl;

  Doctor({required this.id, required this.name, required this.specialty, required this.schedule, required this.availability, required this.photoUrl});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'specialty': specialty,
      'schedule': schedule,
      'availability': availability,
      'photoUrl': photoUrl,
    };
  }

  static Doctor fromMap(Map<String, dynamic> map, String id) {
    return Doctor(
      id: id,
      name: map['name'],
      specialty: map['specialty'],
      schedule: map['schedule'],
      availability: map['availability'],
      photoUrl: map['photoUrl'],
    );
  }
}




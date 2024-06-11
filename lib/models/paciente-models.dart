class Paciente {
  String id;
  String name;
  int age;
  String gender;
  String address;
  String phoneNumber;

  Paciente({required this.id, required this.name, required this.age, required this.gender, required this.address, required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }

  static Paciente fromMap(Map<String, dynamic> map, String id) {
    return Paciente(
      id: id,
      name: map['name'],
      age: map['age'],
      gender: map['gender'],
      address: map['address'],
      phoneNumber: map['phoneNumber'],
    );
  }
}

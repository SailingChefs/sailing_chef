class Course {
  final String name;
  final String link;
  final String description;
  final String numOfDays;
  String? id;

  Course({
    required this.name,
    required this.link,
    required this.description,
    required this.numOfDays,
    this.id,
  });

  factory Course.fromMap(Map<String, dynamic> data) {
    return Course(
      name: data['name'],
      link: data['link'],
      description: data['description'],
      numOfDays: data['numOfDays'],
      id: data['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'link': link,
      'description': description,
      'numOfDays': numOfDays,
      'id': id,
    };
  }
}

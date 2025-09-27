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
      name: (data['name'] as String?) ?? '',
      link: (data['link'] as String?) ?? '',
      description: (data['description'] as String?) ?? '',
      numOfDays: (data['numOfDays'] as String?) ?? '',
      id: data['id'] as String?,
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

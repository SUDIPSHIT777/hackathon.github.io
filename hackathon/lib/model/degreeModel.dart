class DegreeModel {
  final String title;
  final String duration;
  final String salary;

  DegreeModel({
    required this.title,
    required this.duration,
    required this.salary,
  });

  factory DegreeModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DegreeModel(
      title: json['title'] ?? '',
      duration: json['duration'] ?? '',
      salary: json['salary'] ?? '',
    );
  }
}

class DegreeResponseModel {
  final List<DegreeModel> degrees;

  DegreeResponseModel({
    required this.degrees,
  });

  factory DegreeResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DegreeResponseModel(
      degrees: (json['degrees'] as List)
          .map(
            (e) => DegreeModel.fromJson(e),
          )
          .toList(),
    );
  }
}
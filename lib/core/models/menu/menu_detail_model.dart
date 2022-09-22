class MenuDetailModel {
  final String name;
  MenuDetailModel({
    required this.name,
  });
  
  factory MenuDetailModel.fromJson(Map<String, dynamic> json) {
    return MenuDetailModel(
      name: json['name'] ?? "",
    );
  }
}

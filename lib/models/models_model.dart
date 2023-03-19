class ModelsModel {
  final String id;
  final int created;
  final String root;

  ModelsModel({
    required this.created,
    required this.root,
    required this.id,
  });

  factory ModelsModel.fromJson(Map<String, dynamic> json) => ModelsModel(
        id: json["id"],
        root: json["root"],
        created: json["created"],
      );

  static List<ModelsModel> modelsFromSnapShot(List modelSnapshots) {
    return modelSnapshots.map((e) => ModelsModel.fromJson(e)).toList();
  }
}

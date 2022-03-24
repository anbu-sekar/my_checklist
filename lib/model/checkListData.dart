final String checkListDatabase = 'checkLists';

class CheckListCategoryData {
  static final List<String> values = [
    ///Add all fields
    id, category, time
  ];

  static const String id = '_id';
  static const String category = 'category';
  static const String time = 'time';
}

class CheckListCategory {
  final int? id;
  final String category;
  final DateTime createdTime;

  const CheckListCategory({
    this.id,
    required this.category,
    required this.createdTime,
  });

  CheckListCategory copy({
    int? id,
    String? category,
    DateTime? createdTime,
  }) =>
      CheckListCategory(
        id: id ?? this.id,
        category: category ?? this.category,
        createdTime: createdTime ?? this.createdTime,
      );

  static CheckListCategory fromJson(Map<String, Object?> json) => CheckListCategory (
    id: json[CheckListCategoryData.id] as int?,
    category: json[CheckListCategoryData.category] as String,
    createdTime: DateTime.parse(json[CheckListCategoryData.time] as String),
  );

  Map<String, Object?> toJson() => {
    CheckListCategoryData.id: id,
    CheckListCategoryData.category: category,
    CheckListCategoryData.time: createdTime.toIso8601String(),
  };
}
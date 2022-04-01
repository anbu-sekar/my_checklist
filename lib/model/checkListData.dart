///table names
final String checkListCategory = 'checkListCategory';
final String checkLists = 'checkLists';

///Category Data
class CheckListCategoryData {
  static final List<String> values = [id, category, time];

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

  static CheckListCategory fromJson(Map<String, Object?> json) =>
      CheckListCategory (
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

///Checklist Data
class CheckListsData {
  static final List<String> values = [id, categoryId, checkList, checkListStatus, time];

  static const String id = '_id';
  static const String categoryId = 'categoryId';
  static const String checkList = 'checkList';
  static const String checkListStatus = 'checkListStatus';
  static const String time = 'time';

}

class CheckLists {
  final int? id;
  final int categoryId;
  final String checkList;
  final bool checkListSatus;
  final DateTime createdTime;

  const CheckLists({
    this.id,
    required this.categoryId,
    required this.checkList,
    required this.checkListSatus,
    required this.createdTime,
  });

  CheckLists copy({
    int? id,
    int? categoryId,
    String? checkList,
    bool? checkListStatus,
    DateTime? createdTime,
  }) =>
      CheckLists(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        checkList: checkList ?? this.checkList,
        checkListSatus: checkListStatus ?? this.checkListSatus,
        createdTime: createdTime ?? this.createdTime,
      );

  static CheckLists fromJson(Map<String, Object?> json) => CheckLists (

        id: json[CheckListsData.id] as int?,
        categoryId: json[CheckListsData.categoryId] as int,
        checkList: json[CheckListsData.checkList] as String,
        checkListSatus: json[CheckListsData.checkListStatus] == 1,
        createdTime: DateTime.parse(json[CheckListCategoryData.time] as String),
      );

  Map<String, Object?> toJson() => {
    CheckListsData.id: id,
    CheckListsData.categoryId: categoryId,
    CheckListsData.checkList: checkList,
    CheckListsData.checkListStatus: checkListSatus ? 1 : 0,
    CheckListsData.time: createdTime.toIso8601String(),
  };

}

class ModalClass {
  int userId;
  int id;
  String title;
  bool completed;

  ModalClass({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory ModalClass.fromJson(Map<String, dynamic> json) => ModalClass(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}

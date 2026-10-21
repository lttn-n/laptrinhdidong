class Task {
 final int? id;
 final String title;
 final String description;
 final bool isCompleted;
 const Task({this.id, required this.title, required this.description,
  this.isCompleted = false});
 Map<String, Object?> toMap() => {
  if (id != null) 'id': id,
  'title': title, 'description': description,
  'isCompleted': isCompleted ? 1 : 0,
 };
 factory Task.fromMap(Map<String, Object?> map) => Task(
  id: map['id'] as int, title: map['title'] as String,
  description: map['description'] as String,
  isCompleted: map['isCompleted'] == 1,
 );
}

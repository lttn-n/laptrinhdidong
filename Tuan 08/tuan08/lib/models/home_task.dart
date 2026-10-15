class HomeTask {
  int id;
  String title;
  String content;
  DateTime? time;
  bool completed;
  HomeTask({required this.id,required this.title,required this.content,this.time,this.completed=false});
  Map<String,dynamic> toJson()=>{'id':id,'title':title,'content':content,'time':time?.toIso8601String(),'completed':completed};
  static HomeTask fromJson(Map<String,dynamic> json)=>HomeTask(id:json['id'],title:json['title'],content:json['content'],time:json['time']==null?null:DateTime.parse(json['time']),completed:json['completed']??false);
}

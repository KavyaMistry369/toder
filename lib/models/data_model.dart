class DataModel {
  String? title;
  String? description;
  String? time;
  String? date;
  String? id;

  DataModel.init();

  DataModel(
      this.title,
      this.description,
      this.date,
      this.time,
      this.id,
      );

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'title':title,
      'des':description,
      'date':date,
      'time':time,
    };
  }

}

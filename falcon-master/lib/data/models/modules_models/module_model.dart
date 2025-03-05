import 'package:falcon/core/core_exports.dart';

class ModuleModel extends ModuleEntity {
  ModuleModel({
    required super.id,
    required super.name,
    required super.image,
    required super.imageUrl,
    required super.price,
    required super.startDate,
    required super.endDate,
    required super.subjects,
    required super.description,

  });

  factory ModuleModel.fromJson(Map<String, dynamic> json ,{required bool isMyLearning}) => ModuleModel(
        id          : isMyLearning? json["module_id"]               :json["id"] ,
        name        : isMyLearning? json["module_name"]             :json["name"],
        image       : isMyLearning? (json["module_image"]??"")      :"" ,
        imageUrl    : isMyLearning? (json["module_image_url"]??"")  :json["image_url"]??"" ,
        startDate   : isMyLearning? json["module_startdate"]      :json["startdate"] ,
        endDate     : isMyLearning? json["module_enddate"]      :json["enddate"]  ,

        price       : isMyLearning? json["module_price"]   :json["price"] ,
       description  : isMyLearning? (json["module_description"]??"")      :( json["description"]??""),
      subjects    :  isMyLearning? List<SubjectModel>.from((json["subjects"]).map((e)=>SubjectModel.fromJson(e, isMyLearning: isMyLearning)))   :[],

  );
}

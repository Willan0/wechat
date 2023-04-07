import 'package:json_annotation/json_annotation.dart';
part 'chat_vo.g.dart';
@JsonSerializable()
class ChatVO{
  String? id;
  String? file;
  String? message;
  String? name;
  String? profile_pic;
  String? time_stamp;
  String? user_id;
  String? video_file;

  ChatVO(this.id, this.file, this.message, this.name, this.profile_pic,
      this.time_stamp, this.user_id, this.video_file);

  factory ChatVO.fromJson(Map<String,dynamic> json)=> _$ChatVOFromJson(json);

  Map<String,dynamic> toJson()=> _$ChatVOToJson(this);
}
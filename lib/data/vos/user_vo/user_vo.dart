
import 'package:json_annotation/json_annotation.dart';
part 'user_vo.g.dart';
@JsonSerializable()
class UserVO{

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'file')
  String? file;

  @JsonKey(name : 'user_name')
  String? userName;

  @JsonKey(name: 'region')
  String? region;

  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  @JsonKey(name: 'password')
  String? password;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'qr_code')
  String? qr_code;

  UserVO(this.id, this.file, this.userName, this.region, this.phoneNumber,
      this.password,this.email,this.qr_code);

  factory UserVO.fromJson(Map<String,dynamic> json)=> _$UserVOFromJson(json);

  Map<String,dynamic> toJson() => _$UserVOToJson(this);
}
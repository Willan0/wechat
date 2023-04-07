// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      json['id'] as String?,
      json['file'] as String?,
      json['user_name'] as String?,
      json['region'] as String?,
      json['phone_number'] as String?,
      json['password'] as String?,
      json['email'] as String?,
      json['qr_code'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'file': instance.file,
      'user_name': instance.userName,
      'region': instance.region,
      'phone_number': instance.phoneNumber,
      'password': instance.password,
      'email': instance.email,
      'qr_code': instance.qr_code,
    };

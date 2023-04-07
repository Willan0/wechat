// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatVO _$ChatVOFromJson(Map<String, dynamic> json) => ChatVO(
      json['id'] as String?,
      json['file'] as String?,
      json['message'] as String?,
      json['name'] as String?,
      json['profile_pic'] as String?,
      json['time_stamp'] as String?,
      json['user_id'] as String?,
      json['video_file'] as String?,
    );

Map<String, dynamic> _$ChatVOToJson(ChatVO instance) => <String, dynamic>{
      'id': instance.id,
      'file': instance.file,
      'message': instance.message,
      'name': instance.name,
      'profile_pic': instance.profile_pic,
      'time_stamp': instance.time_stamp,
      'user_id': instance.user_id,
      'video_file': instance.video_file,
    };

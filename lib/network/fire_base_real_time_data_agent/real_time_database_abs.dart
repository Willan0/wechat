import 'package:wechat/data/vos/chat_vo/chat_vo.dart';

abstract class RealTimeDataBaseAbs{

  Future<void> createChatting(String currentUserId,String chattingUserId,ChatVO chatVO);

  Stream<List<ChatVO>?> getChattingMessage(String currentUserId,String chattingUserId);

  Stream<List<String>> getChattingMessageContactId(String currentUserId);

  // Stream<ChatVO?> getLastMessage(String currentUserId, String contactUserId);
}
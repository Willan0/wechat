import 'package:firebase_database/firebase_database.dart';
import 'package:wechat/constant/string.dart';
import 'package:wechat/data/vos/chat_vo/chat_vo.dart';
import 'package:wechat/network/fire_base_real_time_data_agent/real_time_database_abs.dart';

class RealTimeDataBaseImpl extends RealTimeDataBaseAbs{

  RealTimeDataBaseImpl._();
  static final RealTimeDataBaseImpl _singleton = RealTimeDataBaseImpl._();
  factory RealTimeDataBaseImpl()=> _singleton;

  final  _realTimeDataBase = FirebaseDatabase.instance.ref();

  @override
  Future<void> createChatting(String currentUserId, String chattingUserId, ChatVO chatVO) {
   return _realTimeDataBase.child(kRootNodeForContactAndMessage)
       .child(currentUserId)
       .child(chattingUserId)
       .child(chatVO.id.toString())
       .set(chatVO.toJson());
  }

  @override
  Stream<List<ChatVO>?> getChattingMessage(String currentUserId,String chattingUserId) {
    return _realTimeDataBase.child(kRootNodeForContactAndMessage)
        .child(currentUserId)
        .child(chattingUserId)
        .onValue.map((event) {
          return event.snapshot.children.map((snapshot) {
            return ChatVO.fromJson(Map<String,dynamic>.from(snapshot.value as Map));
          }).toList();
    });
  }
}
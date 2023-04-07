import 'package:flutter/material.dart';
import 'package:wechat/constant/color.dart';
import 'package:wechat/constant/dimen.dart';
import 'package:wechat/data/data_apply/fire_base_abs.dart';
import 'package:wechat/data/data_apply/fire_base_impl.dart';
import 'package:wechat/data/vos/chat_vo/chat_vo.dart';
import 'package:wechat/data/vos/user_vo/user_vo.dart';
import 'package:wechat/utils/extension.dart';
import 'package:wechat/widgets/easy_icon.dart';
import 'package:wechat/widgets/easy_text.dart';
import 'package:wechat/widgets/easy_text_form_field.dart';

class ConservationPage extends StatefulWidget {
  const ConservationPage({Key? key, required this.contactUser})
      : super(key: key);
  final UserVO contactUser;

  @override
  State<ConservationPage> createState() => _ConservationPageState();
}

class _ConservationPageState extends State<ConservationPage> {
  final FireBaseApply _fireBaseApply = FireBaseApplyIMPL();
  UserVO? currentUser;
  TextEditingController _chatController = TextEditingController();
  bool _sendMessageCheck = false;
  List<ChatVO> chatMessages = [];
  String message = '';

  @override
  void initState() {
    UserVO? user = _fireBaseApply.getUserInfoFromAuth();
    _fireBaseApply
        .getUserVO(user.id ?? '')
        .then((value) => currentUser = value);


    _fireBaseApply
        .getChattingMessage(user.id ?? '', widget.contactUser.id ?? '')
        .listen((event) {

      setState(() {
        chatMessages = event ?? [];
      });
    });

    super.initState();
  }

  void sendMessage(String id) {
    var currentUserId = currentUser?.id ?? '';
    var contactUserId = widget.contactUser.id ?? '';
    if (id == contactUserId) {
      ChatVO chatVO = ChatVO(
          DateTime.now().microsecondsSinceEpoch.toString(),
          '',
          message,
          currentUser?.userName ?? '',
          currentUser?.file ?? '',
          DateTime.now().toString(),
          currentUserId,
          'video_file');
      _fireBaseApply.createChatting(
          currentUser?.id ?? '', widget.contactUser.id ?? '', chatVO);
      _fireBaseApply.createChatting(
          widget.contactUser.id ?? '', currentUser?.id ?? '', chatVO);
    }
    _chatController.clear();
    _sendMessageCheck = false;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chatController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryBlackColor,
        title: EasyText(
          text: widget.contactUser.userName ?? '',
          fontSize: kFi17x,
        ),
        centerTitle: false,
        leading: EasyIcon(
          icon: Icons.arrow_back,
          onPressed: () {
            context.previousScreen(context);
          },
          iconSize: kFi25x,
        ),
        actions: [
          EasyIcon(
            icon: Icons.phone,
            onPressed: () {},
            color: kPrimaryColor,
            iconSize: kFi25x,
          ),
          EasyIcon(
            icon: Icons.video_call,
            onPressed: () {},
            color: kPrimaryColor,
            iconSize: kFi25x,
          ),
          const SizedBox(
            width: kMp10x,
          )
        ],
      ),
      body: SizedBox(
        width: getWidth(context),
        height: getHeight(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Expanded(child: ListView(
            //   children: [
            //     chatMessages.isEmpty?
            //     const Center(
            //               child: EasyText(
            //                 text: 'Send Hi your friend',
            //                 color: kPrimaryBlackColor,
            //               ),)
            //         :Column(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //     children: chatMessages.map((e) =>
            //     (e.user_id!= widget.contactUser.id)
            //                         ?
            //                     EasyText(text: e.message ?? '',color: kPrimaryBlackColor,textAlign: TextAlign.right,)
            //                         :
            //                     EasyText(text: e.message ?? '',color: kPrimaryBlackColor,)
            //     ).toList(),
            //   ),
            //   ]
            // )),
            SizedBox(),
            Expanded(
              child: chatMessages.isNotEmpty
                  ? ChatListView(chatMessages: chatMessages.reversed.toList(), widget: widget)
                  : const Center(
                      child: EasyText(
                        text: 'Send Hi your friend',
                        color: kPrimaryBlackColor,
                      ),
                    ),
            ),


            // send message View
            Padding(
              padding: EdgeInsets.only(left: _sendMessageCheck ? kMp10x : 0),
              child: Row(
                children: [
                  _sendMessageCheck
                      ? SizedBox(
                          width: 0,
                        )
                      : EasyIcon(
                          iconSize: kFi30x,
                          icon: Icons.camera_alt,
                          onPressed: () {},
                          color: kSecondaryBlackColor,
                        ),
                  _sendMessageCheck
                      ? SizedBox(
                          width: 0,
                        )
                      : EasyIcon(
                          iconSize: kFi30x,
                          icon: Icons.image,
                          onPressed: () {},
                          color: kSecondaryBlackColor,
                        ),
                  _sendMessageCheck
                      ? SizedBox(
                          width: 0,
                        )
                      : EasyIcon(
                          iconSize: kFi30x,
                          icon: Icons.keyboard_voice,
                          onPressed: () {},
                          color: kSecondaryBlackColor,
                        ),
                  Expanded(
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      height: kWh40x,
                      decoration: const BoxDecoration(
                        color: kSecondaryBlackColor,
                        borderRadius: BorderRadius.all(Radius.circular(kRi20x)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: _sendMessageCheck ? 0 : kMp20x,
                            right: kMp10x),
                        child: Row(
                          children: [
                            Expanded(
                                child: EasyTextFormField(
                                    validate: (value) => null,
                                    controller: _chatController,
                                    hintText: 'Message',
                                    onTap: () {},
                                    focusedInputBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(kRi20x)),
                                        borderSide: BorderSide(
                                            width: 0,
                                            color: Colors.transparent)),
                                    onChanged: (text) {
                                      if (text.isNotEmpty) {
                                        _sendMessageCheck = true;
                                      } else {
                                        _sendMessageCheck = false;
                                      }
                                      setState(() {});
                                      setState(() {
                                        message = text;
                                      });
                                    })),
                            SizedBox(
                                width: kMp20x,
                                child: EasyIcon(
                                  icon: Icons.emoji_emotions,
                                  onPressed: () {},
                                  iconSize: kFi17x,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  EasyIcon(
                      icon: _sendMessageCheck
                          ? Icons.send
                          : Icons.waving_hand_sharp,
                      onPressed: () => sendMessage(widget.contactUser.id ?? ''),
                      color: kSecondaryBlackColor,
                      iconSize: kFi30x)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatListView extends StatelessWidget {
  const ChatListView({
    Key? key,
    required this.chatMessages,
    required this.widget,
  }) : super(key: key);

  final List<ChatVO> chatMessages;
  final ConservationPage widget;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
                reverse: true,
        itemBuilder: (context, index) =>
        (chatMessages[index].user_id!= widget.contactUser.id)
                ?
            EasyText(text: chatMessages[index].message ?? '',color: kPrimaryBlackColor,textAlign: TextAlign.right,)
                :
            EasyText(text: chatMessages[index].message ?? '',color: kPrimaryBlackColor,),
        separatorBuilder: (context, index) => const SizedBox(
              height: kMp5x,
            ),
        itemCount: chatMessages.length);
  }
}

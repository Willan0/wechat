import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat/constant/color.dart';
import 'package:wechat/constant/dimen.dart';
import 'package:wechat/data/vos/chat_vo/chat_vo.dart';
import 'package:wechat/data/vos/user_vo/user_vo.dart';
import 'package:wechat/utils/extension.dart';
import 'package:wechat/widgets/easy_icon.dart';
import 'package:wechat/widgets/easy_image.dart';
import 'package:wechat/widgets/easy_text.dart';
import 'package:wechat/widgets/easy_text_form_field.dart';

import '../bloc/conservation_bloc.dart';

class ConservationPage extends StatelessWidget {
  const ConservationPage({Key? key, required this.contactUser})
      : super(key: key);
  final UserVO contactUser;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConservationPageBloc>(
      create: (context) => ConservationPageBloc(contactUser.id),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kSecondaryBlackColor,
            title: Row(
              children: [
                CircleAvatar(
                  radius: kRi20x,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(kRi20x)),
                        child: EasyImage(image: contactUser.file ?? ''))),
                SizedBox(width: kMp5x,),
                EasyText(
                  text: contactUser.userName ?? '',
                  fontSize: kFi17x,
                ),
              ],
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
            child: Padding(
              padding: const EdgeInsets.only(bottom: kMp5x),
              child: Consumer<ConservationPageBloc>(
                builder: (context, value, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /// show message view

                    Expanded(
                        child: Selector<ConservationPageBloc, List<ChatVO>>(
                          selector: (context, selector) => selector.chatMessages,
                          builder: (context, chatMessages, child) =>
                          chatMessages.isNotEmpty
                              ? ChatListView(
                              chatMessages: chatMessages.reversed.toList(),
                              contactUserId: contactUser.id ?? '',)
                              : const Center(
                                child: EasyText(text: 'Send Hi to your friend'),
                          ),
                        )),

                    // send message View
                    SendMessageView(
                        chatController:
                        context.getConservationBlocInstance().chatController,),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}


class SendMessageView extends StatelessWidget {
  const SendMessageView({
    Key? key,
    required TextEditingController chatController,
  })  : _chatController = chatController,
        super(key: key);

  final TextEditingController _chatController;


  @override
  Widget build(BuildContext context) {
    return Selector<ConservationPageBloc, bool>(
      selector: (_, selector) => selector.sendMessageCheck,
      builder: (context, sendMessageCheck, child) => Padding(
        padding: EdgeInsets.only(left: sendMessageCheck ? kMp10x : 0),
        child: Row(
          children: [
            sendMessageCheck
                ? SizedBox(
                    width: 0,
                  )
                : EasyIcon(
                    iconSize: kFi30x,
                    icon: Icons.camera_alt,
                    onPressed: () {},
                    color: kSecondaryBlackColor,
                  ),
            sendMessageCheck
                ? SizedBox(
                    width: 0,
                  )
                : EasyIcon(
                    iconSize: kFi30x,
                    icon: Icons.image,
                    onPressed: () {},
                    color: kSecondaryBlackColor,
                  ),
            sendMessageCheck
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
                      left: sendMessageCheck ? 0 : kMp20x, right: kMp10x),
                  child: Row(
                    children: [
                      Expanded(
                          child: EasyTextFormField(
                              validate: (value) => null,
                              controller: _chatController,
                              hintText: 'Message',
                              onTap: () {},
                              focusedInputBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(kRi20x)),
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.transparent)),
                              onChanged: (text) => context
                                  .getConservationBlocInstance()
                                  .checkMessage(text))),
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
                icon: sendMessageCheck ? Icons.send : Icons.waving_hand_sharp,
                onPressed: () =>
                    context.getConservationBlocInstance().sendMessage(),
                color: kSecondaryBlackColor,
                iconSize: kFi30x)
          ],
        ),
      ),
    );
  }
}

class ChatListView extends StatelessWidget {
  const ChatListView({
    Key? key,
    required this.chatMessages, required this.contactUserId,

  }) : super(key: key);

  final List<ChatVO> chatMessages;
final String contactUserId ;

  @override
  Widget build(BuildContext context) {
    return chatMessages.length<1
        ?
    const Center(
      child: CircularProgressIndicator(),
    )
        :
      ListView.separated(
        reverse: true,
        itemBuilder: (context, index) =>
            (chatMessages[index].user_id != contactUserId)
                ?

                ///current user
                 LayoutBuilder(
                   builder: (context,boxConstraint) {
                     return Container(
                         width: boxConstraint.maxWidth < MediaQuery.of(context).size.width * 0.8 ? null : MediaQuery.of(context).size.width * 0.8,
                         margin: EdgeInsets.only(right: kMp5x),
                         padding: const EdgeInsets.all(kMp13x),
                         decoration: BoxDecoration(
                             color: kSecondaryBlackColor,
                             borderRadius: BorderRadius.only(
                                 topLeft: Radius.circular(kRi20x),
                                 topRight: Radius.circular(kRi10x),
                                 bottomLeft: Radius.circular(kRi10x))),
                         // constraints: BoxConstraints(maxWidth: maxWidth),
                         child: Row(
                           children: [
                             Flexible(
                               child: Center(
                                 child: EasyText(
                                   text: chatMessages[index].message ?? '',
                                   color: kPrimaryColor,
                                 ),
                               ),
                             ),
                           ],
                         ));
                   })

                :

                /// contact user
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: kMp5x),
                          padding: const EdgeInsets.all(kMp13x),
                          decoration: BoxDecoration(
                              color: kSecondaryBlackColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(kRi10x),
                                  topRight: Radius.circular(kRi20x),
                                  bottomRight: Radius.circular(kRi10x))),
                          child: Center(
                            child: EasyText(
                              text: chatMessages[index].message ?? '',
                              color: kPrimaryColor,
                            ),
                          )),
                    ],
                  ),

        separatorBuilder: (context, index) => const SizedBox(
              height: kMp5x,
            ),
        itemCount: chatMessages.length);
  }
}

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:uni_project/Controller/ConversationController.dart';
import 'package:uni_project/Services/api_service.dart';
import '../../Model/Chat_Model.dart';

class ConversationScreen extends StatelessWidget {
  ConversationScreen({super.key});

  ConversationController controller = Get.find();

  Color accent = Color.fromARGB(255, 151, 85, 222);
  LinearGradient gradient = Get.isDarkMode
      ? LinearGradient(
          colors: [
            Color(0xff7f3aa1).withOpacity(0.5),
            Color(0xff5516b5).withOpacity(0.5),
            Color(0xff150b56).withOpacity(0.5),
            Color(0xff1d0c34).withOpacity(0.5),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )
      : LinearGradient(
          colors: [
            Color(0xff6918e8).withOpacity(0.6),
            Color(0xffae4fdc).withOpacity(0.6),
            Color(0xffdc85b4).withOpacity(0.6),
            // Color(0xfff6c9c5).withOpacity(0.5),
          ],
          end: Alignment.centerLeft,
          begin: Alignment.centerRight,
        );

  @override
  Widget build(BuildContext context) {
    print(controller.myConversation.value!.aptImage);
    return Scaffold(
      body: Stack(
        children: [
          //Background with image
          Positioned.fill(
            child: Image.asset('assets/black abstract.jpg', fit: BoxFit.fill),
          ),
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(0, 8, 8, 8).withOpacity(0.86),
            ),
          ),

          //background with gradient colors
          // Positioned.fill(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         end: Alignment.topLeft,
          //         begin: Alignment.bottomRight,
          //         colors: Get.isDarkMode
          //             ? [
          //                 Color(0xff7f3aa1).withOpacity(0.6),
          //                 Color(0xff5516b5).withOpacity(0.6),
          //                 Color(0xff150b56).withOpacity(0.7),
          //                 Color(0xff0c0516).withOpacity(0.7),
          //               ]
          //             : [
          //                 Color(0xff6a1fe0),
          //                 Color(0xffa44cd0),
          //                 Color(0xffc475a0),
          //               ],
          //       ),
          //     ),
          //   ),
          // ),
          Column(
            children: [
              _buildCustomHeader(context),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    controller: controller.scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final msg = controller.messages[index];
                      final isFirstInSequence =
                          index == 0 ||
                          controller.messages[index - 1].isMe != msg.isMe;
                      return ChatBubble(
                        message: msg,
                        isFirstInSequence: isFirstInSequence,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: _buildInputArea(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomHeader(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),

      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            // color: Colors.white.withOpacity(0.2),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            gradient: gradient,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  spacing: 10,
                  children: [
                    _buildIconButton(Icons.arrow_back_ios_new, () {
                      Get.back();
                    }),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        "$baseUrl/storage/${controller.myConversation.value!.receiverAvatar}",
                        width: 65,
                        height: 65,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 65,
                          width: 65,
                          color: Color(0xa6f0e6ff).withOpacity(0.2),
                          child: const Icon(Icons.error, color: Colors.white38),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                controller.myConversation.value!.receiverName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "Replies typically in 5 mins",
                            style: TextStyle(
                              color: Color(0xB3FFFFFF),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildIconButton(Icons.phone_outlined, () {
                      Get.dialog(
                        AlertDialog(
                          icon: Icon(
                            Icons.person_pin_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                          title: Text(
                            "${controller.myConversation.value!.receiverName} 's Number ",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Louis",
                              fontSize: 18,
                            ),
                          ),
                          content: SelectableText(
                            "+ ${controller.myConversation.value!.receiverPhone}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF04BAFF),
                              fontFamily: "Louis",
                              fontSize: 18,
                            ),
                          ),
                          backgroundColor: accent.withOpacity(0.8),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // Property Card
              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        "$baseUrl/${controller.myConversation.value!.aptImage}",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 50,
                          width: 50,
                          color: Color(0xa6f0e6ff).withOpacity(0.2),
                          child: const Icon(Icons.error, color: Colors.white38),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Inquiry about:",
                            style: TextStyle(
                              color: Color(0xB3FFFFFF),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            controller.myConversation.value!.aptTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      "\$${controller.myConversation.value!.aptPrice}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightGreenAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 22, color: Colors.white60),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.05),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(49),
        gradient: gradient,
        boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.1))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.white),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: controller.textController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Sans-Serif',
                    ),
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color(0xB3FFFFFF)),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          _buildSendButton(),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return GestureDetector(
      onTap: () => controller.sendMessage(controller.textController.text),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 201, 156, 242),
              Color.fromARGB(255, 129, 33, 247),
            ],
            begin: AlignmentGeometry.topLeft,
            end: AlignmentGeometry.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 221, 152, 255).withOpacity(0.8),
              blurRadius: 10,
            ),
          ],
        ),
        child: Icon(Icons.send_rounded, color: Colors.white, size: 23),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final Messages message;
  final bool isFirstInSequence;

  const ChatBubble({
    super.key,
    required this.message,
    this.isFirstInSequence = true,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 10,
          left: message.isMe ? 60 : 0,
          right: message.isMe ? 0 : 60,
        ),
        child: Column(
          crossAxisAlignment: message.isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,

          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: message.isMe
                          ? Color(0xff8b49f1).withOpacity(0.3)
                          : Color(0xff212021).withOpacity(0.6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),

                    child: Text(
                      message.content,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              message.time,
              style: const TextStyle(
                color: Color.fromARGB(255, 187, 187, 187),
                fontSize: 11,
                fontFamily: 'Louis',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

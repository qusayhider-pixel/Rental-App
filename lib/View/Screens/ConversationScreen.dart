import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:get/get.dart';

class Message {
  final String id;
  final String content;
  final DateTime timestamp;
  final bool isMe;

  Message({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.isMe,
  });
}

class ChatUser {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isOnline;
  final bool isVerified;

  ChatUser({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isOnline = false,
    this.isVerified = false,
  });
}

class PropertyContext {
  final String title;
  final String imageUrl;
  final String price;

  PropertyContext({
    required this.title,
    required this.imageUrl,
    required this.price,
  });
}

final ChatUser landlord = ChatUser(
  id: 'owner_01',
  name: 'Karim Essam',
  avatarUrl:
      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=200',
  isOnline: true,
  isVerified: true,
);

final PropertyContext currentProperty = PropertyContext(
  title: 'Luxury Nile View Apt',
  imageUrl:
      'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=200',
  price: '\$1,200/mo',
);

final List<Message> mockMessages = [
  Message(
    id: '1',
    content: 'Hello Karim, is this apartment still available for next month?',
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    isMe: true,
  ),
  Message(
    id: '2',
    content:
        'Hello! Yes, it is available starting from the 1st. Would you like to schedule a viewing?',
    timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
    isMe: false,
  ),
  Message(
    id: '3',
    content: 'That would be great. Is Saturday morning okay?',
    timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
    isMe: true,
  ),
  Message(
    id: '4',
    content:
        'Saturday at 10:00 AM works perfectly. I will send you the location details shortly.',
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    isMe: false,
  ),
];



class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});
  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Color accent =  Color.fromARGB(255, 151, 85, 222) ;
  LinearGradient gradient = Get.isDarkMode ?
  LinearGradient(colors: [
    Color(0xff7f3aa1).withOpacity(0.5),
    Color(0xff5516b5).withOpacity(0.5),
    Color(0xff150b56).withOpacity(0.5),
    Color(0xff1d0c34).withOpacity(0.5),
  ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ):
  LinearGradient(colors: [1
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
    return Scaffold(
      body: Stack(
        children: [
          //Background with image
          Positioned.fill(
            child: Image.asset('assets/black abstract.jpg', fit: BoxFit.fill) ,
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
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  itemCount: mockMessages.length,
                  itemBuilder: (context, index) {
                    final msg = mockMessages[index];
                    final isFirstInSequence =
                        index == 0 || mockMessages[index - 1].isMe != msg.isMe;
                    return ChatBubble(
                      message: msg,
                      isFirstInSequence: isFirstInSequence,
                    );
                  },
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
            gradient: gradient ,
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
                    _buildIconButton(Icons.arrow_back_ios_new, () {Get.back();}),


                    CircleAvatar(
                      radius: 22,
                      backgroundColor: accent,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(landlord.avatarUrl),
                      ),
                    ),


                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                landlord.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              if (landlord.isVerified) ...[
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.verified,
                                  size: 16,
                                  color: accent,
                                ),
                              ],
                            ],
                          ),
                          const Text(
                            "Replies typically in 5 mins",
                            style: TextStyle(
                              color: Color(
                                0xB3FFFFFF,
                              ),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildIconButton(Icons.phone_outlined, () {}),
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
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        currentProperty.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
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
                              color: Color(
                                0xB3FFFFFF,
                              ),
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            currentProperty.title,
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
                      currentProperty.price,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
        gradient: gradient ,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
          ),
        ],
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
                    controller: _controller,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Sans-Serif',
                    ),
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Color(
                        0xB3FFFFFF,
                      )),
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
      onTap: () {
        if (_controller.text.isNotEmpty) {
          setState(() {
            mockMessages.add(
              Message(
                id: DateTime.now().toString(),
                content: _controller.text,
                timestamp: DateTime.now(),
                isMe: true,
              ),
            );
            _controller.clear();
          });
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + 100,
            duration:  Duration(milliseconds: 400),
            curve: Curves.linear,
          );
        }
      },
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
              color:  Color.fromARGB(255, 221, 152, 255).withOpacity(0.8),
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
  final Message message;
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
                  filter: ImageFilter.blur(sigmaX: 2,sigmaY: 2),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(

                      color: message.isMe ? Color(0xff8b49f1).withOpacity(0.3)
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
              "${message.timestamp.hour}:${message.timestamp.minute}",
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

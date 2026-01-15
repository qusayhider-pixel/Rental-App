import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:uni_project/Model/Notificaion_model.dart';

class NotificatoinCard extends StatelessWidget {
  final NotificationModel notification;
  const NotificatoinCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(33),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff6918e8).withOpacity(0.4),
                Color(0xffae4fdc).withOpacity(0.4),
                Color(0xffdc85b4).withOpacity(0.2),
                Color(0xfff6c9c5).withOpacity(0.1),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(33),
            border: Border.all(
              width: 1,
              color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(82, 107, 70, 255),
                spreadRadius: 0.1,
                blurRadius: 30,
                offset: const Offset(-10, -10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///notification info
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.all(
                          color: Color(0xff63c26f),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          "http://10.0.2.2:8000/storage/${notification.avatar}",
                        ),
                        onBackgroundImageError: (_, _) =>
                            const Icon(Icons.person),
                      ),
                    ),
                    SizedBox(width: 9),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " ${notification.sender} - ${notification.title}",
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notification.content,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Louis',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          notification.status == 0
                              ? Icons.done_rounded
                              : Icons.done_all_rounded,
                          size: 30,
                          color: notification.status == 0
                              ? Colors.white
                              : Color.fromARGB(255, 112, 246, 134),
                        ),
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
}

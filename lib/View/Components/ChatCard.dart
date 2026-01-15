import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_project/View/Screens/ConversationScreen.dart';
import '../../Model/FavoriteModel.dart';

class ChatCard extends StatelessWidget {
  final MyFavoriteModel apt;

  const ChatCard({super.key, required this.apt});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(()=>ConversationScreen()),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(33),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff6918e8).withOpacity(0.3),
                Color(0xffae4fdc).withOpacity(0.3),
                Color(0xffdc85b4).withOpacity(0.3),
                Color(0xfff6c9c5).withOpacity(0.3),
              ],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight,
            ),
            border: BoxBorder.fromLTRB(bottom :BorderSide(color: Color(0x3fd7d4e5) , width: 3) ),
            borderRadius: BorderRadius.circular(33),
            boxShadow: [
              BoxShadow(
                color: Color(0x52dad2fa),
                spreadRadius: 1,
                blurRadius: 15,
                offset: const Offset(5, 15),
              ),
            ],
          ),
          child:

              ///apt info
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        apt.imageUrls.first,
                        width: 65,
                        height: 65,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                              height: 65,
                              width: 65,
                              color: Color(0xa6f0e6ff).withOpacity(0.2),
                              child: const Icon(
                                Icons.error,
                                color: Colors.white38,
                              ),
                            ),
                      ),
                    ),

                    SizedBox(width: 9),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "${apt.governorate}  -  ${apt.ownerName}",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Louis',
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            apt.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                              fontSize: 13,
                              fontFamily: 'Louis',
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      right: 0,
                      child:Text("${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ",style: TextStyle(color: Colors.white ,fontSize: 12),)
                    ),
                  ],
                ),
              ),

        ),
      ),
    );
  }
}

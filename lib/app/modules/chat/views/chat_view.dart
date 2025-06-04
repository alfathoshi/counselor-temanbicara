import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/widgets/chat_container.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/message.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          toolbarHeight: 85,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              side: BorderSide(color: Colors.black12)),
          title: Text(
            'Message',
            style: h3Bold,
          ),
          centerTitle: true,
        ),
        Obx(
          () {
            // Ganti FutureBuilder dengan Obx
            if (controller.isLoading.value && controller.listChat.isEmpty) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (controller.listChat.isEmpty) {
              return const SliverFillRemaining(
                child: Center(child: Text("Tidak Ada Chat")),
              );
            } else {
              final List<Map<String, dynamic>> listData = controller.listChat;
              return SliverList.builder(
                itemCount: listData.length,
                itemBuilder: (BuildContext context, int index) {
                  var chatItem = listData[index];

                  String patientId = chatItem['patient_id'].toString();
                  String patientName = chatItem['user']?['nickname'] ?? 'User';

                  String patientImage = chatItem['user']['profile_url'] ?? '';

                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 8, bottom: 8),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: controller.getLastMessageStream(patientId),
                      builder: (context, snapshot) {
                        String lastMessage = "Memuat pesan...";
                        String displayTime = "";

                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasError) {
                            lastMessage = "Error memuat pesan.";
                          } else if (snapshot.hasData &&
                              snapshot.data!.docs.isNotEmpty) {
                            var messageData = snapshot.data!.docs.first.data()
                                as Map<String, dynamic>?;

                            if (messageData != null) {
                              final messageObj = Message.fromMap(messageData);
                              lastMessage = messageObj.message;
                              displayTime = controller
                                  .formatTimestamp(messageObj.timestamp);
                            } else {
                              lastMessage = "Belum ada percakapan.";
                            }
                          } else {
                            lastMessage = "Belum ada percakapan.";
                          }
                        }

                        return ChatContainer(
                          id: patientId,
                          nama: patientName,
                          deskripsi: lastMessage,
                          image: patientImage,
                          time: displayTime,
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ]),
    );
  }
}

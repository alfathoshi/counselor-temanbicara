import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counselor_temanbicara/app/data/message.dart';
import 'package:get_storage/get_storage.dart';

class ChatService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  GetStorage box = GetStorage();

  Future<void> sendMessage(String receiverID, message) async {
    final String currentUserID = box.read('id').toString();
    final String currentUsername = box.read('name');
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderID: currentUserID,
      senderName: currentUsername,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserID, receiverID];
    ids.sort();

    String chatRoomID = ids.join('_');

    await firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];

    ids.sort();

    String chatRoomID = ids.join('_');

    return firestore
       .collection('chat_rooms')
       .doc(chatRoomID)
       .collection('messages')
       .orderBy('timestamp', descending: true)
       .snapshots();
  }
}
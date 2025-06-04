import 'dart:convert';
import 'package:counselor_temanbicara/app/services/chat_services.dart';
import 'package:counselor_temanbicara/app/services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../config/config.dart';

class ChatController extends GetxController {
  final listChat = [].obs;
  GetStorage box = GetStorage();

  ChatService chatService = ChatService();

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(
      Uri.parse(
        '${Config.apiEndPoint}/consultation/counselor',
      ),
      headers: {'Authorization': 'Bearer ${box.read('token')}'},
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      listChat.value = data['data'];

      return json.decode(response.body);
    } else {
      throw Exception('Failed to load chat');
    }
  }

  void _initFirebaseListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService.showNotification(message);
    });
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _initFirebaseListener();
    fetchData();
  }
}

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counselor_temanbicara/app/services/chat_services.dart';
import 'package:counselor_temanbicara/app/services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../config/config.dart';

class ChatController extends GetxController {
  final listChat = <Map<String, dynamic>>[].obs;
  final isLoading = true.obs;
  GetStorage box = GetStorage();
  String get currentCounselorId => box.read('id').toString();

  ChatService _chatService = ChatService();

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('${Config.apiEndPoint}/consultation/counselor'),
        headers: {'Authorization': 'Bearer ${box.read('token')}'},
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['status'] == true && responseData['data'] != null) {
          final List rawData = responseData['data'];
          final List<Map<String, dynamic>> uniqueChatList = [];
          final Set<dynamic> uniquePatientIds = {};

          for (var item in rawData) {
            var patientId = item['user']?['id'];
            if (patientId != null && uniquePatientIds.add(patientId)) {
              uniqueChatList.add(item as Map<String, dynamic>);
            }
          }
          listChat.value = uniqueChatList;
        } else {
          listChat.clear();
        }
      } else {
        listChat.clear();
        throw Exception(
            'Failed to load chat list from API: ${response.statusCode}');
      }
    } catch (e) {
      listChat.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Stream<QuerySnapshot> getLastMessageStream(String patientId) {
    return _chatService.getMessages(currentCounselorId, patientId);
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();

    if (DateTime.now().difference(dateTime).inDays == 0) {
      return DateFormat('HH:mm').format(dateTime);
    } else {
      return DateFormat('dd MMM').format(dateTime);
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
}

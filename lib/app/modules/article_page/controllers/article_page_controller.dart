import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../config/config.dart';

class ArticlePageController extends GetxController {
  final box = GetStorage();
  var isLoading = false.obs;
  var articleList = [].obs;
  var article = {}.obs;
  var isLoadingInitial = false.obs;
  var isLoadingMore = false.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var hasMoreData = true.obs;
  final isFabVisible = true.obs;


  final ScrollController scrollController = ScrollController();

  Future<void> fetchArticles(
      {required int page, bool isInitialLoad = false}) async {
        
    if (isInitialLoad) {
      if (isLoadingInitial.value) return;
      isLoadingInitial.value = true;
    } else {
      if (isLoadingMore.value || !hasMoreData.value) return;
      isLoadingMore.value = true;
    }
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('${Config.apiEndPoint}/article/counselor?page=$page'),
        headers: {'Authorization': 'Bearer ${box.read('token')}'},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == true && data['data'] != null) {
          final paginationData = data['data'];
          article.value = data['data'];
          if (paginationData['data'] is List) {
            List<dynamic> fetchedArticlesRaw = paginationData['data'] ?? [];
            List<Map<String, dynamic>> fetchedArticles =
                List<Map<String, dynamic>>.from(fetchedArticlesRaw);
            if (isInitialLoad) {
              articleList.clear();
            }
            articleList.addAll(fetchedArticles);

            currentPage.value = paginationData['current_page'] ?? page;
            lastPage.value = paginationData['last_page'] ?? page;
            hasMoreData.value = currentPage.value < lastPage.value;
          } else {
            if (isInitialLoad) articleList.clear();
            hasMoreData.value = false;
          }
        }
      } else {
        if (isInitialLoad) articleList.clear();
        hasMoreData.value = false;
      }
    } catch (e) {
      if (isInitialLoad) articleList.clear();
      hasMoreData.value = false;
    } finally {
      if (isInitialLoad) {
        isLoadingInitial.value = false;
      }
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshArticles() async {
    currentPage.value = 1;
    hasMoreData.value = true;
    await fetchArticles(page: 1, isInitialLoad: true);
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        hasMoreData.value &&
        !isLoadingMore.value &&
        !isLoadingInitial.value) {
      fetchArticles(page: currentPage.value + 1);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchArticles(page: 1, isInitialLoad: true);
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }
}

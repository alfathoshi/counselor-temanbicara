import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../controllers/create_article_controller.dart';

class CreateArticleView extends GetView<CreateArticleController> {
  const CreateArticleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            side: BorderSide(color: Colors.black12)),
        title: Text(
          'Writing',
          style: h3Bold,
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
                onPressed: () {
                  controller.submitArticle();
                  Get.offAllNamed(Routes.NAVIGATION_BAR,
                      arguments: {"indexPage": 1});
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primaryColor),
                  foregroundColor: WidgetStatePropertyAll(whiteColor),
                ),
                child: const Text('Publish')),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: h6SemiBold,
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: controller.title,
              decoration: InputDecoration(
                
                prefixIcon: const Icon(Iconsax.document),
                hintText: 'Add Your Title...',
                hintStyle: h7Regular,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: border)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Write Your Article',
              style: h6SemiBold,
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: quill.QuillEditor.basic(
                controller: controller.quillController,
                scrollController: ScrollController(),
                focusNode: FocusNode(),
                configurations: const quill.QuillEditorConfigurations(
                  placeholder: 'Write an article here...',
                ),
              ),
            ),
            Container(
              child: quill.QuillToolbar.simple(
                controller: controller.quillController,
                configurations: quill.QuillSimpleToolbarConfigurations(
                  showClipboardPaste: false,
                  showCodeBlock: false,
                  showSearchButton: false,
                  showListCheck: false,
                  showClearFormat: false,
                  showDirection: false,
                  showInlineCode: false,
                  showClipboardCut: false,
                  showClipboardCopy: false,
                  showSubscript: false,
                  showSuperscript: false,
                  buttonOptions: quill.QuillSimpleToolbarButtonOptions(
                    linkStyle: quill.QuillToolbarLinkStyleButtonOptions(
                      dialogTheme: quill.QuillDialogTheme(
                        dialogBackgroundColor: whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

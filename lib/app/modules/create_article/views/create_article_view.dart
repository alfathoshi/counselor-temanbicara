import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import '../controllers/create_article_controller.dart';

class CreateArticleView extends GetView<CreateArticleController> {
  const CreateArticleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
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
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(primaryColor),
                  foregroundColor: WidgetStatePropertyAll(whiteColor),
                ),
                child: const Text('Publish')),
          )
        ],
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                if (controller.isLoading.value)
                  const Center(child: CircularProgressIndicator()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Image',
                      style: h6SemiBold,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await controller.pickImage();
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: controller.pickedImage.value != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  controller.pickedImage.value!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : controller.profileUrl.value != ''
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      controller.profileUrl.value,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Center(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                                  ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Title',
                      style: h6SemiBold,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: controller.title,
                      cursorColor: black,
                      decoration: InputDecoration(
                        hintText: 'Add Your Title...',
                        hintStyle: h5Regular.copyWith(color: grey2Color),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: greyColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: primaryColor),
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
                        config: const quill.QuillEditorConfig(
                          placeholder: 'Write an article here...',
                        ),
                      ),
                    ),
                    quill.QuillSimpleToolbar(
                      controller: controller.quillController,
                      config: quill.QuillSimpleToolbarConfig(
                        showUndo: false,
                        showBackgroundColorButton: false,
                        showColorButton: false,
                        showRedo: false,
                        showFontFamily: false,
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
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

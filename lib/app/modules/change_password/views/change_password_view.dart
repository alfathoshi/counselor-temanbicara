import 'package:counselor_temanbicara/app/routes/app_pages.dart';
import 'package:counselor_temanbicara/app/themes/colors.dart';
import 'package:counselor_temanbicara/app/themes/fonts.dart';
import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:counselor_temanbicara/app/widgets/my_button.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  ChangePasswordView({super.key});

  bool _isPasswordValid(String value) {
    return MinCharactersValidationRule(8).validate(value) &&
        UppercaseValidationRule().validate(value) &&
        LowercaseValidationRule().validate(value) &&
        SpecialCharacterValidationRule().validate(value);
  }

  Widget _buildValidationRules(Set<ValidationRule> rules, String value) {
    return ListView(
      shrinkWrap: true,
      children: rules.map((rule) {
        final isValid = rule.validate(value);
        return Row(
          children: [
            Icon(
              isValid ? Icons.check : Icons.close,
              color: isValid ? primaryColor : error,
            ),
            const SizedBox(width: 8),
            Text(
              rule.name,
              style: h6Regular.copyWith(color: isValid ? primaryColor : error),
            ),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          'Change Password',
          style: h3Bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 375,
                width: 350,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Old Password',
                        style: textDescriptionSemiBold,
                      ),
                      szbY8,
                      TextField(
                        controller: controller.oldPassController,
                        cursorColor: black,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Password Lama',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: h6Medium.copyWith(
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'New Password',
                        style: textDescriptionSemiBold,
                      ),
                      szbX8,
                      Obx(() => FancyPasswordField(
                            controller: controller.newPassController,
                            keyboardType: TextInputType.text,
                            obscureText: controller.isNewPassObscure.value,
                            onChanged: (value) {
                              controller.isPasswordValid.value =
                                  _isPasswordValid(value);
                              controller.isButtonActive.value =
                                  value.isNotEmpty;
                            },
                            validationRules: {
                              MinCharactersValidationRule(8),
                              UppercaseValidationRule(),
                              LowercaseValidationRule(),
                              SpecialCharacterValidationRule(),
                            },
                            validationRuleBuilder: (rules, value) {
                              bool allValid =
                                  rules.every((rule) => rule.validate(value));
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                controller.isButtonActive.value = allValid;
                              });
                              if (value.isEmpty) return const SizedBox.shrink();
                              return _buildValidationRules(rules, value);
                            },
                            decoration: InputDecoration(
                              hintText: "Enter New Password",
                              hintStyle: h4Regular.copyWith(color: grey4Color),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isNewPassObscure.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 20,
                                ),
                                onPressed: () {
                                  controller.isNewPassObscure.value =
                                      !controller.isNewPassObscure.value;
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: greyColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: primaryColor),
                              ),
                            ),
                          )),
                      szbY16,
                      Text(
                        'Confirm Password',
                        style: textDescriptionSemiBold,
                      ),
                      szbX8,
                      TextField(
                        controller: controller.confirmPassController,
                        cursorColor: black,
                        decoration: InputDecoration(
                          hintText: 'Konfirmasi Password',
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
                    ],
                  ),
                ),
              ),
            ),
            szbY16,
            MyButton(
                get: () {
                  controller.changePassword();
                  Get.offAllNamed(Routes.NAVIGATION_BAR,
                      arguments: {"indexPage": 3});
                },
                color: primaryColor,
                text: 'Simpan')
          ],
        ),
      ),
    );
  }
}

import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

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
                      Text('New Password', style: textDescriptionSemiBold),
                      szbY8,
                      Obx(() => FancyPasswordField(
                            controller: controller.newPasswordController,
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
                              if (value.isEmpty) {
                                return const SizedBox.shrink();
                              }
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
                                borderSide: const BorderSide(color: greyColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: primaryColor),
                              ),
                            ),
                          )),
                      szbY16,
                      Text('Confirm Password', style: textDescriptionSemiBold),
                      szbY8,
                      Obx(() => TextField(
                            controller: controller.confirmPasswordController,
                            cursorColor: black,
                            obscureText: controller.isConfPassObscure.value,
                            decoration: InputDecoration(
                              hintText: 'Konfirmasi Password',
                              hintStyle: h5Regular.copyWith(color: grey2Color),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isConfPassObscure.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 20,
                                ),
                                onPressed: () {
                                  controller.isConfPassObscure.value =
                                      !controller.isConfPassObscure.value;
                                },
                              ),
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
                          )),
                    ],
                  ),
                ),
              ),
            ),
            szbY24,
            Obx(() => ElevatedButton(
                  onPressed: () {
                    controller.changePassword();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: whiteColor),
                        )
                      : Text(
                          'Confirm',
                          style: h4Bold.copyWith(color: whiteColor),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}

Widget changePasswordTextfield(
    String hint, TextEditingController textController, RxBool isObscure) {
  return Obx(() => TextField(
        obscureText: isObscure.value,
        controller: textController,
        cursorColor: black,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              isObscure.value = !isObscure.value;
            },
            child: Icon(
              isObscure.value
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 20,
            ),
          ),
          hintText: hint,
          hintStyle: h5Regular.copyWith(color: grey2Color),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: greyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: primaryColor),
          ),
        ),
      ));
}

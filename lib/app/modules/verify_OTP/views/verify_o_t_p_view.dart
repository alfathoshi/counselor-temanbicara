import 'package:counselor_temanbicara/app/themes/sizedbox.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../themes/colors.dart';
import '../../../themes/fonts.dart';
import '../../../widgets/custom_snackbar.dart';
import '../controllers/verify_o_t_p_controller.dart';

class VerifyOTPView extends GetView<VerifyOTPController> {
  const VerifyOTPView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
            'Verify OTP',
            style: h3Bold,
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 48,
                ),
                Image.asset('assets/images/sendotp.png'),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'OTP Verification',
                  style: GoogleFonts.poppins().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: const Color(0xFF5B5B5B),
                  ),
                ),
                Text(
                  'Enter the OTP that has been emailed to ${controller.email}',
                  style: GoogleFonts.poppins().copyWith(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                szbY24,
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(6, (index) {
                      return Obx(
                        () => buildOtpField(index, controller, context),
                      );
                    }),
                  ),
                ),
                szbY16,
                Obx(
                  () => Text(
                    'OTP invalid, try again',
                    style: GoogleFonts.poppins().copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: controller.isCorrect.value
                          ? Colors.white
                          : const Color(0xFFFF8B7B),
                    ),
                  ),
                ),
                szbY24,
                Obx(() {
                  bool canResend = controller.resendSeconds.value == 0;
                  return Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Didn\'t get any OTP email? ',
                          style: GoogleFonts.poppins().copyWith(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        canResend
                            ? TextSpan(
                                text: 'Resend OTP!',
                                style: GoogleFonts.poppins().copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: const Color(0xFF7E954E),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => controller.sendOtp(),
                              )
                            : TextSpan(
                                text:
                                    'Resend in ${controller.resendSeconds.value}s',
                                style: GoogleFonts.poppins().copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                      ],
                    ),
                  );
                }),
                szbY24,
                Obx(
                  () => ElevatedButton(
                    onPressed: () async {
                      if (controller.focusedIndex.value == 0) {
                        CustomSnackbar.showSnackbar(
                          title: "Oops!",
                          message: "Please Fill the Fields!",
                          status: false,
                        );
                        return;
                      }

                      if (!controller.isButtonActive.value) {
                        controller.isLoading.value = true;
                        await controller.verifyOtp();
                      }
                      controller.isLoading.value = false;
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(
                          double.infinity,
                          56,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: controller.isLoading.value == false
                        ? Text(
                            'Verify',
                            style: h4Bold.copyWith(color: whiteColor),
                          )
                        : SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: whiteColor,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildOtpField(int index, var controller, var context) {
  var inputSize = (MediaQuery.sizeOf(context).width - 92) / 6;

  return SizedBox(
    width: inputSize,
    height: inputSize,
    child: TextField(
      style: TextStyle(fontSize: inputSize / 4, fontWeight: FontWeight.bold),
      enabled: index == controller.focusedIndex.value,
      controller: controller.controllers[index],
      focusNode: controller.focusNodes[index],
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: 1,
      onChanged: (value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.focusNodes[controller.focusedIndex.value].requestFocus();
        });

        if (value.isNotEmpty && index < 5) {
          controller.focusedIndex.value = index + 1;
          FocusScope.of(context).requestFocus(controller.focusNodes[index + 1]);
        } else if (value.isEmpty && index > 0) {
          controller.isButtonActive.value = true;
          controller.focusedIndex.value = index - 1;
          FocusScope.of(context).requestFocus(controller.focusNodes[index - 1]);
        }

        if (index == 5) controller.isButtonActive.value = false;
      },
      decoration: InputDecoration(
        counterText: '',
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../constant/colors.dart';

class OtpForm extends StatelessWidget {
  final String phoneNumber;
  final String otp;
  final bool isLoading;
  final int resendSeconds;
  final bool canResend;
  final Function(String) onOtpChanged;
  final VoidCallback onResendTapped;
  final VoidCallback onChangeNumberTapped;

  const OtpForm({
    super.key,
    required this.phoneNumber,
    required this.otp,
    required this.isLoading,
    required this.resendSeconds,
    required this.canResend,
    required this.onOtpChanged,
    required this.onResendTapped,
    required this.onChangeNumberTapped,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Verify Number",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blueText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.inter(
                          color: AppColors.greyText,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          const TextSpan(text: "OTP sent to  "),
                          TextSpan(
                            text: "+91 $phoneNumber",
                            style: GoogleFonts.inter(
                              color: AppColors.textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  "assets/otplock.png",
                  width: 48,
                  height: 48,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.1),
            RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  const TextSpan(text: "Enter OTP"),
                  TextSpan(
                    text: "*",
                    style: GoogleFonts.inter(
                      color: AppColors.error,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            PinCodeTextField(
              appContext: context,
              length: 6,
              onChanged: onOtpChanged,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(16),
                fieldHeight: screenHeight * 0.07,
                fieldWidth: screenWidth * 0.14,
                activeFillColor: Colors.white,
                inactiveFillColor: Colors.grey[200],
                selectedFillColor: Colors.white,
                activeColor: Colors.grey,
                inactiveColor: Colors.grey,
                selectedColor: AppColors.blueText,
              ),
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              enableActiveFill: true,
              enabled: !isLoading,
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: canResend ? onResendTapped : null,
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(fontSize: 14),
                    children: [
                      TextSpan(
                        text: "Resend in ",
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      TextSpan(
                        text: canResend
                            ? "Resend Now"
                            : "00:${resendSeconds.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          color: canResend ? AppColors.blueText : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(height: screenHeight * 0.05),
            Center(
              child: GestureDetector(
                onTap: onChangeNumberTapped,
                child: Text(
                  'change your mobile number',
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            if (isLoading)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
              ),
          ],
        ),
      ],
    );
  }
}
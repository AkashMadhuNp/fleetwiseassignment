import 'package:fleetwise/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final String? phoneError;
  final bool isLoading;
  final Function(String) onPhoneChanged;
  final VoidCallback onGetOtpPressed;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.phoneError,
    required this.isLoading,
    required this.onPhoneChanged,
    required this.onGetOtpPressed,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length != 10 || !RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
      return 'Enter a valid 10-digit Indian mobile number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                child: Text(
                  "Login or register",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium?.color, // 0xFF596D7E (light), 0xFFB0B0B0 (dark)
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 58,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface, // 0xFFFFFFFF (light), 0xFF1E1E1E (dark)
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor, // 0x33000000 (light), 0x66000000 (dark)
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "+91",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Theme.of(context).dividerColor, // 0xFFCFD8DC (light), 0xFF424242 (dark)
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: widget.phoneController,
                        keyboardType: TextInputType.phone,
                        validator: _validatePhoneNumber,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        onChanged: widget.onPhoneChanged,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Enter phone number",
                          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle, // 0xFFB0BEC5 (light), 0xFF757575 (dark)
                          errorText: widget.phoneError,
                          errorStyle: TextStyle(color: Theme.of(context).colorScheme.error), // 0xFFE57373 (light), 0xFFEF5350 (dark)
                        ),
                        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color), // 0xFF596D7E (light), 0xFFE0E0E0 (dark)
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        children: [
                          const TextSpan(text: "by continuing, you agree to our "),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        children: [
                          TextSpan(
                            text: "Term Of Use",
                            style: GoogleFonts.inter(
                              color: Theme.of(context).colorScheme.primary, // 0xFF1A3A6D (light), 0xFF3F6BAF (dark)
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("Navigated to Term Of Use");
                              },
                          ),
                          const TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: GoogleFonts.inter(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("Navigated to Privacy Policy");
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          widget.isLoading
              ? Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary))
              : CustomButton(
                  text: "GET OTP",
                  onPressed: widget.onGetOtpPressed,
                ),
        ],
      ),
    );
  }
}
import 'package:fleetwise/components/profileName/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/custom_button.dart';
import '../../constant/colors.dart';

class ProfileForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final bool isLoading;
  final Function(String?) onValidateName;
  final VoidCallback onSubmitPressed;

  const ProfileForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.isLoading,
    required this.onValidateName,
    required this.onSubmitPressed,
  });

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  String? _validateName(String? value) {
    return widget.onValidateName(value);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileHeader(),
          const SizedBox(height: 90),
          RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              children: [
                const TextSpan(text: "Your Full Name"),
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
          TextFormField(
            controller: widget.nameController,
            validator: _validateName,
            enabled: !widget.isLoading,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              hintText: "Enter your full name",
              hintStyle: TextStyle(color: AppColors.greyText),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.4),
          Center(
            child: widget.isLoading
                ? CircularProgressIndicator(color: AppColors.primary)
                : CustomButton(
                    text: "SUBMIT",
                    onPressed: widget.onSubmitPressed,
                  ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
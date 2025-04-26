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
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Form(
      key: widget.formKey,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeader(),
              // Use proportional spacing instead of fixed height
              SizedBox(height: screenHeight * 0.05), // Reduced from 90 to 5% of screen height
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
              SizedBox(height: screenHeight * 0.015), 
              FractionallySizedBox(
                widthFactor: 1.0, 
                child: TextFormField(
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
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.02, 
                    ),
                    hintText: "Enter your full name",
                    hintStyle: TextStyle(color: AppColors.greyText),
                  ),
                ),
              ),
              
              SizedBox(
                height: screenHeight * 0.1, 
              ),
              
              Center(
                child: widget.isLoading
                    ? CircularProgressIndicator(color: AppColors.primary)
                    : FractionallySizedBox(
                        widthFactor: 0.9, 
                        child: CustomButton(
                          text: "SUBMIT",
                          onPressed: widget.onSubmitPressed,
                        ),
                      ),
              ),
              
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          );


        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/colors.dart';

class DocumentForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final int currentStep;
  final String? panCardPath;
  final String? aadhaarFrontPath;
  final String? aadhaarBackPath;
  final bool isLoading;
  final VoidCallback onPanCardUpload;
  final VoidCallback onAadhaarFrontUpload;
  final VoidCallback onAadhaarBackUpload;
  final VoidCallback onSubmitPressed;
  final VoidCallback onSkipPressed;

  const DocumentForm({
    super.key,
    required this.formKey,
    required this.currentStep,
    required this.panCardPath,
    required this.aadhaarFrontPath,
    required this.aadhaarBackPath,
    required this.isLoading,
    required this.onPanCardUpload,
    required this.onAadhaarFrontUpload,
    required this.onAadhaarBackUpload,
    required this.onSubmitPressed,
    required this.onSkipPressed,
  });

  Widget _buildSliderBar({required int step}) {
    return Container(
      width: step <= currentStep ? 80 : 70,
      height: 4,
      decoration: BoxDecoration(
        color: step <= currentStep ? const Color(0xFF596D7E) : const Color(0xFFE7EAEC),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  Widget _buildDocumentField({
    required String label,
    required bool isRequired,
    String? filePath,
    required VoidCallback onUpload,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
              color: AppColors.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(text: label),
              if (isRequired)
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
        const SizedBox(height: 8),
        Container(
          width: 398,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    filePath != null ? filePath.split('/').last : "No file selected",
                    style: TextStyle(color: filePath != null ? AppColors.textPrimary : AppColors.greyText),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: isLoading ? null : onUpload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: Container(
                  width: 92,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE7EAEC), width: 1),
                  ),
                  child: Center(
                    child: Text(
                      "Upload",
                      style: GoogleFonts.inter(
                        color: AppColors.blueText,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 398,
            height: 4,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildSliderBar(step: 1),
                const SizedBox(width: 10),
                _buildSliderBar(step: 2),
                const SizedBox(width: 10),
                _buildSliderBar(step: 3),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Identity & Address proof of owner",
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
                        const TextSpan(text: "Raman Ji, get started with document upload!"),
                      ],
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: isLoading ? null : onSkipPressed,
                child: Text(
                  "Skip",
                  style: GoogleFonts.inter(
                    color: AppColors.greyText,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildDocumentField(
            label: "PAN Card",
            isRequired: true,
            filePath: panCardPath,
            onUpload: onPanCardUpload,
          ),
          const SizedBox(height: 16),
          _buildDocumentField(
            label: "Aadhaar Card Front",
            isRequired: true,
            filePath: aadhaarFrontPath,
            onUpload: onAadhaarFrontUpload,
          ),
          const SizedBox(height: 16),
          _buildDocumentField(
            label: "Aadhaar Card Back",
            isRequired: true,
            filePath: aadhaarBackPath,
            onUpload: onAadhaarBackUpload,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.4),
          Center(
            child: isLoading
                ? CircularProgressIndicator(color: AppColors.primary)
                : ElevatedButton(
                    onPressed: onSubmitPressed,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(398, 54),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "SUBMIT",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColors.white,
                      ),
                    ),
                  ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
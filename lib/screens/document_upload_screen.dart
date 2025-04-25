import 'package:file_picker/file_picker.dart';
import 'package:fleetwise/BLoC/bloc/auth_bloc.dart';
import 'package:fleetwise/BLoC/bloc/auth_event.dart';
import 'package:fleetwise/BLoC/bloc/auth_state.dart';
import 'package:fleetwise/components/document/document_form.dart';
import 'package:fleetwise/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../constant/colors.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({super.key});

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  final _formKey = GlobalKey<FormState>();
  int currentStep = 1;
  String? _panCardPath;
  String? _aadhaarFrontPath;
  String? _aadhaarBackPath;

  Future<void> _pickFile(String attribute) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        if (attribute == 'pan_card') {
          _panCardPath = result.files.single.path;
        } else if (attribute == 'aadhar_card') {
          _aadhaarFrontPath = result.files.single.path;
        } else if (attribute == 'aadhar_card_back') {
          _aadhaarBackPath = result.files.single.path;
        }
      });
    }
  }

  void _submitDocuments() {
    if (_panCardPath == null || _aadhaarFrontPath == null || _aadhaarBackPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please upload all required documents", style: TextStyle(color: AppColors.white)),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    context.read<AuthBloc>().add(UploadDocumentEvent(
      panCardPath: _panCardPath!,
      aadhaarFrontPath: _aadhaarFrontPath!,
      aadhaarBackPath: _aadhaarBackPath!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          print("Document upload successful, navigating to HomeScreen");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Documents uploaded successfully!", style: TextStyle(color: AppColors.white)),
              backgroundColor: AppColors.success,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        } else if (state is AuthError) {
          print("Document upload failed: ${state.message}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message, style: TextStyle(color: AppColors.white)),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          backgroundColor: AppColors.background,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: DocumentForm(
                  formKey: _formKey,
                  currentStep: currentStep,
                  panCardPath: _panCardPath,
                  aadhaarFrontPath: _aadhaarFrontPath,
                  aadhaarBackPath: _aadhaarBackPath,
                  isLoading: isLoading,
                  onPanCardUpload: () => _pickFile('pan_card'),
                  onAadhaarFrontUpload: () => _pickFile('aadhar_card'),
                  onAadhaarBackUpload: () => _pickFile('aadhar_card_back'),
                  onSubmitPressed: _submitDocuments,
                  onSkipPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
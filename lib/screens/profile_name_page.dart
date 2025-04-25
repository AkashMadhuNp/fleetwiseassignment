import 'package:fleetwise/BLoC/bloc/auth_bloc.dart';
import 'package:fleetwise/BLoC/bloc/auth_event.dart';
import 'package:fleetwise/BLoC/bloc/auth_state.dart';
import 'package:fleetwise/components/profileName/profile_form.dart';
import 'package:fleetwise/screens/document_upload_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../constant/colors.dart';

class ProfileNamePage extends StatefulWidget {
  const ProfileNamePage({super.key});

  @override
  State<ProfileNamePage> createState() => _ProfileNamePageState();
}

class _ProfileNamePageState extends State<ProfileNamePage> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess && state.name != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const DocumentUploadScreen()),
          );
        } else if (state is AuthError) {
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
                child: ProfileForm(
                  formKey: _formKey,
                  nameController: _nameController,
                  isLoading: isLoading,
                  onValidateName: _validateName,
                  onSubmitPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(UpdateNameEvent(_nameController.text));
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
import 'package:fleetwise/BLoC/bloc/auth_bloc.dart';
import 'package:fleetwise/BLoC/bloc/auth_event.dart';
import 'package:fleetwise/BLoC/bloc/auth_state.dart';
import 'package:fleetwise/components/login/logo_name.dart';
import 'package:fleetwise/components/login/top_design.dart';
import 'package:fleetwise/components/login/truck_img.dart';
import 'package:fleetwise/components/login/login_form.dart';
import 'package:fleetwise/constant/colors.dart';
import 'package:fleetwise/screens/otp_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _phoneError;

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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is OtpSent) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OTPScreen(
                phoneNumber: state.phoneNumber,
                requestId: state.requestId,
              ),
            ),
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
          body: SafeArea(
            child: Stack(
              children: [
                TopDesign(),
                TruckImage(),
                LogoName(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: LoginForm(
                    formKey: _formKey,
                    phoneController: _phoneController,
                    phoneError: _phoneError,
                    isLoading: isLoading,
                    onPhoneChanged: (value) {
                      setState(() {
                        _phoneError = _validatePhoneNumber(value);
                      });
                    },
                    onGetOtpPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(SendOtpEvent(_phoneController.text));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
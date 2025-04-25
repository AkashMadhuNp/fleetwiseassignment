import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../BLoC/bloc/auth_bloc.dart';
import '../BLoC/bloc/auth_event.dart';
import '../BLoC/bloc/auth_state.dart';
import '../constant/colors.dart';
import '../components/otp/otp_form.dart';
import 'profile_name_page.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  final String requestId;

  const OTPScreen({super.key, required this.phoneNumber, required this.requestId});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String otp = '';
  int _resendSeconds = 48;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_resendSeconds > 0 && mounted) {
        setState(() {
          _resendSeconds--;
        });
        _startResendTimer();
      } else if (mounted) {
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  void _resendOtp() {
    if (_canResend) {
      context.read<AuthBloc>().add(SendOtpEvent(widget.phoneNumber));
      setState(() {
        _resendSeconds = 48;
        _canResend = false;
        otp = '';
      });
      _startResendTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => ProfileNamePage()),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message, style: TextStyle(color: AppColors.white)),
              backgroundColor: AppColors.error,
            ),
          );
        } else if (state is OtpSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("OTP resent successfully!", style: TextStyle(color: AppColors.white)),
              backgroundColor: AppColors.success,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return Scaffold(
          backgroundColor: AppColors.background,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: screenHeight - MediaQuery.of(context).padding.top,
                  ),
                  child: OtpForm(
                    phoneNumber: widget.phoneNumber,
                    otp: otp,
                    isLoading: isLoading,
                    resendSeconds: _resendSeconds,
                    canResend: _canResend,
                    onOtpChanged: (value) {
                      setState(() {
                        otp = value;
                      });
                      if (value.length == 6 && !isLoading) {
                        context.read<AuthBloc>().add(
                              VerifyOtpEvent(widget.phoneNumber, value, widget.requestId),
                            );
                      }
                    },
                    onResendTapped: _resendOtp,
                    onChangeNumberTapped: () {
                      Navigator.pop(context);
                    },
                  ),
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
    super.dispose();
  }
}
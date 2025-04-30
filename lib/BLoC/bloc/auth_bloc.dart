import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fleetwise/service/api_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService apiService;

  AuthBloc(this.apiService) : super(const AuthInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<UpdateNameEvent>(_onUpdateName);
    on<UploadDocumentEvent>(_onUploadDocument);
    on<CheckAuthStatus>(_onCheckAuthStatus);
    // on<AddVehicleEvent>(_onAddVehicle);
    // on<FetchPnLEvent>(_onFetchPnL);
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final requestId = await apiService.sendOtp(event.phoneNumber);
      emit(OtpSent(requestId, event.phoneNumber));
    } catch (e) {
      emit(AuthError(_parseError(e)));
    }
  }

  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final authResponse = await apiService.verifyOtp(
        phoneNumber: event.phoneNumber,
        otp: event.otp,
        requestId: event.requestId,
      );
      emit(AuthSuccess(authResponse: authResponse));
    } catch (e) {
      emit(AuthError(_parseError(e)));
    }
  }

  Future<void> _onUpdateName(UpdateNameEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final updatedName = await apiService.updateName(event.name);
      emit(AuthSuccess(name: updatedName));
    } catch (e) {
      emit(AuthError(_parseError(e)));
    }
  }

  Future<void> _onUploadDocument(UploadDocumentEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await apiService.uploadFile('pan_card', event.panCardPath);
      await apiService.uploadFile('aadhar_card', event.aadhaarFrontPath);
      await apiService.uploadFile('aadhar_card_back', event.aadhaarBackPath);
      emit(const AuthSuccess(documentsUploaded: true));
    } catch (e) {
      emit(AuthError(_parseError(e)));
    }
  }

  Future<void> _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final isAuthenticated = await apiService.isAuthenticated();
      if (isAuthenticated) {
        emit(const AuthSuccess()); // No specific data needed for initial check
      } else {
        emit(const Unauthenticated());
      }
    } catch (e) {
      emit(const Unauthenticated());
    }
  }

  String _parseError(dynamic e) {
    if (e is DioException) {
      if (e.response?.statusCode == 400) {
        return "Invalid input. Please check your details.";
      } else if (e.response?.statusCode == 401) {
        return "Authentication failed. Please try again.";
      } else if (e.response?.statusCode == 429) {
        return "Too many attempts. Please wait and try again.";
      }
    }
    return "An unexpected error occurred.";
  }
}
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fleetwise/service/api_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService apiService;

  AuthBloc(this.apiService) : super(AuthInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<UpdateNameEvent>(_onUpdateName);
    on<UploadDocumentEvent>(_onUploadDocument);
    // on<AddVehicleEvent>(_onAddVehicle);
    // on<FetchPnLEvent>(_onFetchPnL);
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final requestId = await apiService.sendOtp(event.phoneNumber);
      emit(OtpSent(requestId, event.phoneNumber));
    } catch (e) {
      emit(AuthError(_parseError(e)));
    }
  }

  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
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
    emit(AuthLoading());
    try {
      final updatedName = await apiService.updateName(event.name);
      print("Emitting AuthSuccess with name: $updatedName");
      emit(AuthSuccess(name: updatedName));
    } catch (e) {
      emit(AuthError(_parseError(e)));
    }
  }

  Future<void> _onUploadDocument(UploadDocumentEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await apiService.uploadFile('pan_card', event.panCardPath);
      await apiService.uploadFile('aadhar_card', event.aadhaarFrontPath);
      await apiService.uploadFile('aadhar_card_back', event.aadhaarBackPath);
      emit(AuthSuccess(documentsUploaded: true));
    } catch (e) {
      emit(AuthError(_parseError(e)));
    }
  }

  // Future<void> _onAddVehicle(AddVehicleEvent event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());
  //   try {
  //     await apiService.addVehicle(event.vehicleNumber);
  //     final data = await apiService.getTodayPnL(); // Refresh P&L data with vehicles
  //     emit(AuthSuccess(vehicleAdded: true, pnLData: data));
  //   } catch (e) {
  //     emit(AuthError(_parseError(e)));
  //   }
  // }

  // Future<void> _onFetchPnL(FetchPnLEvent event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());
  //   try {
  //     late PnLData data;
  //     if (event.period == "today") {
  //       data = await apiService.getTodayPnL();
  //     } else if (event.period == "yesterday") {
  //       data = await apiService.getYesterdayPnL();
  //     } else {
  //       data = await apiService.getMonthlyPnL();
  //     }
  //     emit(AuthSuccess(pnLData: data));
  //   } catch (e) {
  //     emit(AuthError(_parseError(e)));
  //   }
  // }

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
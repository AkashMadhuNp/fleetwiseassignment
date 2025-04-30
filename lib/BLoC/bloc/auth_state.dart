import 'package:equatable/equatable.dart';
import 'package:fleetwise/models/auth_model.dart';
import 'package:fleetwise/models/pnl_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class OtpSent extends AuthState {
  final String requestId;
  final String phoneNumber;

  const OtpSent(this.requestId, this.phoneNumber);

  @override
  List<Object?> get props => [requestId, phoneNumber];
}

class AuthSuccess extends AuthState {
  final AuthResponse? authResponse; // From VerifyOtpEvent
  final String? name; // From UpdateNameEvent
  final bool documentsUploaded; // From UploadDocumentEvent
  final bool vehicleAdded; // From AddVehicleEvent
  final PnLData? pnLData; // From FetchPnLEvent
  final List<Vehicle>? vehicles; // Optional for vehicle-related data

  const AuthSuccess({
    this.authResponse,
    this.name,
    this.documentsUploaded = false,
    this.vehicleAdded = false,
    this.pnLData,
    this.vehicles,
  });

  @override
  List<Object?> get props => [authResponse, name, documentsUploaded, vehicleAdded, pnLData, vehicles];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}
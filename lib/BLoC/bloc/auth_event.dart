import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String phoneNumber;
  const SendOtpEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyOtpEvent extends AuthEvent {
  final String phoneNumber;
  final String otp;
  final String requestId;
  const VerifyOtpEvent(this.phoneNumber, this.otp, this.requestId);

  @override
  List<Object?> get props => [phoneNumber, otp, requestId];
}

class UpdateNameEvent extends AuthEvent {
  final String name;
  const UpdateNameEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class UploadDocumentEvent extends AuthEvent {
  final String panCardPath;
  final String aadhaarFrontPath;
  final String aadhaarBackPath;
  const UploadDocumentEvent({
    required this.panCardPath,
    required this.aadhaarFrontPath,
    required this.aadhaarBackPath,
  });

  @override
  List<Object?> get props => [panCardPath, aadhaarFrontPath, aadhaarBackPath];
}

class AddVehicleEvent extends AuthEvent {
  final String vehicleNumber;
  const AddVehicleEvent(this.vehicleNumber);

  @override
  List<Object?> get props => [vehicleNumber];
}

class FetchPnLEvent extends AuthEvent {
  final String period;
  const FetchPnLEvent(this.period);

  @override
  List<Object?> get props => [period];
}

class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}
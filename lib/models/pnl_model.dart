import 'package:hive/hive.dart';
part 'pnl_model.g.dart';


// Vehicle model
@HiveType(typeId: 1)
class Vehicle {
  @HiveField(0)
  final String vehicleNumber;

  @HiveField(1)
  final String vehicleUuid;

  @HiveField(2)
  final double earning;

  @HiveField(3)
  final double costing;

  @HiveField(4)
  final String? driverName; 

  @HiveField(5)
  final String? driverUuid; 

  @HiveField(6)
  final double profitLoss;

  @HiveField(7)
  final String vehicleStatus;

  @HiveField(8)
  final double distanceKm;

  Vehicle({
    required this.vehicleNumber,
    required this.vehicleUuid,
    required this.earning,
    required this.costing,
    this.driverName,
    this.driverUuid,
    required this.profitLoss,
    required this.vehicleStatus,
    required this.distanceKm,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      vehicleNumber: json['vehicle_number'] ?? '',
      vehicleUuid: json['vehicle_uuid'] ?? '',
      earning: json['earning']?.toDouble() ?? 0.0,
      costing: json['costing']?.toDouble() ?? 0.0,
      driverName: json['driver_name'],
      driverUuid: json['driver_uuid'],
      profitLoss: json['profit/loss']?.toDouble() ?? 0.0,
      vehicleStatus: json['vehicle_status'] ?? 'Unknown',
      distanceKm: json['distance_km']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicle_number': vehicleNumber,
      'vehicle_uuid': vehicleUuid,
      'earning': earning,
      'costing': costing,
      'driver_name': driverName,
      'driver_uuid': driverUuid,
      'profit/loss': profitLoss,
      'vehicle_status': vehicleStatus,
      'distance_km': distanceKm,
    };
  }
}

// Header model
@HiveType(typeId: 2)
class Header {
  @HiveField(0)
  final double profitLoss;

  @HiveField(1)
  final double costing;

  @HiveField(2)
  final double earning;

  @HiveField(3)
  final double variableCost;

  @HiveField(4)
  final int tripsCompleted;

  @HiveField(5)
  final int vehiclesOnRoad;

  @HiveField(6)
  final double totalDistance;

  Header({
    required this.profitLoss,
    required this.costing,
    required this.earning,
    required this.variableCost,
    required this.tripsCompleted,
    required this.vehiclesOnRoad,
    required this.totalDistance,
  });

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(
      profitLoss: json['profit/loss']?.toDouble() ?? 0.0,
      costing: json['costing']?.toDouble() ?? 0.0,
      earning: json['earning']?.toDouble() ?? 0.0,
      variableCost: json['variable_cost']?.toDouble() ?? 0.0,
      tripsCompleted: json['trips_completed'] ?? 0,
      vehiclesOnRoad: json['vehicles_on_road'] ?? 0,
      totalDistance: json['total_distance']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profit/loss': profitLoss,
      'costing': costing,
      'earning': earning,
      'variable_cost': variableCost,
      'trips_completed': tripsCompleted,
      'vehicles_on_road': vehiclesOnRoad,
      'total_distance': totalDistance,
    };
  }
}

// PnLData model
@HiveType(typeId: 3)
class PnLData {
  @HiveField(0)
  final List<Vehicle> vehicles;

  @HiveField(1)
  final Header header;

  PnLData({
    required this.vehicles,
    required this.header,
  });

  factory PnLData.fromJson(Map<String, dynamic> json) {
    return PnLData(
      vehicles: (json['vehicles'] as List<dynamic>?)
              ?.map((v) => Vehicle.fromJson(v as Map<String, dynamic>))
              .toList() ??
          [],
      header: Header.fromJson(json['header'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicles': vehicles.map((v) => v.toJson()).toList(),
      'header': header.toJson(),
    };
  }
}
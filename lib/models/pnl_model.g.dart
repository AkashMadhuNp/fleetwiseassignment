// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pnl_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleAdapter extends TypeAdapter<Vehicle> {
  @override
  final int typeId = 1;

  @override
  Vehicle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vehicle(
      vehicleNumber: fields[0] as String,
      vehicleUuid: fields[1] as String,
      earning: fields[2] as double,
      costing: fields[3] as double,
      driverName: fields[4] as String?,
      driverUuid: fields[5] as String?,
      profitLoss: fields[6] as double,
      vehicleStatus: fields[7] as String,
      distanceKm: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Vehicle obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.vehicleNumber)
      ..writeByte(1)
      ..write(obj.vehicleUuid)
      ..writeByte(2)
      ..write(obj.earning)
      ..writeByte(3)
      ..write(obj.costing)
      ..writeByte(4)
      ..write(obj.driverName)
      ..writeByte(5)
      ..write(obj.driverUuid)
      ..writeByte(6)
      ..write(obj.profitLoss)
      ..writeByte(7)
      ..write(obj.vehicleStatus)
      ..writeByte(8)
      ..write(obj.distanceKm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HeaderAdapter extends TypeAdapter<Header> {
  @override
  final int typeId = 2;

  @override
  Header read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Header(
      profitLoss: fields[0] as double,
      costing: fields[1] as double,
      earning: fields[2] as double,
      variableCost: fields[3] as double,
      tripsCompleted: fields[4] as int,
      vehiclesOnRoad: fields[5] as int,
      totalDistance: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Header obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.profitLoss)
      ..writeByte(1)
      ..write(obj.costing)
      ..writeByte(2)
      ..write(obj.earning)
      ..writeByte(3)
      ..write(obj.variableCost)
      ..writeByte(4)
      ..write(obj.tripsCompleted)
      ..writeByte(5)
      ..write(obj.vehiclesOnRoad)
      ..writeByte(6)
      ..write(obj.totalDistance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeaderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PnLDataAdapter extends TypeAdapter<PnLData> {
  @override
  final int typeId = 3;

  @override
  PnLData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PnLData(
      vehicles: (fields[0] as List).cast<Vehicle>(),
      header: fields[1] as Header,
    );
  }

  @override
  void write(BinaryWriter writer, PnLData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.vehicles)
      ..writeByte(1)
      ..write(obj.header);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PnLDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

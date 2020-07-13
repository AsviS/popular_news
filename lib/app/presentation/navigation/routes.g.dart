// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RootRouteAdapter extends TypeAdapter<RootRoute> {
  @override
  final typeId = 219;

  @override
  RootRoute read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RootRoute();
  }

  @override
  void write(BinaryWriter writer, RootRoute obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RootRouteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

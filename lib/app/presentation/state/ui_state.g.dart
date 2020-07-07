// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UIStateAdapter extends TypeAdapter<UIState> {
  @override
  final typeId = 219;

  @override
  UIState read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UIState()
      ..appNavigation = fields[0] as Navigation
      ..tabNavigation = fields[1] as TabNavigation;
  }

  @override
  void write(BinaryWriter writer, UIState obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.appNavigation)
      ..writeByte(1)
      ..write(obj.tabNavigation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UIStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

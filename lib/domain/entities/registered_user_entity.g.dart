// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registered_user_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisteredUserEntityAdapter extends TypeAdapter<RegisteredUserEntity> {
  @override
  final int typeId = 0;

  @override
  RegisteredUserEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisteredUserEntity(
      name: fields[0] as String,
      id: fields[1] as String,
      atype: fields[2] as String,
      gender: fields[3] as String,
      dob: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RegisteredUserEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.atype)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.dob);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisteredUserEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

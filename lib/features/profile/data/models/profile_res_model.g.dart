// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_res_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileResModelAdapter extends TypeAdapter<ProfileResModel> {
  @override
  final int typeId = 1;

  @override
  ProfileResModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileResModel(
      email: fields[0] as String?,
      firstName: fields[1] as String?,
      lastName: fields[2] as String?,
      avatar: fields[3] as String?,
      bio: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileResModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.avatar)
      ..writeByte(4)
      ..write(obj.bio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileResModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

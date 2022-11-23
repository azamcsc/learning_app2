// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailsModelAdapter extends TypeAdapter<DetailsModel> {
  @override
  final int typeId = 7;

  @override
  DetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailsModel(
      topic: fields[0] as int?,
      title: fields[1] as String?,
      content: (fields[2] as List?)?.cast<Content>(),
      status: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, DetailsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.topic)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContentAdapter extends TypeAdapter<Content> {
  @override
  final int typeId = 8;

  @override
  Content read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Content(
      title: fields[0] as String?,
      description: (fields[1] as List?)?.cast<Description>(),
    );
  }

  @override
  void write(BinaryWriter writer, Content obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DescriptionAdapter extends TypeAdapter<Description> {
  @override
  final int typeId = 9;

  @override
  Description read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Description(
      desc: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Description obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.desc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DescriptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_topic_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubTopicModelAdapter extends TypeAdapter<SubTopicModel> {
  @override
  final int typeId = 4;

  @override
  SubTopicModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubTopicModel(
      topic: fields[0] as int?,
      title: fields[1] as String?,
      overview: fields[2] as String?,
      lessons: (fields[3] as List?)?.cast<Lessons>(),
      assessment: (fields[4] as List?)?.cast<Assessment>(),
    );
  }

  @override
  void write(BinaryWriter writer, SubTopicModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.topic)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.lessons)
      ..writeByte(4)
      ..write(obj.assessment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubTopicModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LessonsAdapter extends TypeAdapter<Lessons> {
  @override
  final int typeId = 5;

  @override
  Lessons read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lessons(
      title: fields[0] as String?,
      time: fields[1] as String?,
      image: fields[2] as String?,
      code: fields[3] as String?,
      status: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Lessons obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AssessmentAdapter extends TypeAdapter<Assessment> {
  @override
  final int typeId = 6;

  @override
  Assessment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Assessment(
      title: fields[0] as String?,
      time: fields[1] as String?,
      image: fields[2] as String?,
      code: fields[3] as String?,
      status: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Assessment obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssessmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

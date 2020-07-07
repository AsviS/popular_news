// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_usecase.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsScopeAdapter extends TypeAdapter<NewsScope> {
  @override
  final typeId = 1;

  @override
  NewsScope read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsScope(
      PropertyNotifier(List.from(fields[0].value)),
    );
  }

  @override
  void write(BinaryWriter writer, NewsScope obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj._news);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsScopeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NewsArticleAdapter extends TypeAdapter<NewsArticle> {
  @override
  final typeId = 2;

  @override
  NewsArticle read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsArticle(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      PropertyNotifier(fields[7].value),
    );
  }

  @override
  void write(BinaryWriter writer, NewsArticle obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.source)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.urlToImage)
      ..writeByte(6)
      ..write(obj.publishedAt)
      ..writeByte(7)
      ..write(obj._isSaved);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsArticleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

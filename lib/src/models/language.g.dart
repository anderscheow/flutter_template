// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
      json['id'] as int,
      json['name'] as String,
      json['languageCode'] as String,
      json['scriptCode'] as String?,
    );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'languageCode': instance.languageCode,
      'scriptCode': instance.scriptCode,
    };

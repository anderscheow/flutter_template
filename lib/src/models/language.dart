import 'package:equatable/equatable.dart';
import 'package:flutter_template/src/constant/language.dart';
import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable()
class Language extends Equatable {
  final int id;
  final String name;
  final String languageCode;
  final String? scriptCode;

  const Language(this.id, this.name, this.languageCode, this.scriptCode);

  @override
  @JsonKey(ignore: true)
  List<Object?> get props => [id, name, languageCode, scriptCode];

  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  static Language get fallbackLanguage {
    return const Language(1, 'English', english, null);
  }

  static List<Language> get languageList {
    return const <Language>[
      Language(1, 'English', english, null),
      Language(2, '简体字', chinese, simplified),
      Language(3, '繁體字', chinese, traditional),
    ];
  }
}

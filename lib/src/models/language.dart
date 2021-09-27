import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/src/constants/language.dart';

@jsonSerializable
class Language extends Equatable {
  final int id;
  final String name;
  final String languageCode;
  final String? scriptCode;

  const Language(this.id, this.name, this.languageCode, this.scriptCode);

  @override
  @JsonProperty(ignore: true)
  List<Object?> get props => [id, name, languageCode, scriptCode];

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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/src/bloc/settings/settings_bloc.dart';
import 'package:flutter_template/src/models/language.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
              underline: const SizedBox(),
              icon: const Icon(
                Icons.language,
                color: Colors.white,
              ),
              onChanged: (Language? language) {
                if (language != null) {
                  _changeLanguage(context, language);
                }
              },
              items: Language.languageList
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: e.name.text.make(),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      body: Center(
        child: AppLocalizations.of(context)!
            .helloWorld
            .text
            .medium
            .headline1(context)
            .make(),
      ),
    );
  }

  void _changeLanguage(BuildContext context, Language language) async {
    context.read<SettingsBloc>().add(ChangeLanguage(language));
  }
}

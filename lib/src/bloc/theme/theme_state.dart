part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({
    required this.themeMode,
  });

  const ThemeState.system() : this(themeMode: ThemeMode.system);

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}

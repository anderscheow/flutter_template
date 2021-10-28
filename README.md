# Flutter Template

## Folder Structure

### Assets folder
- images
    - 3.0x
    - 2.0x
- fonts

### Lib folder
- api
    > Consists of base API config, request and response models.
- bloc
    > Separate business logic from presentation layer
- constant
    > Consists of constant value or enum
- di
    > Consists of dependency injection configuration
- localization
    > Keep track different language files
- models
    > Data uses to communicate internally or externally
- repositories
    > Data layer between local storage and network calls
- route
    > Helper class for routing
- screens
    > Presentation layer
- styles
    > Consists of styling of the application
- utils
    > Utility or helper class

&nbsp;

## How to use this template?
### Create new repository
1. Create a new folder under `repository` folder.
2. Create new repo class, refer to `auth_repository.dart`.
3. Instantiate the new repo class in `app.dart`, refer how `AuthRepository` is instantiated.

### Create new bloc
1. Create a new folder under `bloc` folder.
2. Create necessary files for example, `xxx_bloc.dart`, `xxx_event.dart` and `xxx_state.dart`
3. Instantiate the new bloc class in `app.dart`, pass repo class into the bloc class if necessarily, refer how `AuthBloc` is instantiated.

### Navigate to new screen
1. Open `route.dart` under `route` folder.
2. Add a new constant path for the new screen.
3. Define a new route for the new screen.

### Overriding existing theme
1. Open `theme.dart` under `styles` folder.
2. Add your desire styling for `light` and `dark` theme.

### Add new language
1. Copy any of the files under `localization` and rename it to `app_[language_code].arb`.
2. Change the value of the key-value pair to match the localization.
3. Add new supported locale to file `language.dart` under `constants` folder.
4. Add new language to language list in file `language.dart` under `models` folder.
5. Run `flutter gen-l10n` to generate files for localization.

&nbsp;

## Why BLoC instead of Clean?
1. BLoC already built in observer pattern to observe for state or data change.
2. Using dependency injection, repository can be injected into bloc and use directyly. No use case pattern is needed.
3. In the presentation layer, use `BlocBuilder` on necessary widgets to listen for state or data change. Use `BlocListener` if action needs to be taken when state or data change.

&nbsp;

## When to regenerate .g.dart file?
Whenever changes on files or adding new file with `@JsonSerializable` annotation, do run `flutter pub run build_runner build` to generate `.g.dart` files.
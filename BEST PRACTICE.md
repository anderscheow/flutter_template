# Coding Best Practices

## Naming Convention
Classes, enums, typedefs, and extensions name should in `UpperCamelCase`.

```Dart
class MainScreen { ... }
enum MainItem { .. }
typedef Predicate<T> = bool Function(T value);
extension MyList<T> on List<T> { ... }
```

Libraries, packages, directories, and source files name should be in `snake_case(lowercase_with_underscores)`.

```Dart
library firebase_dynamic_links;
import 'socket/socket_manager.dart';
```

Variables, constants, parameters, and named parameters should be in lowerCamelCase.

```Dart
var itemName;
const bookPrice = 3.14;
final urlScheme = RegExp('^([a-z]+):');
void sumOfBookPrice(int bookPrice) {
  // ...
}
```

&nbsp;

## Use relative import (Recommended if within same package)

```Dart
// Don't
import 'package:demo/src/utils/dialog_utils.dart';


// Do
import 'utils/dialog_utils.dart';
```

&nbsp;

## Specify types for class member
Avoid `var` whenever possible.

```Dart
// Don't
var item = 10;
final car = Car();
const timeOut = 2000;


// Do
int item = 10;
final Car bar = Car();
String name = 'john';
const int timeOut = 20;

```

&nbsp;

## Always use `{ }`

```Dart 
// Don't
if (isCompleted) 
    doSomething();

// Do
if (isCompleted) {
    doSomething();
}
```

&nbsp;

## Always add `,` to end of parameter if more than 1 parameter
Adding `,` to last parameter will allow IDE to format the code properly

```Dart
String formatName({String firstName, String lastName}) {
    return '$firstName $lastName';
}

// Don't
void main() {
    String name = formatName(firstName: 'James', lastName: 'Bond');
}

// Do
void main() {
    String name = formatName(
        firstName: 'James', 
        lastName: 'Bond',
    );
}
```

&nbsp;

## Null Safety
Always make field nullable if it may be null in future.

```Dart 
String? name = null;

// Error
String name = null;
```

If field won't be nullable and want to initalise later. Use `late` keyword.

```Dart
late String name;

void init() {
    name = 'abc';
    print(name); // abc

    // Error
    name = null;
}
```

Use `??` or `?.` operator

```Dart
String? name = 'abc';
print(name?.length); // 3

// Error
print(name.length);


// Usage of ?? is to provide a fallback value
int? digit = null;
print(digit ?? -1); // -1
```

&nbsp;

## Avoid using `as` instead, use `is` operator
Avoid `as` unless the data type is known and certain.

```Dart
// Don't
(item as Animal).name = 'Lion';


// Do
if (item is Animal) {
    item.name = 'Lion';
}
```

&nbsp;

## Use spread collections

```Dart
// Don't
var y = [4, 5, 6];
var x = [1, 2];
x.addAll(y);
print(x); // [1, 2, 4, 5, 6]


// Do
var y = [4, 5, 6];
var x = [1, 2, ...y];
print(x); // [1, 2, 4, 5, 6]
```

&nbsp;

## Use Cascades Operator

```Dart
// Don't
var path = Path();
path.lineTo(0, size.height);
path.lineTo(size.width, size.height);
path.lineTo(size.width, 0);
path.close();  


// Do
var path = Path()
..lineTo(0, size.height)
..lineTo(size.width, size.height)
..lineTo(size.width, 0)
..close(); 
```

&nbsp;

## Use raw string

```Dart
// Don't
var s = 'This is demo string \\ and \$';


// Do
var s = r'This is demo string \ and $';
```

&nbsp;

## Use interpolation to compose strings

```Dart
// Don’t
var description = 'Hello, ' + name + '! You are ' + (year - birth).toString() + ' years old.';


// Do
var description = 'Hello, $name! You are ${year - birth} years old.';
```

&nbsp;

## Don’t create a lambda when a tear-off will do

```Dart
List<int> numbers = [1, 2, 3];

// Don’t
numbers.forEach((number) {
  print(number);
});


// Do
numbers.forEach(print);
```

&nbsp;

## Use async/await overusing futures callback

```Dart
Future<int> countActiveUser() {
  return getActiveUser().then((users) {
    return users?.length ?? 0;
  }).catchError((e) {
    log.error(e);
    return 0;
  });
}


// Do
Future<int> countActiveUser() async {
  try {
    var users = await getActiveUser();
     
    return users?.length ?? 0;
  } catch (e) {
    log.error(e);
    return 0;
  }
}
```

&nbsp;

## Split widgets into sub Widgets.

When `setState()` is called on a State, all descendent widgets will rebuild. Therefore, split the widget into small widgets so the `setState()` call to the part of the subtree whose UI actually needs to change.

```Dart
Scaffold(
  appBar: CustomAppBar(title: "Verify Code"), // Sub Widget
  body: Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TimerView( // Sub Widget
            key: _timerKey,
            resendClick: () {})
      ],
    ),
  ),
)
```

&nbsp;

## Use ListView.builder for a long list

When working with infinite lists or very large lists, it’s usually advisable to use a `ListView` builder in order to improve performance.

Default `ListView` constructor builds the whole list at once. `ListView.builder` creates a lazy list and when the user is scrolling down the list, Flutter builds widgets on-demand.

&nbsp;

## Use Const in Widgets

The widget will not change when `setState()` call we should define it as constant. It will prevent the widget to rebuild so it improves performance.

```Dart
Container(
    padding: const EdgeInsets.only(top: 10),
    color: Colors.black,
    child: const Center(
        child: const Text(
            "No Data found",
            style: const TextStyle(fontSize: 30),
        ),
    ),
);
```
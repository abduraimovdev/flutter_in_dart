typedef Key = int;

void runApp(Widget app) {
  Navigator navigator = Navigator(page: [app]);
  BuildContext context = BuildContext()..addInteritedObject(navigator);
  
  while (navigator.page.isNotEmpty) {
    navigator.page.last.build(context);
  }
}

abstract class Widget {
  final Key? key;

  const Widget({this.key});

  void build(BuildContext context);
}

class BuildContext {
  static Map<Type, InteritedObject> _inheriteds = {};

  T? findAncestorObjectOfExactType<T>() {
    if (_inheriteds.containsKey(T)) return _inheriteds[T] as T;
    return null;
  }

  void addInteritedObject(InteritedObject inherit) {
    _inheriteds[inherit.runtimeType] = inherit;
  }
}

class InteritedObject {}

class Navigator extends InteritedObject {
  List<Widget> page;

  Navigator({this.page = const <Widget>[]});

  static Navigator? of(BuildContext context) {
    return context.findAncestorObjectOfExactType<Navigator>();
  }

  void push(Widget widget) {
    page.add(widget);
  }

  void pop() {
    page.removeLast();
  }

  bool canPop() => page.length > 1;

  bool maybePop() {
    if (canPop()) {
      pop();
      return true;
    }

    return false;
  }
}
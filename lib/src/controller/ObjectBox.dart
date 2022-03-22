import 'package:pontuador/objectbox.g.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  static late ObjectBox _instance;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    _instance = ObjectBox._create(store);
    return _instance;
  }

  factory ObjectBox() {
    return _instance;
  }
}
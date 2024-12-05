import 'package:flutter/foundation.dart';

class Utils with ChangeNotifier {

  MyNotifier() {
    _fetchSomething();
  }

  Future<void> _fetchSomething() async {}
}
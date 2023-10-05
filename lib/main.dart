import 'package:flutter/material.dart';

import 'package:cifo_flutter/core/di/injection_container.dart';
import 'package:cifo_flutter/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final injectionContainerImpl = InjectionContainerImpl();
  await injectionContainerImpl.init();

  runApp(AppState(injectionContainerImpl: injectionContainerImpl));
}

import 'package:get_it/get_it.dart';
import 'package:lco_workout/get_it/animation_getit.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<AnimationGetIt>(AnimationGetIt());
}

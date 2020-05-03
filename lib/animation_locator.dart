import 'package:get_it/get_it.dart';
import 'package:lco_workout/get_it/animation_getit.dart';
import './get_it/drawer_getit.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<AnimationGetIt>(() => AnimationGetIt());
  locator.registerLazySingleton<DrawerGetIt>(() => DrawerGetIt());
}

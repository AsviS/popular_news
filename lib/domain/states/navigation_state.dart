import 'package:hive/hive.dart';
import 'package:osam/osam.dart';

part 'navigation_state.g.dart';

@HiveType(typeId: 2)
// ignore: must_be_immutable
class NavigationState extends BaseState<NavigationState> {
  @HiveField(0)
  int navigationIndex = 0;

  @override
  List<Object> get props => [navigationIndex];
}

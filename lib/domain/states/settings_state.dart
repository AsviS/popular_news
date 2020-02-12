import 'package:hive/hive.dart';
import 'package:osam/domain/state/base_state.dart';

part 'settings_state.g.dart';

@HiveType(typeId: 3)
// ignore: must_be_immutable
class SettingsState extends BaseState<SettingsState> {
  @HiveField(0)
  // want be set but hive gen bug ! <>,..,<>
  var themes = <String>[];

  void addTheme(String theme) => themes.add(theme);
  void removeTheme(String theme) => themes.remove(theme);
  void clearThemes() => themes.clear();
  void changeColor(int color) => this.color = color;

  @HiveField(1)
  var color = 0xFF005BFF;

  @override
  List<Object> get props => [themes, color];
}

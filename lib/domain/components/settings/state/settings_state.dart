import 'package:hive/hive.dart';
import 'package:osam/domain/state/base_state.dart';

part 'settings_state.g.dart';

@HiveType()
// ignore: must_be_immutable
class SettingsState extends BaseState<SettingsState> {
  @HiveField(0)
  var themes = <String>[];

  @HiveField(1)
  var color = 0xFF005BFF;

  void addTheme(String theme) => this.themes.add(theme);
  void removeTheme(String theme) => this.themes.remove(theme);
  void changeColor(int color) => this.color = color;
  void clearThemes() => themes.clear();

  @override
  List<Object> get props => [themes, color];
}

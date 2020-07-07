abstract class Hosts {
  const factory Hosts() = _Hosts;

  String get main;

  String get top;
}

class _Hosts implements Hosts {
  const _Hosts();

  @override
  String get main => 'https://newsapi.org/v2/';

  @override
  String get top => '$main/top-headlines?';
}

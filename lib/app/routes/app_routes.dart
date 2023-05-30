part of './app_pages.dart';

abstract class Routes {
  static const initial = _Paths.initial;
  static const login = _Paths.login;
  static const main = _Paths.main;

  static const profile = _Paths.main + _Paths.profile;
  static const campaign = _Paths.main + _Paths.campaign;
  static const keyword = _Paths.main + _Paths.keyword;
  static const first = _Paths.main + _Paths.first;
  static const second = _Paths.main + _Paths.second;

  Routes._();
}

abstract class _Paths {
  static const initial = '/';
  static const main = '/main';
  static const login = '/login';
  static const profile = '/profile';
  static const campaign = '/campaign';
  static const keyword = '/ad-keyword';
  static const first = '/first';
  static const second = '/second';
}

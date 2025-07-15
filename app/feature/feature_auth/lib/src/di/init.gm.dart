// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:feature_auth/src/code/code_page.dart' as _i1;
import 'package:feature_auth/src/password/password_page.dart' as _i2;
import 'package:feature_auth/src/phone_number/phone_number_page.dart' as _i3;
import 'package:feature_auth/src/register/register_page.dart' as _i4;
import 'package:feature_auth/src/verfy_code/verify_code_screen.dart' as _i5;

abstract class $FeatureAuthModule extends _i6.AutoRouterModule {
  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    CodeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CodePage(),
      );
    },
    PasswordRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.PasswordPage(),
      );
    },
    PhoneNumberRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.WrappedRoute(child: const _i3.PhoneNumberPage()),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.RegisterPage(),
      );
    },
    VerifyCodeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.VerifyCodeScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.CodePage]
class CodeRoute extends _i6.PageRouteInfo<void> {
  const CodeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          CodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CodeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PasswordPage]
class PasswordRoute extends _i6.PageRouteInfo<void> {
  const PasswordRoute({List<_i6.PageRouteInfo>? children})
      : super(
          PasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'PasswordRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PhoneNumberPage]
class PhoneNumberRoute extends _i6.PageRouteInfo<void> {
  const PhoneNumberRoute({List<_i6.PageRouteInfo>? children})
      : super(
          PhoneNumberRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhoneNumberRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterRoute extends _i6.PageRouteInfo<void> {
  const RegisterRoute({List<_i6.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.VerifyCodeScreen]
class VerifyCodeRoute extends _i6.PageRouteInfo<void> {
  const VerifyCodeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          VerifyCodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerifyCodeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

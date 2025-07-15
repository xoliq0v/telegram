part of 'td_config_cubit.dart';

@freezed
sealed class ConfigState with _$ConfigState {

  const factory ConfigState.init() = _Init;

  const factory ConfigState.loading() = _Loading;

  const factory ConfigState.success() = _Success;

  const factory ConfigState.error(String message) = _Error;

}
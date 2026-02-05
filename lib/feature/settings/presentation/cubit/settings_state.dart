part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsNeedDoctorForm extends SettingsState {}

class SettingsOpenDoctorHome extends SettingsState {}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);
}

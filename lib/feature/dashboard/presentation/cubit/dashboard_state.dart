part of 'dashboard_cubit.dart';

enum DashboardActionType { accept, reject }

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

/// Loading for a specific appointment doc (so only its buttons disable)
class DashboardActionLoading extends DashboardState {
  final String appointmentPath;
  final DashboardActionType actionType;

  DashboardActionLoading({
    required this.appointmentPath,
    required this.actionType,
  });
}

class DashboardActionSuccess extends DashboardState {
  final String appointmentPath;
  final String status; // accepted / rejected
  DashboardActionSuccess(this.appointmentPath, this.status);
}

class DashboardActionFailure extends DashboardState {
  final String appointmentPath;
  final String error;
  DashboardActionFailure(this.appointmentPath, this.error);
}

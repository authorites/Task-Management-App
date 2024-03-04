part of 'passcode_cubit.dart';

class PasscodeState extends Equatable {
  const PasscodeState({
    this.checkPasscodeStatus = ApiStatusType.initial,
    this.passcode = '',
    this.error,
  });

  PasscodeState copyWith({
    ApiStatusType? checkPasscodeStatus,
    String? passcode,
    Exception? Function()? error,
  }) {
    return PasscodeState(
      checkPasscodeStatus: checkPasscodeStatus ?? this.checkPasscodeStatus,
      passcode: passcode ?? this.passcode,
      error: error != null ? error() : this.error,
    );
  }

  final ApiStatusType checkPasscodeStatus;
  final String passcode;
  final Exception? error;

  @override
  List<Object?> get props => [
        checkPasscodeStatus,
        passcode,
        error,
      ];
}

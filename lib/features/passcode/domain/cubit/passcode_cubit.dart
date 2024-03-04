import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manage_management/core/error/exceptions.dart';
import 'package:task_manage_management/core/network/api_status_type.dart';
import 'package:task_manage_management/features/passcode/data/repositories/passcode_repository.dart';

part 'passcode_state.dart';

class PasscodeCubit extends Cubit<PasscodeState> {
  PasscodeCubit({required this.repository}) : super(const PasscodeState());

  final PasscodeRepository repository;

  Future<void> enterDigit(String digit) async {
    if (state.passcode.length == 6) return;
    if (state.passcode.length > 6) return;
    emit(state.copyWith(passcode: state.passcode + digit));
    if (state.passcode.length == 6) return _checkPasscode();
  }

  void deleteDigit() {
    if (state.passcode.isEmpty) return;
    emit(
      state.copyWith(
        passcode: state.passcode.substring(0, state.passcode.length - 1),
        error: () => null,
      ),
    );
  }

  Future<void> _checkPasscode() async {
    if (state.passcode.length != 6) return;
    emit(state.copyWith(checkPasscodeStatus: ApiStatusType.loading));
    try {
      final isCorrect = await repository.checkPasscode(state.passcode);
      if (!isCorrect) throw Exception('Passcode is incorrect');
      emit(
        state.copyWith(
          checkPasscodeStatus: ApiStatusType.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          checkPasscodeStatus: ApiStatusType.error,
          error: () => e is Exception ? e : UnknownException(),
        ),
      );
    }
  }
}

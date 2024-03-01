import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'passcode_lock_state.dart';

class PasscodeLockCubit extends Cubit<PasscodeLockState> {
  PasscodeLockCubit() : super(PasscodeLockInitial());
}

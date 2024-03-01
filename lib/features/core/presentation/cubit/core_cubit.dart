import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'core_state.dart';

class CoreCubit extends Cubit<CoreState> {
  CoreCubit() : super(CoreInitial());
}

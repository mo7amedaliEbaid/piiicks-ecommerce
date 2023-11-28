// share_state.dart

part of 'share_cubit.dart';

abstract class ShareState extends Equatable {
  const ShareState();

  @override
  List<Object> get props => [];
}

class ShareInitialState extends ShareState {}

class ShareLoadingState extends ShareState {}

class ShareSuccessState extends ShareState {}

class ShareErrorState extends ShareState {
  final String errorMessage;

  ShareErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

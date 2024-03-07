part of 'prompt_bloc.dart';

@immutable
abstract class PromptState {}

class PromptInitial extends PromptState {}

final class PromptGeneratingImageLoadState extends PromptState {}

final class PromptGeneratingImageErrorState extends PromptState {}

final class PromptGeneratingImageSuccessState extends PromptState {
  final Uint8List uint8list;

  PromptGeneratingImageSuccessState(this.uint8list);

}



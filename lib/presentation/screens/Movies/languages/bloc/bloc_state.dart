import 'package:equatable/equatable.dart';
import 'package:onlinebooking_adminside/data/repository/movie_database_repository.dart';

abstract class LanguagesState extends Equatable {
  const LanguagesState();

  @override
  List<Object> get props => [];
}

class LanguagesInitialstate extends LanguagesState {
  const LanguagesInitialstate();
}

class LanguagesAddingstate extends LanguagesState {
  const LanguagesAddingstate();
}

class LanguagesAddedsuccsessState extends LanguagesState {
  final String language;
  const LanguagesAddedsuccsessState({required this.language});
  @override
  List<Object> get props => [language];
}

class LanguagesAddedFailureState extends LanguagesState {
  final String error;
  const LanguagesAddedFailureState(this.error);
  @override
  List<Object> get props => [error];
}

class LanguageLoadingState extends LanguagesState {
  const LanguageLoadingState();
}

class LanguageLoadedState extends LanguagesState {
  final List<Language> languages;
  const LanguageLoadedState(this.languages);
  @override
  List<Object> get props => [languages];
}

class LanguageLoadingFailureState extends LanguagesState {
  final String error;
  const LanguageLoadingFailureState(this.error);
  @override
  List<Object> get props => [error];
}

class LanguageEditedSuccessState extends LanguagesState {
  final String message;
  const LanguageEditedSuccessState(this.message);
  @override
  List<Object> get props => [message];
}

class DeleteLanguageSuccessState extends LanguagesState {
  const DeleteLanguageSuccessState();
  @override
  List<Object> get props => [];
}

class DeleteLanguageErrorState extends LanguagesState {
  final String error;
  const DeleteLanguageErrorState(this.error);
  @override
  List<Object> get props => [];
}

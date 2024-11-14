import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/repository/movie_database_repository.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/languages/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/languages/bloc/bloc_state.dart';

class LanguagesBloc extends Bloc<LanguagesEvent, LanguagesState> {
  LanguagesBloc() : super(const LanguagesInitialstate()) {
    on<AddinglanguageEvent>(addlanguage);
    on<FetchLanguagesEvent>(fetchLanguages);
    on<EditlanguageEvent>(editlanguage);
    on<DeleteingLanguageEvent>(deleteLanguage);
  }

  Future<void> addlanguage(
      AddinglanguageEvent event, Emitter<LanguagesState> emit) async {
    emit(const LanguagesAddingstate());
    try {
      await MovieDatabaserepository().addLanguage(event.language);
      emit(LanguagesAddedsuccsessState(language: event.language));
    } catch (e) {
      emit(LanguagesAddedFailureState('Error : $e'));
    }
  }

  Future<void> editlanguage(
      EditlanguageEvent event, Emitter<LanguagesState> emit) async {
    emit(const LanguagesAddingstate());
    try {
      await MovieDatabaserepository().editLanguage(event.id, event.language);
      emit(LanguagesAddedsuccsessState(language: event.language));
    } catch (e) {
      emit(LanguagesAddedFailureState('Error : $e'));
    }
  }

  Future<void> fetchLanguages(
      FetchLanguagesEvent event, Emitter<LanguagesState> emit) async {
    emit(const LanguageLoadingState());
    try {
      final languages = await MovieDatabaserepository().fetchLanguages();
      emit(LanguageLoadedState(languages));
    } catch (e) {
      emit(LanguageLoadingFailureState('Error : $e'));
    }
  }

  Future<void> deleteLanguage(
      DeleteingLanguageEvent event, Emitter<LanguagesState> emit) async {
    emit(const LanguagesAddingstate());
    try {
      await MovieDatabaserepository().deleteLanguage(event.id);
      emit(const DeleteLanguageSuccessState());
    } catch (e) {
      emit(DeleteLanguageErrorState('error : $e'));
    }
  }
}

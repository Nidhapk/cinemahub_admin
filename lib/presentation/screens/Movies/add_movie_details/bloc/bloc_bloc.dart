import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/modals/caste_model.dart';
import 'package:onlinebooking_adminside/data/repository/movie_database_repository.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/add_movie_details/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/add_movie_details/bloc/bloc_state.dart';

class AddDetailsBloc extends Bloc<AddDetailsEvent, AddDetailsState> {
  List<CastMember> castMembers = [];
  AddDetailsBloc() : super(AddDetailsInitial()) {
    on<DropdownItemSelected>(dropdownSelected);
    on<MultipleDropdownItemSelected>(multipleDropdownSelected);
    on<AddCastMemberEvent>(aaddedCasteMember);
    on<ClearCastMembersEvent>(castmembersclear);
    on<AddMovieEvent>(addMovie);
  }

  void dropdownSelected(AddDetailsEvent event, Emitter<AddDetailsState> emit) {
    if (event is DropdownItemSelected) {
      emit(
        DropdownItemSelectedState(event.selectedItem),
      );
    }
  }

  void multipleDropdownSelected(
      MultipleDropdownItemSelected event, Emitter<AddDetailsState> emit) {
    emit(
      MultipleItemsSelectedState(
        selectedLanguages: event.selectedLanguages ?? [],
        selectedGenres: event.selectedGenres ?? [],
      ),
    );
  }

  void aaddedCasteMember(
      AddCastMemberEvent event, Emitter<AddDetailsState> emit) {
    castMembers.add(
      CastMember(name: event.name, imagePath: event.imagePath),
    );
    emit(
      CastMembersUpdatedState(castMembers: List.from(castMembers)),
    );
  }

  void castmembersclear(
      ClearCastMembersEvent event, Emitter<AddDetailsState> emit) {
    try {
      log('caste clear');
      emit( CastMembersUpdatedState(castMembers: castMembers=[]));
    } catch (_) {}
  }

  void addMovie(AddMovieEvent event, Emitter<AddDetailsState> emit) async {
    emit(AddMovieLoadingState());
    try {
      await MovieDatabaserepository().addMovieDetails(event.movie);
      emit(const AddMovieSuccessState());
    } catch (e) {
      emit(AddMovieFailureState('Error :$e'));
    }
  }
}

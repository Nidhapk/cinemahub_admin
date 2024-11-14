import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/modals/caste_model.dart';
import 'package:onlinebooking_adminside/data/repository/movie_database_repository.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/edit_movie/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/edit_movie/bloc/bloc_state.dart'; // Replace with your actual repository path

class EditMovieBloc extends Bloc<EditMovieEvent, EditMovieState> {
  List<CastMember> castMembers = [];
  final MovieDatabaserepository movieRepository;

  EditMovieBloc({required this.movieRepository}) : super(EditMovieInitial()) {
    on<EditMovieButtonPressed>(_onEditMovieButtonPressed);
    on<AddCastMemberEventInEdit>(aaddedCasteMember);
    on<ClearCastMembersEventInEditPage>(castmembersclear);
    on<DeletecastememberinEdit>(deleteCasteMember);
    on<InitializeCastMembersEvent>(initialCastemember);
  }

  Future<void> _onEditMovieButtonPressed(
      EditMovieButtonPressed event, Emitter<EditMovieState> emit) async {
    emit(EditMovieLoading());
    try {
      await movieRepository.updateMovie(
        blocked: event.blocked,
        movieId: event.movieId,
        trailerLink: event.trailerLink,
        movieName: event.movieName,
        certificate: event.certificate,
        languages: event.languages,
        genres: event.genres,
        releaseDate: event.releaseDate,
        duration: event.duration,
        description: event.description,
        castMembers: event.castMembers,
        posterImage: event.posterImage,
        backdropImage: event.backdropImage,
      );
      emit(EditMovieSuccess());
    } catch (error) {
      emit(EditMovieFailure(error.toString()));
    }
  }

  void initialCastemember(
      InitializeCastMembersEvent event, Emitter<EditMovieState> emit) {
    emit(CastMembersUpdatedStateInEditPage(
        castMembers: castMembers = [...event.originalCastMembers]));
  }

  void aaddedCasteMember(
      AddCastMemberEventInEdit event, Emitter<EditMovieState> emit) {
     final updatedCastMembers = List.from(castMembers)
    ..add(CastMember(name: event.name, imagePath: event.imagePath));
    emit(
      CastMembersUpdatedStateInEditPage(castMembers: List.from(updatedCastMembers)),
    );
  }

  void deleteCasteMember(
      DeletecastememberinEdit event, Emitter<EditMovieState> emit) {
    castMembers.removeAt(event.index);
    emit(CastMembersUpdatedStateInEditPage(castMembers: castMembers));
  }

  void castmembersclear(
      ClearCastMembersEventInEditPage event, Emitter<EditMovieState> emit) {
    try {
      emit(const CastMembersUpdatedStateInEditPage(castMembers: []));
    } catch (_) {}
  }

  void dropdownSelected(
      DropdownItemSelectedinEdit event, Emitter<EditMovieState> emit) {
    emit(
      DropdownItemSelectedStateinEdit(event.selectedItem),
    );
  }
}

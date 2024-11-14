
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlinebooking_adminside/data/repository/movie_database_repository.dart';
import 'package:onlinebooking_adminside/presentation/widgets/image_picker/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/widgets/image_picker/bloc/bloc_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePicker _picker = ImagePicker();

  ImagePickerBloc() : super(ImagePickerInitial()) {
     on<ClearImagePickerEvent>((event, emit) {
      emit(ImagePickerInitial());
    });
     on<ClearPosterImageEvent>((event, emit) {
      emit(ImagePickerInitial());
    });
     on<ClearbackdropImageEvent>((event, emit) {
      emit(ImagePickerInitial());
    });
    on<PickImageEvent>(casteImagePicker);
    on<PosterImagePickedEvent>(onPosterImagePickedEvent);
    on<BackdropImagePickedEvent>(onBackdropImagePickedEvent);
  }

  void onPosterImagePickedEvent(
      PosterImagePickedEvent event, Emitter<ImagePickerState> emit) async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
          
      if (pickedFile != null) {
      
        emit(PosterImagePickedState(pickedFile));
      } else {
        emit(ImagePickerInitial());
      }
    } catch (e) {
      emit(ImagePickerInitial());
    }
  }
   void casteImagePicker(
      PickImageEvent event, Emitter<ImagePickerState> emit) async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
          final imageUrl=await MovieDatabaserepository()
                            .uploadPoster(pickedFile.path);
        emit(ImagePickerImagePicked(imageUrl));
      } else {
        emit(ImagePickerInitial());
      }
    } catch (e) {
      emit(ImagePickerInitial());
    }
  }

  void onBackdropImagePickedEvent(
      BackdropImagePickedEvent event, Emitter<ImagePickerState> emit) async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(BackdropImagePickedState(pickedFile));
      } else {
        emit(ImagePickerInitial());
      }
    } catch (e) {
      emit(ImagePickerInitial());
    }
  }
}

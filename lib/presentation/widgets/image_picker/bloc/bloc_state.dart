import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerState extends Equatable {
  const ImagePickerState();

  @override
  List<Object?> get props => [];
}

class ImagePickerInitial extends ImagePickerState {}

class ImagePickerImagePicked extends ImagePickerState {
  final String image;

  const ImagePickerImagePicked(this.image);

  @override
  List<Object?> get props => [image];
}
class PosterImagePickedState extends ImagePickerState {
  final XFile? image;

  const PosterImagePickedState(this.image);

  @override
  List<Object?> get props => [image];
}
class BackdropImagePickedState extends ImagePickerState {
  final XFile? image;

  const BackdropImagePickedState(this.image);

  @override
  List<Object?> get props => [image];
}


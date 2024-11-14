import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';


abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object?> get props => [];
}

class PickImageEvent extends ImagePickerEvent {
  final ImageSource source;

  const PickImageEvent(this.source);

  @override
  List<Object?> get props => [source];
}
class PosterImagePickedEvent extends ImagePickerEvent {
  final ImageSource source;

  const PosterImagePickedEvent(this.source);

  @override
  List<Object?> get props => [source];
}
class BackdropImagePickedEvent extends ImagePickerEvent {
  final ImageSource source;

  const BackdropImagePickedEvent(this.source);

  @override
  List<Object?> get props => [source];
}
class ClearImagePickerEvent extends ImagePickerEvent {}
class ClearPosterImageEvent extends ImagePickerEvent{

}
class ClearbackdropImageEvent extends ImagePickerEvent{
  
}
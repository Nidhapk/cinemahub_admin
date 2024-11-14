import 'package:equatable/equatable.dart';

abstract class LanguagesEvent extends Equatable {
  const LanguagesEvent();
  @override
  List<Object> get props => [];
}

class AddinglanguageEvent extends LanguagesEvent {
  final String language;
  const AddinglanguageEvent(this.language);

  @override
  List<Object> get props => [language];
}

class EditlanguageEvent extends LanguagesEvent {
  final String id;
  final String language;
  const EditlanguageEvent(this.id, this.language);

  @override
  List<Object> get props => [id, language];
}

class DeleteingLanguageEvent extends LanguagesEvent {
  final String id;
  const DeleteingLanguageEvent(this.id);

  @override
  List<Object> get props => [id];
}

class FetchLanguagesEvent extends LanguagesEvent {

const FetchLanguagesEvent();
   @override
  List<Object> get props =>[];

}

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlinebooking_adminside/data/constants/constants.dart';
import 'package:onlinebooking_adminside/data/methods/methods.dart';
import 'package:onlinebooking_adminside/data/modals/caste_model.dart';
import 'package:onlinebooking_adminside/data/modals/movie_model.dart';
import 'package:onlinebooking_adminside/data/repository/movie_database_repository.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/edit_movie/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/edit_movie/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/edit_movie/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_home/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_home/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_textstyles.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/custom_appbar.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/custom_buttom.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/genre_item_sheet/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/genre_item_sheet/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/genre_item_sheet/ui/genre_seelction_sheet.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/language_item_sheet/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/language_item_sheet/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/language_item_sheet/ui/multi_item_bottomsheet.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_snackbar.dart';
import 'package:onlinebooking_adminside/presentation/widgets/image_picker/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/widgets/image_picker/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/widgets/image_picker/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/widgets/image_picker/custom_imagepicker.dart';
import 'package:onlinebooking_adminside/presentation/widgets/movie/add_caste.dart';
import 'package:onlinebooking_adminside/presentation/widgets/movie/add_detail_raw.dart';
import 'package:onlinebooking_adminside/presentation/widgets/movie/add_detailcolum.dart';
import 'package:onlinebooking_adminside/presentation/widgets/movie/caste_button.dart';
import 'package:onlinebooking_adminside/presentation/widgets/movie/castemember_container.dart';
import 'package:onlinebooking_adminside/presentation/widgets/movie/movie_image_container.dart';

class EditMovieScreen extends StatefulWidget {
  final MovieClass movieClass;
  final String movieId;
  const EditMovieScreen(
      {super.key, required this.movieClass, required this.movieId});
  static final GlobalKey<FormState> casteformKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> movieformKey = GlobalKey<FormState>();

  @override
  State<EditMovieScreen> createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  String? pickedImage;
  String? pickedPoster;
  String? pickedBackdrop;
  List<String> selectedLanguages = [];
  List<String> selectedGenres = [];
  TextEditingController dateController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController certificateController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();
  TextEditingController casteNameController = TextEditingController();

  List<CastMember> castMembers = [];

  @override
  void initState() {
    super.initState();
    pickedPoster = widget.movieClass.posterImage;
    pickedBackdrop = widget.movieClass.backdropImage;
    selectedLanguages = widget.movieClass.languages;
    selectedGenres = widget.movieClass.genres;
    dateController.text = widget.movieClass.releaseDate;
    linkController.text = widget.movieClass.trailerLink;
    nameController.text = widget.movieClass.movieName;
    certificateController.text = widget.movieClass.certificate;
    languageController.text = selectedLanguages.join(', ');
    genreController.text = selectedGenres.join(', ');
    durationController.text = widget.movieClass.duration;
    discriptionController.text = widget.movieClass.description;

    //castMembers = [...widget.movieClass.castMembers];
  }

  @override
  Widget build(BuildContext context) {
    //  context
    //     .read<EditMovieBloc>()
    //     .add(InitializeCastMembersEvent(widget.movieClass.castMembers));
    final width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        context.read<ImagePickerBloc>().add(ClearPosterImageEvent());
        context.read<ImagePickerBloc>().add(ClearbackdropImageEvent());
      },
      child: Scaffold(
        backgroundColor: appBackgroundColor,
        appBar: CustomAppBar(
          title: 'edit Movie Details',
          onPressed: () {
            context.read<ImagePickerBloc>().add(ClearPosterImageEvent());
            context.read<ImagePickerBloc>().add(ClearbackdropImageEvent());
            context
                .read<EditMovieBloc>()
                .add(const ClearCastMembersEventInEditPage());
            // castMembers.clear();
            // context.read<DatePickerBloc>().add(ClearDateEvent());
            context.read<MovieBloc>().add(FetchAllMoviesEvent());
            Navigator.of(context).pop();
          },
        ),
        body: SingleChildScrollView(
          child: BlocListener<EditMovieBloc, EditMovieState>(
            listener: (context, state) {
              //  String? selectedValue;
              if (state is EditMovieLoading) {
                const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is EditMovieSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(
                    text: 'Movie details has been successfully updated',
                    icon: Icons.check_circle_outline,
                    iconColor: green,
                    borderColor: green,
                  ),
                );
                context.read<MovieBloc>().add(FetchAllMoviesEvent());
                Navigator.of(context).pop();
              } else if (state is EditMovieFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(
                    text: 'Failed to update movie details,try again later',
                    icon: Icons.error_outline,
                    iconColor: red,
                    borderColor: red,
                  ),
                );
              } else if (state is CastMembersUpdatedStateInEditPage) {
                castMembers = state.castMembers;
              }
            },
            child: Form(
              key: EditMovieScreen.movieformKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddDetailColum(
                    controller: linkController,
                    title: 'Trailer link',
                    hintText: 'Add trailer link here',
                    validator: validateVideoLink,
                  ),
                  AddDetailRaw(
                    controller1: nameController,
                    controller2: certificateController,
                    title1: 'Movie Name',
                    title2: 'Certificate',
                    hintText1: 'Movie name',
                    hintText2: 'Select certificate',
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    onTap: () {
                      _openBottomSheet(context, certificateController);
                    } // showDropdownMenu(context, certificateItems),
                    ,
                    validatorOne: (value) =>
                        validate(value, 'please enter the movie\n name'),
                    validatorTwo: (value) =>
                        validate(value, 'Please select any from\n given list'),
                    readOnly: true,
                  ),
                  BlocListener<MultipleItemSelectionBloc,
                      MultipleItemSelectionState>(
                    listener: (context, state) {
                      if (state is ItemSelectionSubmittedState) {
                        selectedLanguages = state.selectedItems;
                        languageController.text = selectedLanguages.toString();
                        log('selectedlang : $selectedLanguages');
                      }
                    },
                    child: AddDetailColum(
                      controller: languageController,
                      title: 'Languages',
                      hintText: 'select languages',
                      readOnly: true,
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      onTap: () => showlanguageSelectionBottomSheet(
                          context, selectedLanguages),
                    ),
                  ),
                  BlocListener<GenreSelectionBloc, GenreSelectionState>(
                    listener: (context, state) {
                      if (state is GenreSubmittedState) {
                        selectedGenres = state.selectedItems;
                        genreController.text = selectedGenres.toString();
                      }
                    },
                    child: AddDetailColum(
                      controller: genreController,
                      title: 'Genres',
                      hintText: 'Select genres',
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      onTap: () => showGenreSelectionBottomSheet(
                          context, selectedGenres),
                      validator: (value) => validate(
                          value, 'Please select genres from given list'),
                      readOnly: true,
                    ),
                  ),
                  AddDetailRaw(
                    controller1: dateController,
                    controller2: durationController,
                    title1: 'Release Date',
                    title2: 'Duration',
                    hintText1: 'dd/MM/yyyy',
                    hintText2: 'hr : min',
                    validatorOne: (value) => validateDate(value),
                    validatorTwo: (value) => validateDuration(value),
                  ),
                  AddDetailColum(
                    controller: discriptionController,
                    title: 'Discription',
                    hintText: "Add discription here",
                    maxLines: null,
                    validator: (value) => validate(
                        value, 'Please write the discription of the movie'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 20),
                    child: Text(
                      'Caste Members',
                      style: AppTextstyles.textformTitleStyle,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: BlocBuilder<EditMovieBloc, EditMovieState>(
                      builder: (context, state) {
                        if (state is CastMembersUpdatedStateInEditPage) {
                          castMembers =
                              //     //...widget.movieClass.castMembers,
                              state.castMembers;
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 1),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.castMembers.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return CasteButton(
                                  onTap: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return Form(
                                          key: EditMovieScreen.casteformKey,
                                          child: CasteBottomSheet(
                                            controller: casteNameController,
                                            validator: validateName,
                                            imagePicker: BlocBuilder<
                                                ImagePickerBloc,
                                                ImagePickerState>(
                                              builder: (context, state) {
                                                if (state
                                                    is ImagePickerImagePicked) {
                                                  pickedImage = state.image;
                                                }
                                                return CustomImagePicker(
                                                  path: pickedImage ?? '',
                                                  onTap: () async {
                                                    context
                                                        .read<ImagePickerBloc>()
                                                        .add(
                                                          const PickImageEvent(
                                                              ImageSource
                                                                  .gallery),
                                                        );
                                                  },
                                                );
                                              },
                                            ),
                                            addCasteButtonOnPressed: () {
                                              if (EditMovieScreen
                                                  .casteformKey.currentState!
                                                  .validate()) {
                                                context
                                                    .read<EditMovieBloc>()
                                                    .add(
                                                      AddCastMemberEventInEdit(
                                                          name:
                                                              casteNameController
                                                                  .text
                                                                  .trim(),
                                                          imagePath:
                                                              pickedImage ??
                                                                  ''),
                                                    );

                                                Navigator.of(context).pop();
                                              }
                                              casteNameController.clear();
                                              context
                                                  .read<ImagePickerBloc>()
                                                  .add(ClearImagePickerEvent());
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              } else {
                                final castMember = state.castMembers[index - 1];

                                return BlocBuilder<EditMovieBloc,
                                    EditMovieState>(
                                  builder: (context, state) {
                                    return CasteMemberContainer(
                                        onPressed: () {
                                          context.read<EditMovieBloc>().add(
                                              DeletecastememberinEdit(
                                                  index - 1));
                                        },
                                        casteMemberImage: castMember.imagePath,
                                        casteMembername: castMember.name);
                                  },
                                );
                              }
                            },
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  BlocBuilder<ImagePickerBloc, ImagePickerState>(
                    builder: (context, state) {
                      if (state is PosterImagePickedState) {
                        pickedPoster = state.image!.path;
                      } else if (state is BackdropImagePickedState) {
                        pickedBackdrop = state.image!.path;
                      }
                      return MovieImageContainer(
                        posterImageWidth: width * 0.26,
                        backdropImageWidth: width * 0.52,
                        sizedBoxWidth: width * 0.1,
                        posteronTap: () {
                          context.read<ImagePickerBloc>().add(
                                const PosterImagePickedEvent(
                                    ImageSource.gallery),
                              );
                        },
                        posterImage: pickedPoster != null &&
                                !pickedPoster!.startsWith('https')
                            ? DecorationImage(
                                image: FileImage(
                                  File(pickedPoster ?? ''),
                                ),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    widget.movieClass.posterImage)),
                        backdroponTap: () {
                          context.read<ImagePickerBloc>().add(
                                const BackdropImagePickedEvent(
                                    ImageSource.gallery),
                              );
                        },
                        backdropImage: pickedBackdrop != null &&
                                !pickedBackdrop!.startsWith('https')
                            ? DecorationImage(
                                image: FileImage(
                                  File(pickedBackdrop ?? ''),
                                ),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    widget.movieClass.backdropImage)),
                        posterChild: pickedPoster == null
                            ? const Icon(
                                Icons.add,
                                color: Colors.grey,
                              )
                            : null,
                        backdropChild: pickedBackdrop == null
                            ? const Icon(
                                Icons.add,
                                color: Colors.grey,
                              )
                            : null,
                      );
                    },
                  ),
                  CustomButton(onPressed: () async {
                    if (EditMovieScreen.movieformKey.currentState!.validate()) {
                      log('casttt : $castMembers');
                      String poster = '';
                      String backDrop = '';
                      log('poster :$pickedPoster');
                      log('back: $pickedBackdrop');
                      if (!pickedPoster!.startsWith('http')) {
                        poster = await MovieDatabaserepository()
                            .uploadPoster(pickedPoster);
                      }
                      if (!pickedBackdrop!.startsWith('https')) {
                        backDrop = await MovieDatabaserepository()
                            .uploadBackdrp(pickedBackdrop);
                      }

                      context.read<EditMovieBloc>().add(
                            EditMovieButtonPressed(
                                blocked: widget.movieClass.blocked,
                                movieId: widget.movieId,
                                trailerLink: linkController.text.trim(),
                                movieName: nameController.text.trim(),
                                certificate: certificateController.text.trim(),
                                languages: selectedLanguages,
                                genres: selectedGenres,
                                releaseDate: dateController.text.trim(),
                                duration: durationController.text.trim(),
                                description: discriptionController.text.trim(),
                                castMembers: castMembers.isEmpty
                                    ? widget.movieClass.castMembers
                                    : castMembers,
                                posterImage: poster == ''
                                    ? widget.movieClass.posterImage
                                    : poster,
                                backdropImage: backDrop == ''
                                    ? widget.movieClass.backdropImage
                                    : backDrop,
                                review: widget.movieClass.review),
                          );
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _openBottomSheet(BuildContext context, TextEditingController text) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return ListView.builder(
        itemCount: certificateItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(certificateItems[index]),
            onTap: () {
              // Update the TextFormField when an item is selected
              text.text = certificateItems[index];
              Navigator.pop(context); // Close the bottom sheet
            },
          );
        },
      );
    },
  );
}

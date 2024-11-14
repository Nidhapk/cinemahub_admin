import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:onlinebooking_adminside/data/constants/constants.dart';
import 'package:onlinebooking_adminside/data/constants/dropdown.dart';
import 'package:onlinebooking_adminside/data/methods/methods.dart';
import 'package:onlinebooking_adminside/data/modals/caste_model.dart';
import 'package:onlinebooking_adminside/data/modals/movie_model.dart';
import 'package:onlinebooking_adminside/data/repository/movie_database_repository.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/add_movie_details/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/add_movie_details/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/add_movie_details/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_home/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_home/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_textstyles.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/custom_appbar.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/custom_buttom.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/date_picker/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/date_picker/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/date_picker/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/date_picker/bloc/custom_date_picker.dart';
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

class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});
  static final GlobalKey<FormState> casteformKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> movieformKey = GlobalKey<FormState>();

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  DateTime? selectedDate;
  final TextEditingController linkController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final certificateController = TextEditingController();
  final languageController = TextEditingController();
  final genreController = TextEditingController();
  final dateController = TextEditingController();
  final durationController = TextEditingController();
  final discriptionController = TextEditingController();
  final casteNameController = TextEditingController();
  String? pickedImage;
  String? pickedPoster;
  String? pickedBackdrop;
  List<CastMember> castMembers = [];
  List<String> selectedLanguages = [];
  List<String> selectedGenres = [];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: CustomAppBar(
        title: 'Add Movie Details',
        onPressed: () {
          context.read<ImagePickerBloc>().add(ClearPosterImageEvent());
          context.read<ImagePickerBloc>().add(ClearbackdropImageEvent());
          context.read<AddDetailsBloc>().add(const ClearCastMembersEvent());
          context.read<DatePickerBloc>().add(ClearDateEvent());
          castMembers.clear();
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<AddDetailsBloc, AddDetailsState>(
            listener: (context, state) {
          String? selectedValue;
          if (state is DropdownItemSelectedState) {
            selectedValue = state.selectedItem;
            certificateController.text = selectedValue;
          } else if (state is MultipleItemsSelectedState) {
            selectedLanguages = [...state.selectedLanguages];
            selectedGenres = [...state.selectedGenres];
            languageController.text = selectedLanguages.join(', ');
            genreController.text = selectedGenres.join(', ');
          }
          // } else if (state is CastMembersUpdatedState) {
          //   castMembers = state.castMembers;
          //   log('caste members $castMembers');
          // }
          else if (state is AddMovieSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                text: state.message,
                icon: Icons.check_circle_rounded,
                iconColor: green,
                borderColor: green));
            Navigator.of(context).pop();
          } else if (state is AddMovieFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                text: state.message,
                icon: Icons.error,
                iconColor: red,
                borderColor: red));
            Navigator.of(context).pop();
          }
        }, builder: (context, state) {
          return Stack(
            children: [
              Form(
                key: AddMovieScreen.movieformKey,
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
                      onTap: () => showDropdownMenu(context, certificateItems),
                      validatorOne: (value) =>
                          validate(value, 'please enter the movie\n name'),
                      validatorTwo: (value) => validate(
                          value, 'Please select any from\n given list'),
                      readOnly: true,
                    ),
                    AddDetailColum(
                        controller: languageController,
                        title: 'Languages',
                        hintText: 'select languages',
                        readOnly: true,
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        onTap: () => showMultipleSelectionBottomSheet(
                            context, languageItems, isLanguageSelection: true),
                        validator: (value) => validate(
                            value, 'Please select languages from given list')),
                    AddDetailColum(
                      controller: genreController,
                      title: 'Genres',
                      hintText: 'Select genres',
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      onTap: () => showMultipleSelectionBottomSheet(
                        isLanguageSelection: false,
                        context,
                        genreItems,
                      ),
                      validator: (value) => validate(
                          value, 'Please select genres from given list'),
                      readOnly: true,
                    ),
                    BlocConsumer<DatePickerBloc, DatePickerState>(
                        listener: (context, state) {
                      if (state is DateSelectedState) {
                        dateController.text =
                            DateFormat('dd/MM/yyyy').format(state.selectedDate);
                      }
                    }, builder: (context, state) {
                      if (state is DateSelectedState) {
                        selectedDate = state.selectedDate;
                      }
                      return AddDetailRaw(
                        controller1: dateController,
                        controller2: durationController,
                        calendarIcon: CustomDatePicker(
                          initialDate: selectedDate ?? DateTime.now(),
                        ),
                        title1: 'Release Date',
                        title2: 'Duration',
                        hintText1: 'select date',
                        hintText2: 'hr : min',
                        validatorOne: (value) => validateDate(value),
                        validatorTwo: (value) => validateDuration(value),
                      );
                    }),
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
                      child: BlocBuilder<AddDetailsBloc, AddDetailsState>(
                        builder: (context, state) {
                          if (state is CastMembersUpdatedState) {
                            castMembers = state.castMembers;
                          }
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 0.8),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: castMembers.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return CasteButton(
                                  onTap: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return Form(
                                          key: AddMovieScreen.casteformKey,
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

                                                  log('pickedimage : $pickedImage');
                                                }
                                                return CustomImagePicker(
                                                  path: pickedImage ?? '',
                                                  onTap: () {
                                                    log('pressed');
                                                    context
                                                        .read<ImagePickerBloc>()
                                                        .add(
                                                            const PickImageEvent(
                                                                ImageSource
                                                                    .gallery));
                                                  },
                                                );
                                              },
                                            ),
                                            addCasteButtonOnPressed: () async {
                                              if (AddMovieScreen
                                                  .casteformKey.currentState!
                                                  .validate()) {
                                                context
                                                    .read<AddDetailsBloc>()
                                                    .add(
                                                      AddCastMemberEvent(
                                                        name:
                                                            casteNameController
                                                                .text
                                                                .trim(),
                                                        imagePath:
                                                            pickedImage ?? '',
                                                      ),
                                                    );

                                                casteNameController.clear();
                                                context
                                                    .read<ImagePickerBloc>()
                                                    .add(
                                                        ClearImagePickerEvent());
                                                Navigator.of(context).pop();
                                              }
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              } else {
                                final castMember = castMembers[index - 1];
                                return BlocBuilder<AddDetailsBloc,
                                    AddDetailsState>(
                                  builder: (context, state) {
                                    return CasteMemberContainer(
                                        onPressed: () {},
                                        casteMemberImage: castMember.imagePath,
                                        casteMembername: castMember.name);
                                  },
                                );
                              }
                            },
                          );
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
                          posterImage: pickedPoster != null
                              ? DecorationImage(
                                  image: FileImage(
                                    File(pickedPoster ?? ''),
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          backdroponTap: () {
                            context.read<ImagePickerBloc>().add(
                                  const BackdropImagePickedEvent(
                                      ImageSource.gallery),
                                );
                          },
                          backdropImage: pickedBackdrop != null
                              ? DecorationImage(
                                  image: FileImage(
                                    File(pickedBackdrop ?? ''),
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
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
                    CustomButton(
                      onPressed: () async {
                        log('$selectedLanguages');
                        if (AddMovieScreen.movieformKey.currentState!
                            .validate()) {
                          final posterUrl = await MovieDatabaserepository()
                              .uploadPoster(pickedPoster);
                          final backdropUrl = await MovieDatabaserepository()
                              .uploadBackdrp(pickedBackdrop);

                          context.read<AddDetailsBloc>().add(
                                AddMovieEvent(
                                  MovieClass(
                                      movieId: '',
                                      blocked: false,
                                      trailerLink: linkController.text.trim(),
                                      movieName: nameController.text.trim(),
                                      certificate:
                                          certificateController.text.trim(),
                                      languages: (languageController.text
                                          .trim()
                                          .split(',')
                                          .map((language) =>
                                              language.trim())).toList(),
                                      genres: (genreController.text
                                          .trim()
                                          .split(', ')
                                          .map(
                                            (genres) => genres.trim(),
                                          )).toList(),
                                      releaseDate: dateController.text.trim(),
                                      duration: durationController.text.trim(),
                                      description:
                                          discriptionController.text.trim(),
                                      castMembers: castMembers,
                                      posterImage: posterUrl,
                                      backdropImage: backdropUrl,
                                      review: []),
                                ),
                              );
                        }
                        context.read<MovieBloc>().add(
                              FetchAllMoviesEvent(),
                            );
                        context
                            .read<ImagePickerBloc>()
                            .add(ClearPosterImageEvent());
                        context
                            .read<ImagePickerBloc>()
                            .add(ClearbackdropImageEvent());
                        context
                            .read<AddDetailsBloc>()
                            .add(const ClearCastMembersEvent());
                        context.read<DatePickerBloc>().add(ClearDateEvent());
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ),
              state is AddMovieLoadingState
                  ? const Positioned.fill(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        }),
      ),
    );
  }
}

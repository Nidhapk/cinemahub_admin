import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/repository/movie_database_repository.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/languages/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/languages/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/languages/bloc/bloc_state.dart';
import 'package:onlinebooking_adminside/presentation/themes/app_colors.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_snackbar.dart';
import 'package:onlinebooking_adminside/presentation/widgets/custom_textform.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LanguagesBloc>().add(const FetchLanguagesEvent());
    TextEditingController languageController = TextEditingController();
    TextEditingController editLanguageController = TextEditingController();
    return ListView(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      children: [
        const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 6,
                spreadRadius: 2)
          ], borderRadius: BorderRadius.circular(20), color: white),
          child: BlocConsumer<LanguagesBloc, LanguagesState>(
            listener: (context, state) {
              if (state is LanguagesAddedsuccsessState) {
                ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                    text: '${state.language} has been added successfully',
                    icon: Icons.check_circle,
                    iconColor: green,
                    borderColor: green));
                Navigator.of(context).pop();
              } else if (state is LanguagesAddedFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                    text: state.error,
                    icon: Icons.check_circle,
                    iconColor: green,
                    borderColor: green));
              } else if (state is LanguageEditedSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                    text: 'Edited successfully',
                    icon: Icons.check_circle,
                    iconColor: green,
                    borderColor: green));
                Navigator.of(context).pop();
              } else if (state is DeleteLanguageSuccessState) {}
            },
            builder: (context, state) {
              List<Language> languages = [];
              if (state is LanguageLoadedState) {
                languages = state.languages;
              }

              return ListView.separated(
                shrinkWrap: true,
                itemCount: languages.length + 1,
                itemBuilder: (context, index) {
                  // editLanguageController.text =
                  //     languages.isEmpty ? '' : languages[index - 1].language;
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 80,
                      ),
                      child: ListTile(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  child: ListView(
                                    padding: const EdgeInsets.all(20),
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      CustomTextForm(
                                          controller: languageController,
                                          hintText: 'enter language'),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              context.read<LanguagesBloc>().add(
                                                  AddinglanguageEvent(
                                                      languageController.text
                                                          .trim()));
                                            },
                                            child: const Text('Add')),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        leading: const Icon(Icons.add),
                        title: const Text('Add new language'),
                      ),
                    );
                  } else {
                    final currentLanguage = languages[index - 1];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(languages[index - 1].language)),
                        PopupMenuButton<String>(
                          onSelected: (String result) {
                            // Handle menu item selection
                            switch (result) {
                              case 'Edit':
                                editLanguageController.text =
                                    currentLanguage.language;
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        child: ListView(
                                          padding: const EdgeInsets.all(20),
                                          children: [
                                            CustomTextForm(
                                                controller:
                                                    editLanguageController,
                                                hintText: 'enter language'),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    context
                                                        .read<LanguagesBloc>()
                                                        .add(EditlanguageEvent(
                                                            languages[index - 1]
                                                                .id,
                                                            languageController
                                                                .text
                                                                .trim()));
                                                  },
                                                  child: const Text('Edit')),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                                break;
                              case 'Remove':
                                context.read<LanguagesBloc>().add(
                                    DeleteingLanguageEvent(
                                        languages[index - 1].id));
                                context
                                    .read<LanguagesBloc>()
                                    .add(const FetchLanguagesEvent());
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'Edit',
                              child: Text('Edit Language'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Remove',
                              child: Text('Remove Language'),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: mainColor,
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}

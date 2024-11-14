import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/constants/constants.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/genre_item_sheet/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/genre_item_sheet/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/genre_item_sheet/bloc/bloc_state.dart';

void showGenreSelectionBottomSheet(
    BuildContext context, List<String> preselctedItems) {
  context.read<GenreSelectionBloc>().add(InitializeGenreSelectionEvent(
        items: genreItems,
        preselectedItems: preselctedItems,
      ));
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const SelectionBody(),
      );
    },
  );
}

class SelectionBody extends StatelessWidget {
  const SelectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Genres',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Divider(
            height: 0,
          ),
          Flexible(
            child: BlocBuilder<GenreSelectionBloc, GenreSelectionState>(
              builder: (context, state) {
                if (state is GenreLoadedState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      final isSelected = state.selectedItems.contains(item);

                      return CheckboxListTile(
                        title: Text(
                          item,
                          style: const TextStyle(fontSize: 15),
                        ),
                        value: isSelected,
                        onChanged: (bool? value) {
                          if (value == true) {
                            context
                                .read<GenreSelectionBloc>()
                                .add(GenreSelectedEvent(item));
                          } else {
                            context
                                .read<GenreSelectionBloc>()
                                .add(GenreDeselectedEvent(item));
                          }
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                context
                    .read<GenreSelectionBloc>()
                    .add(SubmitGenreSelectionEvent());
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

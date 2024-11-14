import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/add_movie_details/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/add_movie_details/bloc/bloc_event.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/add_movie_details/bloc/bloc_state.dart';

void showDropdownMenu(BuildContext context, List<String> drodownItems) async {
  final bloc = context.read<AddDetailsBloc>();

  final selectedItem = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: drodownItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    drodownItems[index],
                  ),
                  onTap: () {
                    context.read<AddDetailsBloc>().add(
                          DropdownItemSelected(
                            drodownItems[index],
                          ),
                        );
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      );
    },
  );

  if (selectedItem != null) {
    bloc.add(DropdownItemSelected(selectedItem));
  }
}

Future<void> showMultipleSelectionBottomSheet(
  BuildContext context,
  List<String> items, {
  required bool isLanguageSelection,
}) async {
  final bloc = context.read<AddDetailsBloc>();

  final selectedItems = await showModalBottomSheet<List<String>>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return BlocBuilder<AddDetailsBloc, AddDetailsState>(
        builder: (BuildContext context, state) {
          final List<String> currentSelection = isLanguageSelection
              ? (state is MultipleItemsSelectedState
                  ? state.selectedLanguages
                  : [])
              : (state is MultipleItemsSelectedState
                  ? state.selectedGenres
                  : []);
          final List<String> displayedItems = List.from(currentSelection);

          return Wrap(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];
                  final isSelected = displayedItems.contains(item);
                  return ListTile(
                    title: Text(item),
                    trailing: isSelected ? const Icon(Icons.check) : null,
                    onTap: () {
                      if (isSelected) {
                        displayedItems.remove(item);
                      } else {
                        displayedItems.add(item);
                      }
                      bloc.add(
                        MultipleDropdownItemSelected(
                          selectedLanguages: isLanguageSelection
                              ? displayedItems
                              : (state is MultipleItemsSelectedState
                                  ? state.selectedLanguages
                                  : []),
                          selectedGenres: isLanguageSelection
                              ? (state is MultipleItemsSelectedState
                                  ? state.selectedGenres
                                  : [])
                              : displayedItems,
                        ),
                      );
                    },
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, displayedItems);
                },
                child: const Text('Done'),
              ),
            ],
          );
        },
      );
    },
  );

  if (selectedItems != null) {
    bloc.add(
      MultipleDropdownItemSelected(
        selectedLanguages: isLanguageSelection
            ? selectedItems
            : (bloc.state is MultipleItemsSelectedState
                ? (bloc.state as MultipleDropdownItemSelected).selectedLanguages
                : []),
        selectedGenres: isLanguageSelection
            ? (bloc.state is MultipleItemsSelectedState
                ? (bloc.state as MultipleItemsSelectedState).selectedGenres
                : [])
            : selectedItems,
      ),
    );
  }
}



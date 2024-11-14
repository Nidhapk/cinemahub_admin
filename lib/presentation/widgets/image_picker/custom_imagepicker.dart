
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/presentation/widgets/image_picker/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/widgets/image_picker/bloc/bloc_state.dart';

class CustomImagePicker extends StatelessWidget {
  final String path;
  final void Function()? onTap;
  const CustomImagePicker({super.key, required this.path, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
        builder: (context, state) {
          Widget avatar = CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(
              Icons.person,
              size: 30,
            ),
          );
          if (state is ImagePickerImagePicked ) {
            avatar = CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(state.image)
            );
          }
          return GestureDetector(
            onTap: onTap,
            child: avatar,
          );
        },
      ),
    );
  }
}

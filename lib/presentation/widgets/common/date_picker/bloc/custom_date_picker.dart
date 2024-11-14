// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/date_picker/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/date_picker/bloc/bloc_event.dart';

class CustomDatePicker extends StatelessWidget {
 final DateTime? initialDate;
  const CustomDatePicker({
    super.key,required this.initialDate
  });

  @override
  Widget build(BuildContext context) {
    return  IconButton(
          onPressed: () async {
            DateTime? pickedDate;
            pickedDate = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2050),
            );
            if (pickedDate != null &&context.mounted) {
              context.read<DatePickerBloc>().add(
                    SelectDateEvent(pickedDate),
                  );
            }
          },
          icon: const Icon(
            Icons.calendar_month_sharp,
            size: 17,
            color: Colors.grey,
          ),
        );
      
  }
}

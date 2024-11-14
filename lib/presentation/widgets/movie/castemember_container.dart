import 'package:flutter/material.dart';

class CasteMemberContainer extends StatelessWidget {
  final String casteMemberImage;
  final String casteMembername;
  final void Function()? onPressed;
  const CasteMemberContainer(
      {super.key,
      required this.casteMemberImage,
      required this.casteMembername,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.02,
        ),
        CircleAvatar(
          //radius: 100,
          backgroundImage: NetworkImage(casteMemberImage),
        ),
        const SizedBox(height: 8),
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          casteMembername,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CasteButton extends StatelessWidget {
  final void Function()? onTap;
  const CasteButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color:const  Color.fromARGB(255, 199, 199, 206),
                    ),
                    shape: BoxShape.circle),
                child: const Icon(
                  Icons.add,
                  color: Color.fromARGB(255, 199, 199, 206),
                ),
              ),
              // const SizedBox(height: 10),
             const Text(
                '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ],
          )),
    );
  }
}

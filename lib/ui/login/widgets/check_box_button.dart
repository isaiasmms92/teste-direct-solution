import 'package:flutter/material.dart';

class CheckBoxButton extends StatelessWidget {
  final bool isChecked;
  final void Function(bool?)? onChanged;
  final void Function()? onTap;
  const CheckBoxButton({
    super.key,
    required this.onChanged,
    required this.onTap,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: const Color.fromARGB(255, 84, 163, 87),
              checkColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              value: isChecked,
              onChanged: onChanged,
            ),
          ),
        ),
        const SizedBox(width: 4),
        const Text(
          'Lembrar Sempre',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

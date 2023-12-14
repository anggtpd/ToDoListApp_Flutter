import 'package:flutter/material.dart';
import 'package:to_do_list_app/buttons.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final String textOnPressed;
  final VoidCallback onPressed;
  final VoidCallback onCancel;

  const DialogBox(
      {super.key,
      required this.controller,
      required this.text,
      required this.textOnPressed,
      required this.onPressed,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 22),
      ),
      content: SizedBox(
        height: 120,
        child: Column(
          children: [
            // get user input
            TextField(
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
              controller: controller,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // buttons save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButtons(
                  text: textOnPressed,
                  onPressed: onPressed,
                ),
                const SizedBox(
                  width: 8,
                ),
                MyButtons(text: "Cancel", onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.deepOrangeAccent,
    );
  }
}

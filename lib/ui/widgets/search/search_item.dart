import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  final Function(String) onChange;
  final TextEditingController controller;
  final bool readOnly;
  final bool autoFocus;
  const SearchItem({
    Key? key,
    required this.controller,
    required this.onChange,
    this.readOnly = false,
    required this.autoFocus,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black12.withOpacity(0.05),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.search,
              size: 20,
              color: Colors.black54,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                readOnly: readOnly,
                autofocus: autoFocus,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
                onChanged: (value) => onChange(value) ?? {},
                decoration: const InputDecoration(
                  hintText: "Find Restaurant",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

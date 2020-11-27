import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';

class SearchInput extends StatelessWidget {
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final VoidCallback onClear;
  final TextEditingController controller;
  final bool enabled;
  final bool autofocus;

  const SearchInput({
    Key key,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.controller,
    this.enabled = false,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !enabled,
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        onChanged: (val) => onChanged(val),
        onSubmitted: (val) => onSubmitted(val),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              (controller == null || controller.text.isEmpty)
                  ? Icons.search
                  : Icons.close,
              color: Colors.black,
            ),
            onPressed: (controller == null || controller.text.isEmpty)
                ? null
                : onClear,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: Gap.m),
          focusColor: secondaryColor,
          fillColor: secondaryColor.withOpacity(0.1),
          filled: true,
          hintText: "Cari disini",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

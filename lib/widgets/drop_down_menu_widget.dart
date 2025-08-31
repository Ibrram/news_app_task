import 'package:flutter/material.dart';
import 'package:news_app_task/core/theme_manager/colors_palette.dart';

class DropDownMenuWidget extends StatefulWidget {
  const DropDownMenuWidget({
    super.key,
    required this.items,
    this.selected,
    required this.onChanged,
  });
  final List<DropdownMenuItem> items;
  final String? selected;
  final Function(String? value)? onChanged;

  @override
  State<DropDownMenuWidget> createState() => _DropDownMenuWidgetState();
}

class _DropDownMenuWidgetState extends State<DropDownMenuWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        border: BoxBorder.all(color: ColorsPalette.scaffoldBackground),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          dropdownColor: ColorsPalette.primaryBlackColor,
          value: widget.selected,
          items: widget.items,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: ColorsPalette.scaffoldBackground,
            fontWeight: FontWeight.w700,
          ),
          iconEnabledColor: ColorsPalette.scaffoldBackground,
          onChanged: (value) {
            widget.onChanged!(value);
          },
        ),
      ),
    );
  }
}

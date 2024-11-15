import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/utils/spacers.dart';
import 'package:roqqu_trade/widgets/custom_toggle_swich.dart';
import 'package:roqqu_trade/widgets/menu_custom_text.dart';

class MenuDialog extends StatefulWidget {
  final WidgetRef ref;
  const MenuDialog({
    super.key,
    required this.ref,
  });

  @override
  State<MenuDialog> createState() => _MenuDialogState();
}

class _MenuDialogState extends State<MenuDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: CustomColors.reverseWhiteTextColor(widget.ref),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpacer(5),
          MenuText(
            title: 'Exchange',
            ref: widget.ref,
          ),
          MenuText(
            title: 'Wallets',
            ref: widget.ref,
            isSelected: true,
          ),
          MenuText(
            title: 'Roqqu Hub',
            ref: widget.ref,
          ),
          MenuText(
            title: 'Log out',
            ref: widget.ref,
          ),
          verticalSpacer(20),
          const Center(
            child: ToggleSwitch(),
          ),
          verticalSpacer(5),
        ],
      ),
    );
  }
}

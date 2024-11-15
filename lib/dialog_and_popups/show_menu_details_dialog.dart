import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/widgets/menu_dialog_content.dart';

void showMenuDetailsDialog(BuildContext context, WidgetRef ref) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Consumer(builder: (context, ref, child) {
          return Stack(
            children: [
              Positioned(
                top: 60,
                right: 00,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Material(
                    color: Colors.black,
                    child: MenuDialog(
                      ref: ref,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
      });
}

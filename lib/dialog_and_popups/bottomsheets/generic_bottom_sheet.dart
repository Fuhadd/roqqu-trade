import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/utils/spacers.dart';
import 'package:roqqu_trade/widgets/custom_text_widget.dart';

void showGenericBottomSheet(
  BuildContext context,
  WidgetRef ref, {
  required String title,
  required Widget child,
  String? okText,
  String? cancelText,
  Color? okBbuttonColor,
  Function()? onOkPressed,
  Function()? onCancelPressed,
  bool isDismissible = true,
  bool enableDrag = false,
  bool showBackButton = true,
}) {
  showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: CustomColors.expandedBgColor(ref),
      elevation: 0,
      context: context,
      builder: (context) {
        return PopScope(
          canPop: isDismissible ? true : false,
          onPopInvoked: (didPop) {
            if (didPop) {
              return;
            }
          },
          child: LayoutBuilder(builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Consumer(builder: (context, ref, children) {
                    return Column(
                      children: [
                        verticalSpacer(30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              semiBoldText(title, fontSize: 16),
                            ],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  child,
                                ],
                              ),
                            ),
                          ),
                        ),
                        verticalSpacer(20),
                        verticalSpacer(
                            MediaQuery.of(context).padding.bottom + 25),
                      ],
                    );
                  }),
                ),
              ),
            );
          }),
        );
      });
}

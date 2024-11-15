import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/constants/custom_string.dart';
import 'package:roqqu_trade/globals.dart';
import 'package:roqqu_trade/models/currency_pair_model.dart';
import 'package:roqqu_trade/utils/custom_text_styles.dart';
import 'package:roqqu_trade/utils/enum.dart';

class CustomListDropdownField extends StatefulHookConsumerWidget {
  final List<CurrencyPair> items;

  final AutoDisposeStateProvider<CurrencyPair> selectedItem;
  const CustomListDropdownField({
    super.key,
    required this.items,
    required this.selectedItem,
  });

  @override
  ConsumerState<CustomListDropdownField> createState() =>
      _CustomListDropdownFieldState();
}

class _CustomListDropdownFieldState
    extends ConsumerState<CustomListDropdownField> {
  Timer? debounce;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FocusNode myNode = FocusNode();

    return Container(
      width: 190,
      height: 47,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.only(
          right: 5.0,
        ),
        child: DropdownButtonHideUnderline(
          child: Listener(
            onPointerDown: (_) => FocusScope.of(context).requestFocus(
              FocusNode(),
            ),
            child: DropdownButton2<CurrencyPair>(
              isExpanded: true,
              selectedItemBuilder: (BuildContext context) {
                return widget.items.map<Widget>((room) {
                  return Container(
                    padding: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 49,
                              child: Row(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Image.asset(
                                        room.pairImage,
                                        height: 26,
                                        width: 26,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        left: 18,
                                        child: Image.asset(
                                          ConstantString.currencyImage,
                                          height: 26,
                                          width: 26,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              room.pair,
                              style: CustomTextStyles.w500(
                                fontSize: 17,
                                color: CustomColors.whiteTextColor(ref),
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
              items: widget.items.map<DropdownMenuItem<CurrencyPair>>((item) {
                return DropdownMenuItem<CurrencyPair>(
                  value: item,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 49,
                        child: Row(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.centerLeft,
                              children: [
                                Image.asset(
                                  item.pairImage,
                                  height: 25,
                                  width: 25,
                                ),
                                Positioned(
                                  left: 18,
                                  child: Image.asset(
                                    ConstantString.currencyImage,
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        item.pair,
                        style: CustomTextStyles.w500(
                          fontSize: 17,
                          color: CustomColors.gradientPurpleColor,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                );
              }).toList(),
              value: ref.watch(widget.selectedItem),
              onChanged: (value) async {
                setState(() {
                  ref.read(widget.selectedItem.notifier).state =
                      value ?? getCurrencyPairs[0];
                });
              },
              iconStyleData: IconStyleData(
                icon: SvgPicture.asset(
                  ref.watch(userThemeProvider) == AppTheme.dark
                      ? ConstantString.whiteDropdownIcon
                      : ConstantString.darkDropdownIcon,
                ),
                iconSize: 14,
                iconEnabledColor: Colors.black,
                iconDisabledColor: Colors.grey,
              ),
              focusNode: myNode,
              dropdownStyleData: DropdownStyleData(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
                elevation: 0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CustomColors.blackColor.withOpacity(0.15),
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: CustomColors.blackBgColor(ref),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
              dropdownSearchData: null,
              onMenuStateChange: (isOpen) async {
                if (!isOpen) {
                  textEditingController.clear();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

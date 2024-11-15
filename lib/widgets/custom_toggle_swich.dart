import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/constants/custom_string.dart';
import 'package:roqqu_trade/data/repositories/local_cache/local_cache.dart';
import 'package:roqqu_trade/globals.dart';
import 'package:roqqu_trade/locator.dart';
import 'package:roqqu_trade/utils/enum.dart';

class ToggleSwitch extends StatefulHookConsumerWidget {
  const ToggleSwitch({
    super.key,
  });

  @override
  ConsumerState<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends ConsumerState<ToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    int value = ref.watch(userThemeProvider) == AppTheme.dark ? 0 : 1;
    return AnimatedToggleSwitch<int>.rolling(
      current: value,
      borderWidth: 4.0,
      values: const [
        0,
        1,
      ],
      onChanged: (i) {
        setState(() => value = i);

        locator<LocalCache>().saveToLocalCache(
          key: ConstantString.userTheme,
          value: i == 0 ? AppTheme.dark.toString() : AppTheme.light.toString(),
        );
        ref.read(userThemeProvider.notifier).state =
            i == 0 ? AppTheme.dark : AppTheme.light;
      },
      style: const ToggleStyle(
        backgroundGradient: LinearGradient(colors: [
          CustomColors.gradientPurpleColor,
          CustomColors.gradientMidPurpleColor,
          CustomColors.gradientOrangeColor,
        ]),
        borderColor: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: CustomColors.lightWhiteColor,
            blurRadius: 1,
          ),
        ],
      ),
      styleBuilder: (b) => ToggleStyle(
        indicatorColor:
            b == 0 ? CustomColors.blackColor : CustomColors.whiteColor,
      ),
      iconBuilder: (test, value) => value
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: SvgPicture.asset(
                  ConstantString.themeIcon,
                  color: CustomColors.greyColor,
                ),
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: SvgPicture.asset(
                  ConstantString.themeIcon,
                  color: test == 0
                      ? CustomColors.blackColor
                      : test == 1
                          ? CustomColors.whiteColor
                          : CustomColors.blackColor,
                ),
              ),
            ),
    );
  }
}

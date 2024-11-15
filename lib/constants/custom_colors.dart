import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/globals.dart';
import 'package:roqqu_trade/utils/enum.dart';

class CustomColors {
  static const whiteColor = Color(0xFFFFFFFF);
  static const redBgColor = Color(0xFFDA5552);

  static Color whiteTextColor(WidgetRef ref) =>
      ref.watch(userThemeProvider) == AppTheme.dark
          ? const Color(0xFFFFFFFF)
          : const Color(0xFF1C2127);

  static Color reverseWhiteTextColor(WidgetRef ref) =>
      ref.watch(userThemeProvider) == AppTheme.dark
          ? const Color(0xFF1C2127)
          : const Color(0xFFFFFFFF);

  static Color lighterWhiteTextColor(WidgetRef ref) =>
      ref.watch(userThemeProvider) == AppTheme.dark
          ? const Color(0xFFFFFFFF)
          : const Color(0xFF737A91);

  static const blackColor = Color(0xFF000000);

  static Color tabBlackColor(WidgetRef ref) =>
      ref.watch(userThemeProvider) == AppTheme.dark
          ? const Color(0xFF000000).withOpacity(0.16)
          : const Color(0xFFF1F1F1);
  static const blackTextColor = Color(0xFF101828);

  static Color blackBgColor(WidgetRef ref) =>
      ref.watch(userThemeProvider) == AppTheme.dark
          ? const Color(0xFF1C2127)
          : const Color(0xFFF8F8F9);

  static Color blackBorderColor(WidgetRef ref) =>
      ref.watch(userThemeProvider) == AppTheme.dark
          ? const Color(0xFF262932)
          : const Color(0xFFF1F1F1);

  static const gradientPurpleColor = Color(0xFF483BEB);
  static const gradientMidPurpleColor = Color(0xFF7847E1);
  static const gradientOrangeColor = Color(0xFFDD568D);

  static const greenTextColor = Color(0xFF00C076);
  static const greyTextColor = Color(0xFFA7B1BC);
  static const dividerColor = Color(0xFFEAF0FE);

  static Color selectedTabColor(WidgetRef ref) =>
      ref.watch(userThemeProvider) == AppTheme.dark
          ? const Color(0xFFE9F0FF).withOpacity(0.05)
          : const Color(0xFFFFFFFF);

  static const greenButtonColor = Color(0xFF25C26E);
  static const redButtonColor = Color(0xFFFF554A);

  static Color buttonBgColor(WidgetRef ref) =>
      ref.watch(userThemeProvider) == AppTheme.dark
          ? const Color(0xFF262B31)
          : const Color(0xFFFFFFFF);

  static Color expandedBgColor(WidgetRef ref) =>
      ref.watch(userThemeProvider) == AppTheme.dark
          ? const Color(0xFF17181B)
          : const Color(0xFFFFFFFF);

  static const bottomSheetTabColor = Color(0xFF353945);

  static Color dividerGreyColor(WidgetRef ref) =>
      ref.watch(userThemeProvider) == AppTheme.dark
          ? const Color(0xFF373B3F)
          : const Color(0xFFF1F1F1);

  static Color secondExpandedBgColor(WidgetRef ref) =>
      ref.watch(userThemeProvider) == AppTheme.dark
          ? const Color(0xFF21262C)
          : const Color(0xFFFFFFFF);
  static const redTextColor = Color(0xFFFF6838);

  static Color timeFrameBgColor(WidgetRef ref) =>
      ref.watch(userThemeProvider) == AppTheme.dark
          ? const Color(0xFF555C63)
          : const Color(0xFFCFD3D8);

  static Color menuTextColor(WidgetRef ref) =>
      ref.watch(userThemeProvider) == AppTheme.dark
          ? const Color(0xFF252A30)
          : const Color(0xFFF1F1F1);

  static const blueColor = Color(0xFF2764FF);

  static const lightWhiteColor = Color(0xFFD0D5DD);
  static const backBorderColor = Color(0xFFF9FAFB);
  static const boldBlackTextColor = Color(0xFF070707);
  static const formTitleColor = Color(0xFF475467);
  static const greyColor = Color(0xFFBBBBBB);
}

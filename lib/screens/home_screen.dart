import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/constants/custom_string.dart';
import 'package:roqqu_trade/dialog_and_popups/show_menu_details_dialog.dart';
import 'package:roqqu_trade/globals.dart';
import 'package:roqqu_trade/utils/enum.dart';
import 'package:roqqu_trade/utils/spacers.dart';
import 'package:roqqu_trade/widgets/trade_screen_body.dart';
import 'package:roqqu_trade/widgets/trade_screen_bottom_bar.dart';

class TradeScreen extends StatefulHookConsumerWidget {
  const TradeScreen({super.key});

  @override
  ConsumerState<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends ConsumerState<TradeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.blackBgColor(ref),
      body: Column(
        children: [
          verticalSpacer(MediaQuery.of(context).padding.top + 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  ref.watch(userThemeProvider) == AppTheme.dark
                      ? ConstantString.whiteCompanyLogo
                      : ConstantString.darkCompanyLogo,
                  height: 34,
                  width: 121,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(
                        ConstantString.avatarImage,
                      ),
                    ),
                    horizontalSpacer(10),
                    SvgPicture.asset(
                      ConstantString.webIcon,
                    ),
                    horizontalSpacer(10),
                    GestureDetector(
                      onTap: () {
                        showMenuDetailsDialog(context, ref);
                      },
                      child: SvgPicture.asset(
                        ConstantString.menuIcon,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          verticalSpacer(20),
          const Expanded(child: TradeScreenBody()),
        ],
      ),
      bottomNavigationBar: const TradeScreenBottomBar(),
    );
  }
}

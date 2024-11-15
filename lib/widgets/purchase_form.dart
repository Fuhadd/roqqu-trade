import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roqqu_trade/constants/custom_colors.dart';
import 'package:roqqu_trade/constants/custom_string.dart';
import 'package:roqqu_trade/utils/custom_text_styles.dart';
import 'package:roqqu_trade/utils/spacers.dart';
import 'package:roqqu_trade/widgets/custom_text_widget.dart';
import 'package:roqqu_trade/widgets/custom_textfield.dart';

class PurchaseForm extends StatefulHookConsumerWidget {
  const PurchaseForm({super.key});

  @override
  ConsumerState<PurchaseForm> createState() => _PurchaseFormState();
}

class _PurchaseFormState extends ConsumerState<PurchaseForm>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedType = "Good till cancelled";
  final List<String> _orderTypes = [
    "Good till cancelled",
    "Immediate or Cancel"
  ];
  TextEditingController limitPriceController =
      TextEditingController(text: '0.00');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: CustomColors.whiteTextColor(ref),
              unselectedLabelColor: CustomColors.whiteTextColor(ref),
              labelStyle: CustomTextStyles.semiBold(
                fontSize: 14,
                color: CustomColors.whiteColor,
              ),
              unselectedLabelStyle: CustomTextStyles.w500(
                fontSize: 14,
                color: CustomColors.greyTextColor,
              ),
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: CustomColors.greenButtonColor),
                color: CustomColors.selectedTabColor(ref),
              ),
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'Buy',
                ),
                Tab(
                  text: 'Sell',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildTradeForm(context, true, limitPriceController),
                buildTradeForm(context, false, limitPriceController),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTradeForm(BuildContext context, bool isBuy,
      TextEditingController limitPriceController) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpacer(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildToggleButton("Limit", true),
              buildToggleButton("Market", false),
              buildToggleButton("Stop-Limit", false),
            ],
          ),
          verticalSpacer(30),
          customTextField("Limit price", ref),
          verticalSpacer(20),
          customTextField("Amount", ref),
          verticalSpacer(20),
          CustomDropdownButton(
            label: "Type",
            items: _orderTypes,
            value: _selectedType,
            onChanged: (value) {
              setState(() {
                _selectedType = value;
              });
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Checkbox(value: false, onChanged: (value) {}),
              w500Text(
                "Post Only",
                color: CustomColors.greyTextColor,
                fontSize: 15,
              ),
              horizontalSpacer(5),
              const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: CustomColors.greyTextColor,
                  size: 15,
                ),
              )
            ],
          ),
          verticalSpacer(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              w500Text(
                "Total",
                color: CustomColors.greyTextColor,
                fontSize: 15,
              ),
              w500Text(
                '0.00',
                color: CustomColors.greyTextColor,
                fontSize: 15,
              ),
            ],
          ),
          verticalSpacer(20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isBuy
                    ? [
                        CustomColors.gradientPurpleColor,
                        CustomColors.gradientMidPurpleColor,
                        CustomColors.gradientOrangeColor,
                      ]
                    : [Colors.red, Colors.orange],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: semiBoldText(
              isBuy ? "Buy BTC" : "Sell BTC",
              color: CustomColors.whiteColor,
              fontSize: 15,
            ),
          ),
          verticalSpacer(20),
          const Divider(color: Colors.grey),
          verticalSpacer(10),
          buildAccountInfoRow(
              "Total account value", "0.00", "Open Orders", "0.00"),
          const SizedBox(height: 10),
          buildAccountInfoRow("Available", "0.00", "", ""),
          const SizedBox(height: 20),
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: CustomColors.blueColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Deposit",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildToggleButton(String text, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? CustomColors.bottomSheetTabColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: isSelected
            ? semiBoldText(text, color: CustomColors.whiteColor, fontSize: 14)
            : w500Text(text, color: CustomColors.greyTextColor, fontSize: 14),
      ),
    );
  }

  Widget buildAccountInfoRow(
      String label1, String value1, String label2, String value2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label1, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 5),
            Text(value1,
                style: TextStyle(color: CustomColors.whiteTextColor(ref))),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label2, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 5),
            Text(value2,
                style: TextStyle(color: CustomColors.whiteTextColor(ref))),
          ],
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String suffixText;

  const CustomTextField(
      {super.key, required this.label, required this.suffixText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            filled: false,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
            prefix: Row(
              children: [
                w500Text(
                  label,
                  color: CustomColors.greyTextColor,
                  fontSize: 14,
                ),
                const Icon(
                  Icons.info_outline_rounded,
                )
              ],
            ),
            suffixText: suffixText,
            suffixStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class CustomDropdownButton extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  const CustomDropdownButton({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              border: Border.all(
                  color: CustomColors.dividerGreyColor(ref), width: 0.8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                value: value,
                items: items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            w500Text(
                              label,
                              color: CustomColors.greyTextColor,
                              fontSize: 15,
                            ),
                            horizontalSpacer(5),
                            const Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Icon(
                                Icons.info_outline_rounded,
                                color: CustomColors.greyTextColor,
                                size: 15,
                              ),
                            )
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        w500Text(
                          item,
                          color: CustomColors.greyTextColor,
                          fontSize: 15,
                        ),
                      ],
                    ),
                  );
                }).toList(),
                iconStyleData: IconStyleData(
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: SvgPicture.asset(
                      ConstantString.whiteDropdownIcon,
                      // colorFilter: const ColorFilter.mode(
                      //   CustomColors.blackColor,
                      //   BlendMode.srcIn,
                      // ),
                    ),
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.black,
                  iconDisabledColor: Colors.grey,
                ),
                onChanged: onChanged,
                // dropdownDecoration: BoxDecoration(
                //   color: Colors.grey[800],
                //   borderRadius: BorderRadius.circular(8),
                // ),
                // buttonDecoration: BoxDecoration(
                //   color: Colors.grey[800],
                //   borderRadius: BorderRadius.circular(8),
                // ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

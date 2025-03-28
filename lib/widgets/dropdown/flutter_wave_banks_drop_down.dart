// ignore_for_file: must_be_immutable

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrpay/language/language_controller.dart';

import '../../backend/model/categories/withdraw/flutter_wave_banks_model.dart';
// import '../../controller/categories/withdraw_controller/withdraw_controller.dart';
import '../../utils/custom_color.dart';
import '../../utils/custom_style.dart';
import '../../utils/dimensions.dart';

class FlutterWaveBanksDropDown extends StatelessWidget {
  final RxString selectMethod;
  final List<BankInfos> bankInfoList;
  bool isTapped;
  final void Function(BankInfos?)? onChanged;

  FlutterWaveBanksDropDown({
    required this.bankInfoList,
    super.key,
    required this.selectMethod,
    this.onChanged,
    this.isTapped = false,
  });

  @override
  Widget build(BuildContext context) {
    return bankInfoList.isNotEmpty
        ? Obx(
            () => Container(
              height: Dimensions.inputBoxHeight * 0.75,
              decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColor.primaryLightColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              ),
              child: DropdownSearch<BankInfos>(
                selectedItem: bankInfoList.firstWhere(
                  (item) => item.name == selectMethod.value,
                  orElse: () => bankInfoList.first,
                ),
                onChanged: (v) {
                  isTapped = true;
                  onChanged?.call(v);
                },
                items: (f, cs) => bankInfoList,
                filterFn: (bankInfos, filter) {
                  // Implement the filter function to match the bankInfos name
                  if (filter.isEmpty) return true;

                  String cleanedFilter = filter.toLowerCase().trim();
                  String countryName = bankInfos.name.toLowerCase();

                  // Check for matches in the country name
                  return countryName.contains(cleanedFilter);
                },
                compareFn: (BankInfos? item1, BankInfos? item2) {
                  if (item1 == null && item2 == null) {
                    return false;
                  }
                  return item1?.id == item2?.id;
                },
                popupProps: PopupProps.menu(
                    itemBuilder: (context, item, isDisabled, isSelected) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item.name,
                            style: CustomStyle.lightHeading3TextStyle),
                      );
                    },
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        hintText: Get.find<LanguageController>()
                            .getTranslation('Select Bank'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    constraints: BoxConstraints(
                      maxHeight: 450.h,
                    ),
                    showSearchBox: true,
                    containerBuilder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                          color: CustomColor.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: child,
                      );
                    }),
                dropdownBuilder: (context, selectedItem) {
                  return Text(
                    isTapped ? selectedItem?.name ?? "" : "Select Bank",
                    style: GoogleFonts.inter(
                        fontSize: Dimensions.headingTextSize4,
                        fontWeight: FontWeight.w600,
                        color: isTapped
                            ? CustomColor.primaryLightColor
                            : CustomColor.cardLightTextColor),
                  );
                },
                // decoratorProps: const DropDownDecoratorProps(
              ),
            ),
          )
        : Container();
  }
}

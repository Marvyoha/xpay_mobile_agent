import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrpay/utils/basic_screen_imports.dart';

import '../../../backend/model/recipient/common/saved_recipient_info_model.dart';
// import '../../../utils/custom_color.dart';
// import '../../../utils/custom_style.dart';
// import '../../../utils/dimensions.dart';

class ReceiverCountryDropDown extends StatelessWidget {
  final RxString selectMethod;
  final List<ReceiverCountry> itemsList;
  final void Function(ReceiverCountry?)? onChanged;

  const ReceiverCountryDropDown({
    required this.itemsList,
    Key? key,
    required this.selectMethod,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: Dimensions.inputBoxHeight * 0.75,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
          ),
          child: DropdownButtonHideUnderline(
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 20),
              child: DropdownButton(
                dropdownColor: CustomColor.whiteColor,
                hint: Padding(
                  padding: EdgeInsets.only(left: Dimensions.paddingSize * 0.7),
                  child: Text(
                    selectMethod.value,
                    style: GoogleFonts.inter(
                        fontSize: Dimensions.headingTextSize4,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                icon: const Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: CustomColor.primaryTextColor,
                  ),
                ),
                isExpanded: true,
                underline: Container(),
                borderRadius: BorderRadius.circular(Dimensions.radius),
                items:
                    itemsList.map<DropdownMenuItem<ReceiverCountry>>((value) {
                  return DropdownMenuItem<ReceiverCountry>(
                    value: value,
                    child: Text(
                        "${value.name.toString()} (${value.code.toString()})",
                        // "${value.name.toString()} (${value.code.toString()})",
                        style: CustomStyle.lightHeading3TextStyle),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ));
  }
}

class ReceiverCountryDropdownSearch extends StatelessWidget {
  final RxString selectMethod;
  final List<ReceiverCountry> itemsList;
  final void Function(ReceiverCountry?)? onChanged;

  const ReceiverCountryDropdownSearch({
    required this.itemsList,
    super.key,
    required this.selectMethod,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return itemsList.isNotEmpty
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
              child: DropdownSearch<ReceiverCountry>(
                selectedItem: itemsList.firstWhere(
                  (item) {
                    // Extract just the country name from selectMethod if it contains parentheses
                    String selectedName = selectMethod.value;
                    if (selectedName.contains("(")) {
                      selectedName = selectedName
                          .substring(0, selectedName.indexOf("("))
                          .trim();
                    }
                    return item.name == selectedName ||
                        "${item.name} (${item.code})" == selectMethod.value;
                  },
                  orElse: () => itemsList.first,
                ),
                onChanged: onChanged,
                items: (f, cs) => itemsList,
                filterFn: (country, filter) {
                  // Implement the filter function to match the country name
                  if (filter.isEmpty) return true;

                  String cleanedFilter = filter.toLowerCase().trim();
                  String countryName = country.name.toLowerCase();

                  // Check for matches in the country name
                  return countryName.contains(cleanedFilter);
                },
                compareFn: (ReceiverCountry? item1, ReceiverCountry? item2) {
                  if (item1 == null && item2 == null) {
                    return false;
                  }
                  return item1?.id == item2?.id;
                },
                popupProps: PopupProps.menu(
                    itemBuilder: (context, item, isDisabled, isSelected) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item.country,
                            style: CustomStyle.lightHeading3TextStyle),
                      );
                    },
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        hintText: "Search",
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
                    selectedItem?.country ?? "",
                    style: GoogleFonts.inter(
                        fontSize: Dimensions.headingTextSize4,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.primaryLightColor),
                  );
                },
                // decoratorProps: const DropDownDecoratorProps(
              ),
            ),
          )
        : Container();
  }
}

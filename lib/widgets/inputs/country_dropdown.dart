import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../backend/model/remittance/remittance_info_model.dart';
import '../../utils/custom_color.dart';
import '../../utils/custom_style.dart';
import '../../utils/dimensions.dart';

class CountryDropDown extends StatelessWidget {
  final RxString selectMethod;
  final List<Country> itemsList;
  final void Function(Country?)? onChanged;

  const CountryDropDown({
    required this.itemsList,
    super.key,
    required this.selectMethod,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: Dimensions.inputBoxHeight * 0.75,
          decoration: BoxDecoration(
            border: Border.all(
              color: CustomColor.primaryLightColor,
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
                        color: CustomColor.primaryLightColor),
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
                items: itemsList.map<DropdownMenuItem<Country>>((value) {
                  return DropdownMenuItem<Country>(
                    value: value,
                    child: Text(
                      value.country.toString(),
                      style: CustomStyle.lightHeading3TextStyle,
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ));
  }
}

class CountryDropDownSearch extends StatelessWidget {
  final RxString selectMethod;
  final List<Country> itemsList;
  final void Function(Country?)? onChanged;

  const CountryDropDownSearch({
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
              child: DropdownSearch<Country>(
                selectedItem: itemsList.firstWhere(
                  (item) => item.name == selectMethod.value,
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
                compareFn: (Country? item1, Country? item2) {
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
                    selectedItem?.name ?? "",
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

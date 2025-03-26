import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrpay/backend/model/auth/registation/basic_data_model.dart';
import 'package:qrpay/utils/basic_screen_imports.dart';
// import 'package:qrpay/utils/size.dart';
import '../../controller/categories/mobile_topup/mobile_topup_controller.dart';
// import '../../language/english.dart';
// import '../../utils/custom_color.dart';
// import '../../utils/custom_style.dart';
// import '../../utils/dimensions.dart';
// import '../text_labels/title_heading4_widget.dart';

final mobileTopupController = Get.put(MobileTopupController());

// ignore: must_be_immutable
class TopUpPhoneNumberInputWidget extends StatefulWidget {
  final String hint, label;
  final RxString countryCode;
  final RxString isoCode;
  final int maxLines;
  final bool isValidator;
  final bool readOnly;
  final TextInputType? keyBoardType;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final EdgeInsetsGeometry? paddings;
  final TextEditingController controller;
  Function(PointerDownEvent)? onTapOutside;

  TopUpPhoneNumberInputWidget({
    super.key,
    required this.controller,
    required this.hint,
    this.isValidator = true,
    this.maxLines = 1,
    this.paddings,
    required this.label,
    this.readOnly = false,
    required this.countryCode,
    required this.isoCode,
    this.keyBoardType,
    this.textInputAction,
    this.onTapOutside,
    this.onFieldSubmitted,
  });

  @override
  State<TopUpPhoneNumberInputWidget> createState() =>
      _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<TopUpPhoneNumberInputWidget> {
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleHeading4Widget(
          text: widget.label,
          fontWeight: FontWeight.w600,
        ),
        verticalSpace(7),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Obx(
                () => Container(
                  height: Dimensions.inputBoxHeight * 0.75,
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: CustomColor.primaryLightColor,
                    //   width: 2,
                    // ),
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius * 0.7),
                  ),
                  child: DropdownSearch<Country>(
                    selectedItem: mobileTopupController
                        .basicDataModel.data.countries
                        .firstWhere(
                      (item) => item.mobileCode == widget.countryCode.value,
                      orElse: () => mobileTopupController
                          .basicDataModel.data.countries.first,
                    ),
                    onChanged: (Country? value) {
                      if (value != null) {
                        mobileTopupController.countryCode.value =
                            value.mobileCode;
                        widget.countryCode.value = value.mobileCode;
                        widget.isoCode.value = value.iso2;
                      }
                    },
                    filterFn: (country, filter) {
                      if (filter.isEmpty) return true;

                      String cleanedFilter = filter.toLowerCase().trim();
                      String countryName = country.name.toLowerCase();

                      // Check for matches in the name or mobile code
                      return countryName.contains(cleanedFilter) ||
                          country.mobileCode
                              .toLowerCase()
                              .contains(cleanedFilter);
                    },
                    compareFn: (Country? item1, Country? item2) {
                      if (item1 == null && item2 == null) {
                        return true;
                      }
                      return item1?.mobileCode == item2?.mobileCode;
                    },
                    popupProps: PopupProps.menu(
                      itemBuilder: (context, item, isDisabled, isSelected) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '(${item.mobileCode}) ${item.name}',
                            style: CustomStyle.lightHeading5TextStyle,
                          ),
                        );
                      },
                      searchFieldProps: TextFieldProps(
                        cursorColor: CustomColor.primaryLightColor,
                        decoration: InputDecoration(
                          hintText: "Search Country",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: CustomColor.primaryLightColor),
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
                      },
                    ),
                    items: (f, cs) =>
                        mobileTopupController.basicDataModel.data.countries,
                    dropdownBuilder: (context, selectedItem) {
                      return Text(selectedItem?.mobileCode ?? "",
                          style: CustomStyle.lightHeading5TextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: CustomColor.primaryTextColor,
                          ));
                    },
                  ),
                ),
              ),
            ),
            horizontalSpace(Dimensions.widthSize),
            Expanded(
              flex: 5,
              child: TextFormField(
                keyboardType: widget.keyBoardType,
                textInputAction: widget.textInputAction,
                validator: widget.isValidator == false
                    ? null
                    : (String? value) {
                        if (value!.isEmpty) {
                          return Strings.pleaseFillOutTheField;
                        } else {
                          return null;
                        }
                      },
                controller: widget.controller,
                onTap: () {
                  setState(() {
                    focusNode!.requestFocus();
                  });
                },
                onFieldSubmitted: (value) {
                  if (widget.onFieldSubmitted != null) {
                    widget.onFieldSubmitted!(value);
                  }
                  setState(() {
                    focusNode!.unfocus();
                  });
                },
                onTapOutside: widget.onTapOutside,
                focusNode: focusNode,
                textAlign: TextAlign.left,
                style: CustomStyle.darkHeading4TextStyle.copyWith(
                  color: CustomColor.primaryTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.headingTextSize3,
                ),
                cursorColor: CustomColor.primaryLightColor,
                readOnly: widget.readOnly,
                maxLines: widget.maxLines,
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: GoogleFonts.inter(
                    fontSize: Dimensions.headingTextSize3,
                    fontWeight: FontWeight.w500,
                    color: Get.isDarkMode
                        ? CustomColor.primaryDarkTextColor
                            .withValues(alpha: 0.2)
                        : CustomColor.primaryTextColor.withValues(alpha: 0.2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius * 0.7),
                    borderSide: BorderSide(
                      color:
                          CustomColor.primaryLightColor.withValues(alpha: 0.2),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius * 0.7),
                    borderSide: const BorderSide(
                        width: 2, color: CustomColor.primaryLightColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius * 0.7),
                    borderSide: const BorderSide(
                        width: 2, color: CustomColor.whiteColor),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Dimensions.widthSize * 1.7,
                    vertical: Dimensions.heightSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// // ignore: must_be_immutable
// class OldTopUpPhoneNumberInputWidget extends StatefulWidget {
//   final String hint, label;
//   final RxString countryCode;
//   final RxString isoCode;
//   final int maxLines;
//   final bool isValidator;
//   final bool readOnly;
//   final TextInputType? keyBoardType;
//   final TextInputAction? textInputAction;
//   final Function(String)? onFieldSubmitted;
//   final EdgeInsetsGeometry? paddings;
//   final TextEditingController controller;
//   Function(PointerDownEvent)? onTapOutside;
//   OldTopUpPhoneNumberInputWidget({
//     super.key,
//     required this.controller,
//     required this.hint,
//     this.isValidator = true,
//     this.maxLines = 1,
//     this.paddings,
//     required this.label,
//     this.readOnly = false,
//     required this.countryCode,
//     required this.isoCode,
//     this.keyBoardType,
//     this.textInputAction,
//     this.onTapOutside,
//     this.onFieldSubmitted,
//   });

//   @override
//   State<OldTopUpPhoneNumberInputWidget> createState() =>
//       _PrimaryInputWidgetState();
// }

// class _PrimaryInputWidgetState extends State<OldTopUpPhoneNumberInputWidget> {
//   FocusNode? focusNode;

//   @override
//   void initState() {
//     super.initState();
//     focusNode = FocusNode();
//   }

//   @override
//   void dispose() {
//     focusNode!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TitleHeading4Widget(
//           text: widget.label,
//           fontWeight: FontWeight.w600,
//         ),
//         verticalSpace(7),
//         TextFormField(
//           keyboardType: widget.keyBoardType,
//           textInputAction: widget.textInputAction,
//           validator: widget.isValidator == false
//               ? null
//               : (String? value) {
//                   if (value!.isEmpty) {
//                     return Strings.pleaseFillOutTheField;
//                   } else {
//                     return null;
//                   }
//                 },
//           controller: widget.controller,
//           onTap: () {
//             setState(
//               () {
//                 focusNode!.requestFocus();
//               },
//             );
//           },
//           onFieldSubmitted: (value) {
//             widget.onFieldSubmitted!(value);
//             setState(() {
//               focusNode!.unfocus();
//             });
//           },
//           onTapOutside: widget.onTapOutside,
//           focusNode: focusNode,
//           textAlign: TextAlign.left,
//           style: CustomStyle.darkHeading4TextStyle.copyWith(
//             color: CustomColor.primaryTextColor,
//             fontWeight: FontWeight.w600,
//             fontSize: Dimensions.headingTextSize3,
//           ),
//           cursorColor: CustomColor.primaryLightColor,
//           readOnly: widget.readOnly,
//           maxLines: widget.maxLines,
//           decoration: InputDecoration(
//             hintText: widget.hint,
//             hintStyle: GoogleFonts.inter(
//               fontSize: Dimensions.headingTextSize3,
//               fontWeight: FontWeight.w500,
//               color: Get.isDarkMode
//                   ? CustomColor.primaryDarkTextColor.withValues(alpha: 0.2)
//                   : CustomColor.primaryTextColor.withValues(alpha: 0.2),
//             ),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
//                 borderSide: BorderSide(
//                   color: CustomColor.primaryLightColor.withValues(alpha: 0.2),
//                 )),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
//               borderSide: const BorderSide(
//                   width: 2, color: CustomColor.primaryLightColor),
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
//               borderSide:
//                   const BorderSide(width: 2, color: CustomColor.whiteColor),
//             ),
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: Dimensions.widthSize * 1.7,
//               vertical: Dimensions.heightSize,
//             ),
//             prefixIcon: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: Dimensions.marginSizeHorizontal * 0.5),
//                   child: Obx(
//                     () => InkWell(
//                       onTap: () => _openDialogue(context),
//                       child: TitleHeading3Widget(
//                         text: widget.countryCode.value,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                     width: 1.6,
//                     height: Dimensions.heightSize * 2,
//                     color: CustomColor.primaryTextColor),
//                 horizontalSpace(Dimensions.widthSize)
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   _openDialogue(
//     BuildContext context,
//   ) {
//     return showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         backgroundColor: Colors.transparent,
//         alignment: Alignment.center,
//         insetPadding: EdgeInsets.all(Dimensions.paddingSize * 0.3),
//         contentPadding: EdgeInsets.zero,
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         content: Stack(
//           children: [
//             Container(
//               padding: EdgeInsets.only(
//                 left: Dimensions.paddingSize * 0.7,
//                 top: Dimensions.marginSizeVertical,
//                 bottom: Dimensions.marginSizeVertical * 0.5,
//                 right: Dimensions.paddingSize * 0.3,
//               ),
//               decoration: BoxDecoration(
//                   color: CustomColor.blackColor,
//                   borderRadius: BorderRadius.circular(Dimensions.radius)),
//               height: MediaQuery.of(context).size.height * 0.5,
//               width: MediaQuery.of(context).size.width * 0.8,
//               alignment: Alignment.bottomCenter,
//               child: ListView.builder(
//                   itemCount:
//                       mobileTopupController.basicDataModel.data.countries.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     var data = mobileTopupController.basicDataModel.data.countries;
//                     var code = mobileTopupController
//                         .basicDataModel.data.countries[index].mobileCode;

//                     return InkWell(
//                       highlightColor: Colors.yellow.withValues(alpha: 0.9),
//                       splashColor: Colors.red.withValues(alpha: 0.8),
//                       focusColor: Colors.green.withValues(alpha: 0.0),
//                       hoverColor: Colors.blue.withValues(alpha: 0.8),
//                       onTap: () {
//                         mobileTopupController.countryCode.value = code;
//                         widget.countryCode.value = code;
//                         widget.isoCode.value = data[index].iso2;

//                         Get.back();
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                             vertical: Dimensions.paddingSize * 0.5),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               flex: 2,
//                               child: TitleHeading3Widget(
//                                 text: data[index].mobileCode,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             Expanded(
//                               flex: 5,
//                               child: TitleHeading3Widget(
//                                 text: data[index].name,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//             ),
//             Positioned(
//               right: 15,
//               top: 15,
//               child: IconButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 icon: Icon(
//                   Icons.close,
//                   size: Dimensions.heightSize * 2.4,
//                   color: CustomColor.whiteColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

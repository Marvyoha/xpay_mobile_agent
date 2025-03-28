import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrpay/controller/auth/registration/kyc_form_controller.dart';
import 'package:qrpay/controller/categories/remittance/add_recipient_controller.dart';
import 'package:qrpay/utils/size.dart';
import 'package:qrpay/widgets/text_labels/title_heading4_widget.dart';

import '../../../language/english.dart';
import '../../../utils/custom_color.dart';
import '../../../utils/custom_style.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/text_labels/title_heading3_widget.dart';

final addRecipientController = Get.put(AddRecipientController());
final basicDataController = Get.put(BasicDataController());

// class RecipientPhoneNumberInputWidget extends StatefulWidget {
//   final String hint, label;
//   final RxString countryCode;

//   final int maxLines;
//   final bool isValidator;
//   final bool readOnly;
//   final TextInputType? keyBoardType;
//   final TextInputAction? textInputAction;
//   final Function(String)? onFieldSubmitted;
//   final EdgeInsetsGeometry? paddings;
//   final TextEditingController controller;
//   Function(PointerDownEvent)? onTapOutside;

//   RecipientPhoneNumberInputWidget({
//     super.key,
//     required this.controller,
//     required this.hint,
//     this.isValidator = true,
//     this.maxLines = 1,
//     this.paddings,
//     required this.label,
//     this.readOnly = false,
//     required this.countryCode,
//     this.keyBoardType,
//     this.textInputAction,
//     this.onTapOutside,
//     this.onFieldSubmitted,
//   });

//   @override
//   State<RecipientPhoneNumberInputWidget> createState() =>
//       _PrimaryInputWidgetState();
// }

// class _PrimaryInputWidgetState extends State<RecipientPhoneNumberInputWidget> {
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
//         Row(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Obx(
//                 () => Container(
//                   height: Dimensions.inputBoxHeight * 0.75,
//                   decoration: BoxDecoration(
//                     // border: Border.all(
//                     //   color: CustomColor.primaryLightColor,
//                     //   width: 2,
//                     // ),
//                     borderRadius:
//                         BorderRadius.circular(Dimensions.radius * 0.7),
//                   ),
//                   child: DropdownSearch<Country>(
//                     selectedItem: basicDataController
//                         .basicDataModel.data.countries
//                         .firstWhere(
//                       (item) => item.mobileCode == widget.countryCode.value,
//                       orElse: () => basicDataController
//                           .basicDataModel.data.countries.first,
//                     ),
//                     onChanged: (Country? value) {
//                       if (value != null) {
//                         addRecipientController.numberCode.value =
//                             value.mobileCode;
//                         widget.countryCode.value = value.mobileCode;
//                       }
//                     },
//                     filterFn: (country, filter) {
//                       if (filter.isEmpty) return true;

//                       String cleanedFilter = filter.toLowerCase().trim();
//                       String countryName = country.name.toLowerCase();

//                       // Check for matches in the name or mobile code
//                       return countryName.contains(cleanedFilter) ||
//                           country.mobileCode
//                               .toLowerCase()
//                               .contains(cleanedFilter);
//                     },
//                     compareFn: (Country? item1, Country? item2) {
//                       if (item1 == null && item2 == null) {
//                         return true;
//                       }
//                       return item1?.mobileCode == item2?.mobileCode;
//                     },
//                     popupProps: PopupProps.menu(
//                       itemBuilder: (context, item, isDisabled, isSelected) {
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             '(${item.mobileCode}) ${item.name}',
//                             style: CustomStyle.lightHeading5TextStyle,
//                           ),
//                         );
//                       },
//                       searchFieldProps: TextFieldProps(
//                         cursorColor: CustomColor.primaryLightColor,
//                         decoration: InputDecoration(
//                           hintText: "Search Country",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: const BorderSide(
//                                 color: CustomColor.primaryLightColor),
//                           ),
//                         ),
//                       ),
//                       constraints: BoxConstraints(
//                         maxHeight: 450.h,
//                       ),
//                       showSearchBox: true,
//                       containerBuilder: (context, child) {
//                         return Container(
//                           decoration: BoxDecoration(
//                             color: CustomColor.whiteColor,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: child,
//                         );
//                       },
//                     ),
//                     items: (f, cs) =>
//                         basicDataController.basicDataModel.data.countries,
//                     dropdownBuilder: (context, selectedItem) {
//                       return Text(selectedItem?.mobileCode ?? "",
//                           style: CustomStyle.lightHeading5TextStyle.copyWith(
//                             fontWeight: FontWeight.w600,
//                             color: CustomColor.primaryTextColor,
//                           ));
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             horizontalSpace(Dimensions.widthSize),
//             Expanded(
//               flex: 5,
//               child: TextFormField(
//                 keyboardType: widget.keyBoardType,
//                 textInputAction: widget.textInputAction,
//                 validator: widget.isValidator == false
//                     ? null
//                     : (String? value) {
//                         if (value!.isEmpty) {
//                           return Strings.pleaseFillOutTheField;
//                         } else {
//                           return null;
//                         }
//                       },
//                 controller: widget.controller,
//                 onTap: () {
//                   setState(() {
//                     focusNode!.requestFocus();
//                   });
//                 },
//                 onFieldSubmitted: (value) {
//                   if (widget.onFieldSubmitted != null) {
//                     widget.onFieldSubmitted!(value);
//                   }
//                   setState(() {
//                     focusNode!.unfocus();
//                   });
//                 },
//                 onTapOutside: widget.onTapOutside,
//                 focusNode: focusNode,
//                 textAlign: TextAlign.left,
//                 style: CustomStyle.darkHeading4TextStyle.copyWith(
//                   color: CustomColor.primaryTextColor,
//                   fontWeight: FontWeight.w600,
//                   fontSize: Dimensions.headingTextSize3,
//                 ),
//                 cursorColor: CustomColor.primaryLightColor,
//                 readOnly: widget.readOnly,
//                 maxLines: widget.maxLines,
//                 decoration: InputDecoration(
//                   hintText: widget.hint,
//                   hintStyle: GoogleFonts.inter(
//                     fontSize: Dimensions.headingTextSize3,
//                     fontWeight: FontWeight.w500,
//                     color: Get.isDarkMode
//                         ? CustomColor.primaryDarkTextColor
//                             .withValues(alpha: 0.2)
//                         : CustomColor.primaryTextColor.withValues(alpha: 0.2),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(Dimensions.radius * 0.7),
//                     borderSide: BorderSide(
//                       color:
//                           CustomColor.primaryLightColor.withValues(alpha: 0.2),
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(Dimensions.radius * 0.7),
//                     borderSide: const BorderSide(
//                         width: 2, color: CustomColor.primaryLightColor),
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(Dimensions.radius * 0.7),
//                     borderSide: const BorderSide(
//                         width: 2, color: CustomColor.whiteColor),
//                   ),
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: Dimensions.widthSize * 1.7,
//                     vertical: Dimensions.heightSize,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

class RecipientPhoneNumberInputWidget extends StatefulWidget {
  final String hint, label;
  final RxString countryCode;
  final int maxLines;
  final bool isValidator;
  final bool readOnly;
  final TextInputType? keyBoardType;
  final TextInputAction? textInputAction;

  final EdgeInsetsGeometry? paddings;
  final TextEditingController controller;

  const RecipientPhoneNumberInputWidget({
    Key? key,
    required this.controller,
    required this.hint,
    this.isValidator = true,
    this.maxLines = 1,
    this.paddings,
    required this.label,
    this.readOnly = false,
    required this.countryCode,
    this.keyBoardType,
    this.textInputAction,
  }) : super(key: key);

  @override
  State<RecipientPhoneNumberInputWidget> createState() =>
      _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<RecipientPhoneNumberInputWidget> {
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
        TextFormField(
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
            setState(
              () {
                focusNode!.requestFocus();
              },
            );
          },
          onFieldSubmitted: (value) {
            setState(() {
              focusNode!.unfocus();
            });
          },
          focusNode: focusNode,
          textAlign: TextAlign.left,
          style: CustomStyle.darkHeading4TextStyle.copyWith(
            color: CustomColor.primaryTextColor,
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.headingTextSize3,
          ),
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: GoogleFonts.inter(
              fontSize: Dimensions.headingTextSize3,
              fontWeight: FontWeight.w500,
              color: CustomColor.primaryTextColor.withValues(alpha: 0.2),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                )),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
              borderSide:
                  BorderSide(width: 2, color: Theme.of(context).primaryColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
              borderSide:
                  const BorderSide(width: 2, color: CustomColor.whiteColor),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.widthSize * 1.7,
              vertical: Dimensions.heightSize,
            ),
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.marginSizeHorizontal * 0.5),
                  child: Obx(
                    () => TitleHeading3Widget(text: widget.countryCode.value),
                  ),
                ),
                Container(
                    width: 1.6,
                    height: Dimensions.heightSize * 2,
                    color: CustomColor.primaryTextColor),
                horizontalSpace(Dimensions.widthSize)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

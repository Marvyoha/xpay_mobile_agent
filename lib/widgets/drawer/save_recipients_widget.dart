// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrpay/language/language_controller.dart';
import 'package:qrpay/utils/custom_color.dart';
import 'package:qrpay/utils/custom_style.dart';
// import 'package:qrpay/widgets/others/custom_glass/custom_glass_widget.dart';
import 'package:qrpay/widgets/text_labels/custom_title_heading_widget.dart';
import 'package:qrpay/widgets/text_labels/title_heading3_widget.dart';

import '../../utils/dimensions.dart';
import '../../utils/size.dart';
import '../text_labels/title_heading4_widget.dart';

class SaveRecipientWidget extends StatelessWidget {
  SaveRecipientWidget({
    super.key,
    required this.isSender,
    required this.title,
    required this.subTitle,
    required this.type,
    required this.onTap,
  });
  bool isSender;
  final String title, subTitle, type;
  final void Function(String?) onTap;

  @override
  Widget build(BuildContext context) {
    final List<String> moreList = isSender == false
        ? [
            "Edit Recipient",
            "Remove Recipient",
            // "Send"
          ]
        : [
            "Edit Sender",
            "Remove Sender",
            // "Send"
          ];
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.marginSizeVertical * 0.3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
        ),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSize * 0.2),
        height: Dimensions.heightSize * 6,
        child: Row(
          children: [
            horizontalSpace(Dimensions.marginSizeHorizontal * .4),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: crossStart,
                mainAxisAlignment: mainCenter,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TitleHeading3Widget(
                          text: title,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                      horizontalSpace(Dimensions.paddingSize * .5),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSize * .3,
                          vertical: Dimensions.paddingSize * .1,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius),
                          color: CustomColor.yellowColor,
                        ),
                        child: TitleHeading4Widget(
                          text: Get.find<LanguageController>().getTranslation(
                            convertToCamelCase(type),
                          ),
                          color: CustomColor.blackColor,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(Dimensions.widthSize * 0.7),
                  CustomTitleHeadingWidget(
                    text: subTitle,
                    style: CustomStyle.darkHeading4TextStyle.copyWith(
                        fontSize: Dimensions.headingTextSize5,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  onTap(value);
                },
                itemBuilder: (BuildContext context) {
                  return moreList.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(
                        choice,
                        style: GoogleFonts.inter(
                          fontSize: Dimensions.headingTextSize3,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList();
                },
                icon: Icon(
                  Icons.more_vert,
                  size: Dimensions.heightSize * 2,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _showDialog(BuildContext context) {
  //   showDialog(
  //       // barrierColor: CustomColor.whiteColor.withValues(alpha:0.8),
  //       barrierColor: Colors.transparent,
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (context) {
  //         return GestureDetector(
  //             onTap: () {
  //               Get.back();
  //             },
  //             child: Container(
  //               padding: const EdgeInsets.all(30),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: List.generate(
  //                   moreList.length,
  //                   (index) => Container(
  //                     alignment: Alignment.centerLeft,
  //                     width: MediaQuery.of(context).size.width * 0.6,
  //                     color:
  //                         Theme.of(context).primaryColor.withValues(alpha: 0.1),
  //                     padding: EdgeInsets.symmetric(
  //                         horizontal: Dimensions.widthSize * 1,
  //                         vertical: Dimensions.heightSize * 0.1),
  //                     child: TextButton(
  //                         onPressed: () {
  //                           onTap(moreList[index]);
  //                         },
  //                         child: Row(
  //                           children: [
  //                             Text(
  //                               moreList[index],
  //                               style: GoogleFonts.inter(
  //                                 fontSize: Dimensions.headingTextSize3,
  //                                 color: Theme.of(context).primaryColor,
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                             ),
  //                           ],
  //                         )),
  //                   ).customGlassWidget(
  //                       tintColor: Theme.of(context)
  //                           .primaryColor
  //                           .withValues(alpha: 0.2),
  //                       clipBorderRadius: BorderRadius.only(
  //                         bottomLeft: Radius.circular(
  //                             index == 2 ? Dimensions.radius * 0.6 : 0),
  //                         bottomRight: Radius.circular(
  //                             index == 2 ? Dimensions.radius * 0.6 : 0),
  //                         topLeft: Radius.circular(
  //                             index == 0 ? Dimensions.radius * 0.6 : 0),
  //                         topRight: Radius.circular(
  //                             index == 0 ? Dimensions.radius * 0.6 : 0),
  //                       )),
  //                 ),
  //               ),
  //             ));
  //       });
  // }

  String convertToCamelCase(String input) {
    List<String> parts = input.split(' ');
    String camelCase = parts.first.toLowerCase() +
        parts
            .sublist(1)
            .map((part) =>
                part[0].toUpperCase() + part.substring(1).toLowerCase())
            .join();
    return camelCase;
  }
}

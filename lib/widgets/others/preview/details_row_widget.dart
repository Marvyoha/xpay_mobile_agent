import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrpay/utils/custom_color.dart';

import '../../../utils/custom_style.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/size.dart';
import '../../text_labels/custom_title_heading_widget.dart';

class DetailsRowWidget extends StatelessWidget {
  const DetailsRowWidget(
      {super.key,
      required this.variable,
      required this.value,
      this.fontSizeValue});

  final String variable, value;
  final double? fontSizeValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Dimensions.marginSizeVertical * 0.4,
      ),
      child: Row(
        mainAxisAlignment: mainSpaceBet,
        children: [
          CustomTitleHeadingWidget(
            text: variable,
            style: CustomStyle.darkHeading4TextStyle.copyWith(
              color: Get.isDarkMode
                  ? CustomColor.primaryDarkTextColor
                  : Theme.of(context).primaryColor.withValues(alpha:0.4),
            ),
          ),
          CustomTitleHeadingWidget(
            text: value,
            style: Get.isDarkMode
                ? CustomStyle.darkHeading4TextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: fontSizeValue ?? Dimensions.headingTextSize3,
                  )
                : CustomStyle.lightHeading4TextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
          ),
        ],
      ),
    );
  }
}

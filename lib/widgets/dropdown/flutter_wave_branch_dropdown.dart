import 'package:google_fonts/google_fonts.dart';
import 'package:qrpay/utils/basic_screen_imports.dart';
import 'package:qrpay/utils/custom_switch_loading_api.dart';

import '../../controller/categories/withdraw_controller/withdraw_controller.dart';
import '../../language/language_controller.dart';

class FlutterWaveBanksBranchesDropDown extends StatefulWidget {
  const FlutterWaveBanksBranchesDropDown({super.key});

  @override
  State<FlutterWaveBanksBranchesDropDown> createState() =>
      _FlutterWaveBanksBranchesDropDownState();
}

class _FlutterWaveBanksBranchesDropDownState
    extends State<FlutterWaveBanksBranchesDropDown> {
  final FocusNode focusNode = FocusNode();
  final controller = Get.put(WithdrawController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void _openBankSearch() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        maxChildSize: 1,
        initialChildSize: 0.8,
        minChildSize: 0.8,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Dimensions.radius * 2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BackButton(),
                  horizontalSpace(Dimensions.widthSize * 6),
                  const TitleHeading3Widget(
                    text: Strings.selectBranch,
                  ),
                ],
              ),
              PrimaryInputWidget(
                controller: controller.branchNameController,
                hint: Get.find<LanguageController>()
                    .getTranslation(Strings.search),
                label: '',
                prefixIcon: const Icon(Icons.search),
                onChanged: (value) {
                  controller.filterBranch(value);
                },
                radius: Dimensions.radius,
              ),
              Expanded(
                child: Obx(() {
                  return controller.branch.value.isEmpty
                      ? Container(
                          margin: EdgeInsets.symmetric(
                            vertical: Dimensions.marginSizeVertical * 0.4,
                          ),
                          child: const Center(
                            child: TitleHeading4Widget(
                              text: Strings.noBranchFound,
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: scrollController,
                          itemCount: controller.branch.value.length,
                          itemBuilder: (_, index) {
                            var data = controller.branch.value[index];
                            return ListTile(
                              title: TitleHeading4Widget(text: data.branchName),
                              onTap: () {
                                controller.selectFlutterWaveBankBranchCode
                                    .value = data.branchCode;
                                controller.selectFlutterWaveBankBranchName
                                    .value = data.branchName;

                                controller.branchNameController.text =
                                    data.branchName;

                                controller.isBranchSearchEnable.value = false;
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isBranchLoading
          ? const CustomSwitchLoading()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleHeading4Widget(
                  text: Strings.bankBranch.tr,
                  fontWeight: FontWeight.w600,
                ),
                verticalSpace(Dimensions.heightSize * .8),
                const SizedBox(height: 7),
                TextFormField(
                  controller: controller.branchNameController,
                  readOnly: true,
                  onTap: _openBankSearch,
                  decoration: InputDecoration(
                    hintText: Get.find<LanguageController>()
                        .getTranslation(Strings.enterBranchName),
                    hintStyle: GoogleFonts.inter(
                      fontSize: Dimensions.headingTextSize3,
                      fontWeight: FontWeight.w500,
                      color:
                          CustomColor.primaryTextColor.withValues(alpha: 0.2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius * 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius * 0.5),
                      borderSide: BorderSide(
                        color: CustomColor.primaryLightColor
                            .withValues(alpha: 0.2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius * 0.5),
                      borderSide: const BorderSide(
                          width: 2, color: CustomColor.primaryLightColor),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: Dimensions.widthSize * 1.7,
                      vertical: Dimensions.heightSize,
                    ),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                      size: Dimensions.iconSizeLarge,
                      color: CustomColor.primaryLightColor,
                    ),
                  ),
                ),
                verticalSpace(Dimensions.heightSize)
              ],
            ),
    );
  }
}

// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../backend/model/categories/withdraw/flutter_wave_bank_branch_model.dart';
// import '../../language/language_controller.dart';
// import '../../utils/basic_screen_imports.dart';

// class FlutterWaveBanksBranchesDropDown extends StatelessWidget {
//   final RxString selectMethod;
//   final List<BankBranch> bankBranchInfoList;
//   final void Function(BankBranch?)? onChanged;

//   const FlutterWaveBanksBranchesDropDown({
//     required this.bankBranchInfoList,
//     super.key,
//     required this.selectMethod,
//     this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return bankBranchInfoList.isNotEmpty
//         ? Obx(
//             () => Container(
//               height: Dimensions.inputBoxHeight * 0.75,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: CustomColor.primaryLightColor,
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
//               ),
//               child: DropdownSearch<BankBranch>(
//                 selectedItem: bankBranchInfoList.firstWhere(
//                   (item) => item.branchName == selectMethod.value,
//                   orElse: () => bankBranchInfoList.first,
//                 ),
//                 onChanged: onChanged,
//                 items: (f, cs) => bankBranchInfoList,
//                 filterFn: (bankBranch, filter) {
//                   if (filter.isEmpty) return true;

//                   String cleanedFilter = filter.toLowerCase().trim();
//                   String countryName = bankBranch.branchName.toLowerCase();

//                   // Check for matches in the country name
//                   return countryName.contains(cleanedFilter);
//                 },
//                 compareFn: (BankBranch? item1, BankBranch? item2) {
//                   if (item1 == null && item2 == null) {
//                     return false;
//                   }
//                   return item1?.id == item2?.id;
//                 },
//                 popupProps: PopupProps.menu(
//                     itemBuilder: (context, item, isDisabled, isSelected) {
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(item.branchName,
//                             style: CustomStyle.lightHeading3TextStyle),
//                       );
//                     },
//                     searchFieldProps: TextFieldProps(
//                       decoration: InputDecoration(
//                         hintText: Get.find<LanguageController>()
//                             .getTranslation('Select Bank Branch'),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: const BorderSide(color: Colors.blue),
//                         ),
//                       ),
//                     ),
//                     constraints: BoxConstraints(
//                       maxHeight: 450.h,
//                     ),
//                     showSearchBox: true,
//                     containerBuilder: (context, child) {
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: CustomColor.whiteColor,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: child,
//                       );
//                     }),
//                 dropdownBuilder: (context, selectedItem) {
//                   return Text(
//                     selectedItem?.branchName ?? "",
//                     style: GoogleFonts.inter(
//                         fontSize: Dimensions.headingTextSize4,
//                         fontWeight: FontWeight.w600,
//                         color: CustomColor.primaryLightColor),
//                   );
//                 },
//                 // decoratorProps: const DropDownDecoratorProps(
//               ),
//             ),
//           )
//         : Container();
//   }
// }

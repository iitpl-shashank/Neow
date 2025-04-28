import 'package:flutter/material.dart';
import 'package:naveli_2023/utils/common_utils.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/i18n.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/local_images.dart';
import '../../../../../widgets/common_appbar.dart';
import '../../../../../widgets/common_text_field.dart';
import '../../../../../widgets/primary_button.dart';
import '../../../../../widgets/scaffold_bg.dart';
import 'ailments_view_model.dart';
import '../medication/medication_view.dart';

class AilmentsView extends StatefulWidget {
  const AilmentsView({super.key});

  @override
  State<AilmentsView> createState() => _AilmentsViewState();
}

class _AilmentsViewState extends State<AilmentsView> {
  late AilmentsViewModel mViewModel;
  final otherAilmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getAilmentListApi();
    });
  }

  Future<void> showAddDialog() async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: CommonColors.mTransparent,
          content: Container(
            height: kDeviceHeight / 2.5,
            decoration: BoxDecoration(
              color: CommonColors.mWhite,
              borderRadius: BorderRadius.circular(20),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Align(
                  alignment: Alignment.topRight,
                  child: SecondaryButton(
                    width: 40,
                    isRounded: false,
                    padding: const EdgeInsets.only(left: 8, right: 20),
                    onPress: () {
                      Navigator.pop(context);
                    },
                    label: 'X',
                    labelColor: CommonColors.primaryColor,
                  )),
              Container(
                color: CommonColors.mWhite,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 5),
                child: Text(
                  'Ailments',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: CommonColors.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Container(
                  color: CommonColors.mWhite,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      LabelTextField(
                        controller: otherAilmentController,
                        bgColor: CommonColors.primaryLite,
                        label: '',
                        // hintText: S.of(context)!.other,
                      ),
                      kCommonSpaceV15,
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              if (otherAilmentController.text
                                  .trim()
                                  .isNotEmpty) {
                                setState(() {
                                  mViewModel.storedOtherAilmentsList
                                      .add(otherAilmentController.text);
                                  otherAilmentController.clear();
                                });
                              }
                              mViewModel
                                  .storeUserAilmentsApi(
                                      medicationsId:
                                          mViewModel.selectedAilmentsIdList,
                                      otherAilments:
                                          mViewModel.storedOtherAilmentsList)
                                  .whenComplete(() {
                                mViewModel.selectedAilmentsIdList.clear();
                                otherAilmentController.clear();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CommonColors.mTransparent,
                              elevation: 0,
                              side: const BorderSide(
                                width: 1.0,
                                color: CommonColors.primaryColor,
                              ),
                              textStyle: const TextStyle(
                                color: CommonColors.primaryColor,
                              ),
                            ),
                            child: Text(S.of(context)!.add),
                          ),
                        ),
                      ),
                    ],
                  ))
            ]),
          ),
        );
      },
    );
  }

  Future<void> showMedicineDialog() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    S.of(context)!.ailments,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: mViewModel.ailmentList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            // if (selectedIndices.contains(index)) {
                            //   selectedIndices.remove(index);
                            // } else {
                            //   selectedIndices.add(index);
                            // }
                            final selectedMedicine =
                                mViewModel.ailmentList[index];
                            selectedMedicine.isSelected =
                                !selectedMedicine.isSelected;
                          });
                        },
                        child: Container(
                          width: 430,
                          height: 48,
                          color: mViewModel.ailmentList[index].isSelected
                              ? CommonColors.primaryColor
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                mViewModel.ailmentList[index].name.toString(),
                                style: TextStyle(
                                  color:
                                      mViewModel.ailmentList[index].isSelected
                                          ? CommonColors.mWhite
                                          : CommonColors.primaryColor,
                                  fontSize: 16,
                                  fontFamily: 'Outfit',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    ).whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<AilmentsViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        resizeToAvoidBottomInset: false,
        appBar: CommonAppBar(
          title: S.of(context)!.ailments,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: kDeviceWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // kCommonSpaceV30,
                /* InkWell(
                onTap: () {
                  showMedicineDialog();
                },
                child: Container(
                  width: kDeviceWidth / 1,
                  height: 52,
                  decoration: ShapeDecoration(
                    color: CommonColors.primaryLite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // shadows: [
                    //   BoxShadow(
                    //     color: Color(0x3F000000),
                    //     blurRadius: 4,
                    //     offset: Offset(0, 4),
                    //     spreadRadius: 0,
                    //   )
                    // ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context)!.ailments,
                          textAlign: TextAlign.center,
                          style: getAppStyle(
                            color: CommonColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: CommonColors.blackColor,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ), */

                // kCommonSpaceV30,
                /* LabelTextField(
                controller: otherAilmentController,
                bgColor: CommonColors.primaryLite,
                label: 'Other',
                // hintText: S.of(context)!.other,
              ),
              kCommonSpaceV10,
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      if (otherAilmentController.text.trim().isNotEmpty) {
                        setState(() {
                          mViewModel.storedOtherAilmentsList
                              .add(otherAilmentController.text);
                          otherAilmentController.clear();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CommonColors.mTransparent,
                      elevation: 0,
                      side: const BorderSide(
                        width: 1.0,
                        color: CommonColors.primaryColor,
                      ),
                      textStyle: const TextStyle(
                        color: CommonColors.primaryColor,
                      ),
                    ),
                    child: Text(S.of(context)!.add),
                  ),
                ),
              ), */
                kCommonSpaceV20,
                if (mViewModel.storedOtherAilmentsList.isEmpty)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          height: kDeviceHeight / 2.4,
                          LocalImages.img_ailments,
                        ),
                        kCommonSpaceV20,
                        Text(
                          'Manage and Track your\nhealth condition',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: getAppStyle(
                            color: CommonColors.black87,
                            fontSize: 18,
                            height: 1,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        kCommonSpaceV20,
                        PrimaryButton(
                            label: '+ Add',
                            buttonColor: CommonColors.primaryColor,
                            width: 90,
                            onPress: () {
                              showAddDialog();
                            }),
                      ]),
                if (mViewModel.storedOtherAilmentsList.isNotEmpty)
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /* Image.asset(
                          height: kDeviceHeight / 2.4,
                          LocalImages.img_ailments,
                        ),
                        kCommonSpaceV20, */
                        Text(
                          'Ailments',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CommonColors.black87,
                            fontSize: 18,
                            height: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // kCommonSpaceH10,
                        PrimaryButton(
                            label: '+ Add',
                            buttonColor: CommonColors.primaryColor,
                            width: 70,
                            height: 30,
                            onPress: () {
                              showAddDialog();
                            }),
                      ]),
                kCommonSpaceV20,
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mViewModel.storedOtherAilmentsList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.all(5),
                        decoration: ShapeDecoration(
                          color: CommonColors.mWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            push(MedicationView(
                                aid:
                                    mViewModel.storedOtherAilmentsList[index]));
                          },
                          child: Container(
                            width: kDeviceWidth,
                            padding: const EdgeInsets.only(
                              right: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      LocalImages.img_pill,
                                      height: 70,
                                      width: 70,
                                    ),
                                    kCommonSpaceH15,
                                    Text(
                                      mViewModel.storedOtherAilmentsList[index],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: CommonColors.blackColor,
                                      ),
                                    ),
                                  ],
                                ),

                                /* kCommonSpaceH10,
                                kCommonSpaceH10,
                                kCommonSpaceH10, */
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '>',
                                    style: getAppStyle(
                                      color: CommonColors.blackColor,
                                      fontSize: 16,
                                      // height: 0.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                /* Wrap(
                spacing: 2.0,
                // runSpacing: 4.0,
                children: List<Widget>.generate(
                  mViewModel.ailmentList.length,
                  (int index) {
                    final medicine = mViewModel.ailmentList[index];
                    if (medicine.isSelected) {
                      return Chip(
                        label: Text(medicine.name!),
                        onDeleted: () {
                          setState(() {
                            medicine.isSelected = false;
                          });
                        },
                        deleteIcon: const Icon(Icons.cancel),
                        deleteIconColor: Colors.red,
                        deleteButtonTooltipMessage: 'Remove item',
                      );
                    } else {
                      return const SizedBox(); // Return empty container if medicine is not selected
                    }
                  },
                ),
              ),
              Wrap(
                spacing: 2.0,
                children:
                    mViewModel.storedOtherAilmentsList.map((medicineName) {
                  return Chip(
                    label: Text(medicineName),
                    onDeleted: () {
                      setState(() {
                        mViewModel.storedOtherAilmentsList.remove(medicineName);
                      });
                    },
                    deleteIcon: const Icon(Icons.cancel),
                    deleteIconColor: Colors.red,
                  );
                }).toList(),
              ),
              kCommonSpaceV50,
              Align(
                alignment: Alignment.center,
                child: PrimaryButton(
                  width: kDeviceWidth / 2,
                  label: S.of(context)!.apply,
                  buttonColor: CommonColors.primaryColor,
                  onPress: () {
                    for (final medicine in mViewModel.ailmentList) {
                      if (medicine.isSelected) {
                        mViewModel.selectedAilmentsIdList.add(medicine.id!);
                      }
                    }
                    // if(isValid()){
                    mViewModel
                        .storeUserAilmentsApi(
                            medicationsId: mViewModel.selectedAilmentsIdList,
                            otherAilments: mViewModel.storedOtherAilmentsList)
                        .whenComplete(() {
                      mViewModel.selectedAilmentsIdList.clear();
                      otherAilmentController.clear();
                    });
                    // }
                  },
                ),
              ), */
                // Container(
                //   width: 390,
                //   // height: 50,
                //   decoration: ShapeDecoration(
                //     color: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     shadows: [
                //       BoxShadow(
                //         color: Color(0x3F000000),
                //         blurRadius: 10,
                //         offset: Offset(0, 2),
                //         spreadRadius: 0,
                //       )
                //     ],
                //   ),
                //   child: TextFormField(
                //     decoration: InputDecoration(
                //       border: InputBorder.none,
                //     ),
                //   ),
                // ),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: 5,
                //     itemBuilder: (BuildContext context, int index) {
                //       return InkWell(
                //           onTap: () {},
                //           child: Padding(
                //             padding: const EdgeInsets.only(bottom: 15),
                //             child: Container(
                //               // width: 390,
                //               // height: 200,
                //               decoration: ShapeDecoration(
                //                 color: CommonColors.mWhite,
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(10),
                //                 ),
                //                 shadows: [
                //                   BoxShadow(
                //                     color: Color(0x3F000000),
                //                     blurRadius: 10,
                //                     offset: Offset(0, 2),
                //                     spreadRadius: 0,
                //                   )
                //                 ],
                //               ),
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                 children: [
                //                   Padding(
                //                     padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                //                     child: Row(
                //                       children: [
                //                         CircleAvatar(
                //                           radius: 28,
                //                             backgroundColor: CommonColors.mWhite,
                //                             child: ClipRRect(
                //                               borderRadius: BorderRadius.circular(50),
                //                               child:
                //                                 Image.asset(LocalImages.img_medicine)
                //                                   // Image.network("https://t4.ftcdn.net/jpg/02/81/42/77/360_F_281427785_gfahY8bX4VYCGo6jlfO8St38wS9cJQop.jpg",fit: BoxFit.cover,),
                //                             )),
                //                         kCommonSpaceH10,
                //                         Flexible(
                //                           child: Text(
                //                             title,
                //                             textAlign: TextAlign.start,
                //                             style: getAppStyle(
                //                               color: CommonColors.blackColor,
                //                               fontSize: 16,
                //                               fontWeight: FontWeight.w400,
                //                               height: 1,
                //                             ),
                //                           ),
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                   Padding(
                //                     padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 10),
                //                     child: Text(
                //                     description,
                //                       textAlign: TextAlign.left,
                //                       style: getAppStyle(
                //                         color: CommonColors.mGrey,
                //                         fontSize: 13,
                //                         fontWeight: FontWeight.w400,
                //                         height: 1.1
                //                       ),
                //                     ),
                //                   )
                //                 ],
                //               ),
                //             ),
                //           ));
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // bool isValid() {
  //   if (mViewModel.selectedAilmentsIdList.isEmpty && mViewModel.storedOtherAilmentsList.isEmpty) {
  //     print(mViewModel.selectedAilmentsIdList.length);
  //     CommonUtils.showSnackBar(
  //       S.of(context)!.plSelectAilment,
  //       color: CommonColors.mRed,
  //     );
  //     return false;
  //   }
  //   else {
  //     return true;
  //   }
  // }
}

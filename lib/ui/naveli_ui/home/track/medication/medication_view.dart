// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naveli_2023/models/user_medicine_master.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/utils/local_images.dart';
import 'package:naveli_2023/widgets/common_symptoms_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/i18n.dart';
import '../../../../../utils/common_utils.dart';
import '../../../../../widgets/common_appbar.dart';
import '../../../../../widgets/common_text_field.dart';
import '../../../../../widgets/primary_button.dart';
import '../../../../../widgets/scaffold_bg.dart';
import 'medication_view_model.dart';

class MedicationView extends StatefulWidget {
  final String aid;

  const MedicationView({super.key, required this.aid});

  @override
  State<MedicationView> createState() => _MedicationViewState(aid);
}

const List<String> list = <String>['Mg', 'Ml', 'Other'];

const List<String> months = <String>[
  '0 Month',
  '1 Month',
  '2 Months',
  '3 Months',
  '4 Months',
  '5 Months'
];
const List<String> sdays = <String>[
  '0 days',
  '1 days',
  '2 days',
  '3 days',
  '4 days',
  '5 days',
  '6 days',
  '7 days',
  '8 days',
  '9 days',
  '10 days',
  '11 days',
  '12 days',
  '13 days',
  '14 days',
  '15 days',
  '16 days',
  '17 days',
  '18 days',
  '19 days',
  '20 days',
  '21 days',
  '22 days',
  '23 days',
  '24 days',
  '25 days',
  '26 days',
  '27 days',
  '28 days',
  '29 days'
];

class _MedicationViewState extends State<MedicationView> {
  late MedicationViewModel mViewModel;
  String aid;
  bool isAdd = false;
  File? selectedImage;
  String imagePath = "Upload";

  String dropdownValue = list.first;
  String amt = '';
  String freq = '';
  String mon = months.first;
  String days = sdays.first;

  // Set<int> selectedIndices = {};
  final otherMedicationsController = TextEditingController();
  final amtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel.attachedContext(context);
      mViewModel.getDataWithaid(aid).whenComplete(() {
        if (mViewModel.storedOtherMedicineList.isEmpty) {
          setState(() {
            isAdd = false;
            mViewModel.isExist = false;
          });
        }
        setState(() {});
        print(mViewModel.storedOtherMedicineList);
      });
      // print("================================================List");
      // print(list);
      // print("================================================List");

      /* 
       */
      // mViewModel.getStoredMedicineListApi();
    });
  }

  DateTime? _fromDate;
  DateTime? _toDate;

  // Function to show the date picker and get the selected date
  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isFromDate ? _fromDate : _toDate)) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
        } else {
          _toDate = picked;
        }
      });
    }
  }

  _MedicationViewState(this.aid);

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
                    S.of(context)!.periodMedication,
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
                    itemCount: mViewModel.medicineList?.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            // if (mViewModel.medicineList
                            //     !.contains(mViewModel.medicineList![index].id)) {
                            //   mViewModel.medicineList!.remove(mViewModel.medicineList![index].id);
                            // } else {
                            //   mViewModel.medicineList!.add(mViewModel.medicineList![index].id as MedicationData);
                            // }
                            final selectedMedicine =
                                mViewModel.medicineList![index];
                            selectedMedicine.isSelected =
                                !selectedMedicine.isSelected;
                          });
                        },
                        child: Container(
                          width: kDeviceWidth / 1,
                          height: 48,
                          color: mViewModel.medicineList![index].isSelected
                              ? CommonColors.primaryColor
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                mViewModel.medicineList![index].name
                                    .toString()
                                    .toUpperCase(),
                                style: TextStyle(
                                  color:
                                      mViewModel.medicineList![index].isSelected
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
    mViewModel = Provider.of<MedicationViewModel>(context);
    return ScaffoldBG(
      child: Scaffold(
        backgroundColor: CommonColors.mTransparent,
        resizeToAvoidBottomInset: false,
        appBar: CommonAppBar(
          title: aid ?? S.of(context)!.medication,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /* Text(
                S.of(context)!.effortlesslyTrack,
                textAlign: TextAlign.center,
                style: getAppStyle(
                  color: CommonColors.black87,
                  fontSize: 18,
                  height: 1,
                  fontWeight: FontWeight.w400,
                ),
              ),
              kCommonSpaceV30, */
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
                          S.of(context)!.periodMedication,
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
              ),
              kCommonSpaceV30, */
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                /* Image.asset(
                          height: kDeviceHeight / 2.4,
                          LocalImages.img_ailments,
                        ),
                        kCommonSpaceV20, */
                Text(
                  'Medication',
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
                    buttonColor: CommonColors.mWhite,
                    labelColor: CommonColors.primaryColor,
                    width: 90,
                    onPress: () {
                      setState(() {
                        isAdd = true;
                        mViewModel.isExist = true;
                      });
                      // showAddDialog();
                    }),
              ]),
              kCommonSpaceV20,
              if (mViewModel.isExist)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: kDeviceWidth / 2.2,
                          child: LabelTextField(
                            controller: otherMedicationsController,
                            bgColor: CommonColors.mWhite,
                            onEditComplete: (text) {
                              otherMedicationsController.text =
                                  text.toUpperCase();
                            },
                            label: 'Name of Medicine',
                            hintText: 'Name',
                          ),
                        ),
                        SizedBox(
                          width: kDeviceWidth / 3.3,
                          child: LabelTextField(
                            controller: amtController,
                            bgColor: CommonColors.mWhite,
                            onEditComplete: (text) {
                              amtController.text = text.toUpperCase();
                            },
                            label: '',
                            hintText: 'Amt',
                          ),
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    kCommonSpaceV10,
                    Text('Frequency',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CommonSymptomsBadge(
                          onTap: () {
                            setState(() {
                              freq = 'once a day';
                              // mViewModel.count += 1;
                            });
                          },
                          isUnderText: true,
                          imagePath: null,
                          underText: "Once",
                          imgHeight: 80,
                          isSelected: freq == 'once a day',
                        ),
                        CommonSymptomsBadge(
                          onTap: () {
                            setState(() {
                              freq = 'twice a day';
                              // mViewModel.count += 1;
                            });
                          },
                          isUnderText: true,
                          imagePath: null,
                          underText: "Twice",
                          imgHeight: 80,
                          isSelected: freq == 'twice a day',
                        ),
                        CommonSymptomsBadge(
                          onTap: () {
                            setState(() {
                              freq = 'thrice a day';
                              // mViewModel.count += 1;
                            });
                          },
                          isUnderText: true,
                          imagePath: null,
                          underText: "Thrice",
                          imgHeight: 80,
                          isSelected: freq == 'thrice a day',
                        ),
                        Text(
                          '/day',
                        )
                      ],
                    ),
                    kCommonSpaceV10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: kDeviceWidth / 2.5,
                          child: DropdownButton<String>(
                            value: mon,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                mon = value!;
                              });
                            },
                            items: months
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        kCommonSpaceH10,
                        SizedBox(
                          width: kDeviceWidth - kDeviceWidth / 1.5,
                          child: DropdownButton<String>(
                            value: days,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                days = value!;
                              });
                            },
                            items: sdays
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    kCommonSpaceH10,
                    kCommonSpaceV15,
                    // SizedBox(
                    //   // width: kDeviceWidth - kDeviceWidth / 1.5,
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(
                    //                   20), // Rounded button
                    //             ),
                    //             padding: EdgeInsets.symmetric(vertical: 10),
                    //             backgroundColor: const Color.fromARGB(
                    //                 255, 254, 255, 255), // Button color
                    //           ),
                    //           onPressed: () => _selectDate(context, true),
                    //           child: Text(
                    //             _fromDate == null
                    //                 ? "Select From Date"
                    //                 : "${_fromDate!.toLocal()}".split(' ')[0],
                    //             style: TextStyle(
                    //                 color: const Color.fromARGB(255, 0, 0, 0)),
                    //           ),
                    //         ),
                    //       ),
                    //       SizedBox(width: 16),
                    //       Expanded(
                    //         child: ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(
                    //                   20), // Rounded button
                    //             ),
                    //             padding: EdgeInsets.symmetric(vertical: 10),
                    //             backgroundColor: const Color.fromARGB(
                    //                 255, 254, 255, 255), // Button color
                    //           ),
                    //           onPressed: () => _selectDate(context, false),
                    //           child: Text(
                    //             _toDate == null
                    //                 ? "Select To Date"
                    //                 : "${_toDate!.toLocal()}".split(' ')[0],
                    //             style: TextStyle(
                    //                 color: const Color.fromARGB(255, 0, 0, 0)),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    /* kCommonSpaceV10,
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            if (otherMedicationsController.text
                                .trim()
                                .isNotEmpty) {
                              setState(() {
                                mViewModel.storedOtherMedicineList.add(
                                    OtherMedicine(
                                        name: otherMedicationsController.text,
                                        amt: '10 mg',
                                        frequency: 'once a day',
                                        months: '2 months',
                                        days: '20 days'));
                                otherMedicationsController.clear();
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
                    ),
                    kCommonSpaceV20, */
                  ],
                ),
              if (mViewModel.medicineList == null)
                Center(child: Text("No medicines available")),

              if (!mViewModel.isExist)
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mViewModel.storedOtherMedicineList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
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
                            otherMedicationsController.text =
                                mViewModel.storedOtherMedicineList[index].name!;
                            amtController.text =
                                mViewModel.storedOtherMedicineList[index].amt!;

                            freq = mViewModel
                                .storedOtherMedicineList[index].frequency!;
                            mon = mViewModel
                                .storedOtherMedicineList[index].months!;
                            days =
                                mViewModel.storedOtherMedicineList[index].days!;

                            setState(() {
                              isAdd = true;
                              mViewModel.isExist = false;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context)
                                .size
                                .width, // Use screen width here
                            padding: const EdgeInsets.only(
                              right: 20,
                              left: 10,
                              bottom: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(LocalImages.img_pill),
                                        kCommonSpaceH15,
                                        Text(
                                          '$aid-${mViewModel.storedOtherMedicineList[index].name ?? ''}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: CommonColors.blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            onPressed: () {
                                              var id = mViewModel
                                                  .storedOtherMedicineList[
                                                      index]
                                                  .id;
                                              _showDeleteConfirmationDialog(
                                                  context,
                                                  mViewModel,
                                                  index,
                                                  aid,
                                                  otherMedicationsController,
                                                  id);
                                            },
                                            icon: Icon(Icons.delete_outline,
                                                color:
                                                    CommonColors.primaryColor),
                                          ),
                                        ),
                                        Text(
                                          "${'Delete'}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: CommonColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  "${mViewModel.storedOtherMedicineList[index].amt ?? ''} ${mViewModel.storedOtherMedicineList[index].frequency ?? ''} ${mViewModel.storedOtherMedicineList[index].months ?? ''} ${mViewModel.storedOtherMedicineList[index].days ?? ''}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: CommonColors.mGrey,
                                  ),
                                ),
                                kCommonSpaceV5,
                                Text(
                                  '${calculateExpireDate(mViewModel.storedOtherMedicineList[index])}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: CommonColors.mGrey,
                                  ),
                                ),
                                Text(
                                  'Prescription.jpg',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: CommonColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      kCommonSpaceV10,
                    ]);
                  },
                ),

              /* Wrap(
                  spacing: 2.0,
                  children:
                      mViewModel.storedOtherMedicineList.map((medicineName) {
                    return Chip(
                      label: Text(medicineName.name ?? ''),
                      onDeleted: () {
                        setState(() {
                          mViewModel.storedOtherMedicineList
                              .remove(medicineName);
                        });
                      },
                      deleteIcon: const Icon(Icons.cancel),
                      deleteIconColor: Colors.red,
                    );
                  }).toList(),
                ), */
              // mViewModel.storedOtherMedicine != null ?
              // Wrap(spacing: 2.0, children: [
              //   Chip(
              //     label: Text(mViewModel.storedOtherMedicine!),
              //     onDeleted: () {
              //       setState(() {
              //         // mViewModel.selectedMedicationsName.removeAt(index);
              //         // if (index < mViewModel.selectedMedicationsId.length) {
              //         //   mViewModel.selectedMedicationsId.removeAt(index);
              //         // }
              //       });
              //     },
              //     deleteIcon: Icon(Icons.cancel),
              //     deleteIconColor: Colors.red,
              //     deleteButtonTooltipMessage: 'Remove item',
              //   )
              // ]) : Container(),
              kCommonSpaceV20,
              if (mViewModel.isExist)
                GestureDetector(
                  onTap: () async {
                    // Trigger the image picker when the container is clicked
                    final image = await pickSinglePhoto();
                    if (image != null) {
                      setState(() {
                        selectedImage = image;
                        imagePath = image.path;
                      });
                    }
                  },
                  child: Container(
                    width: kDeviceWidth / 1.1,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: CommonColors.mGrey300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Upload prescription',
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 14, color: CommonColors.blackColor),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final image = await pickSinglePhoto();
                            if (image != null) {
                              setState(() {
                                selectedImage = image;
                                imagePath = image.path;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.file_upload_outlined,
                            size: 20,
                            color: CommonColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              kCommonSpaceV50,
              if (mViewModel.isExist)
                Align(
                  alignment: Alignment.center,
                  child: PrimaryButton(
                      width: kDeviceWidth / 2,
                      label: 'Submit',
                      buttonColor: CommonColors.primaryColor,
                      onPress: () {
                        // print("press...");
                        for (final medicine in mViewModel.medicineList!) {
                          if (medicine.isSelected) {
                            mViewModel.selectedMedicationsIdList
                                .add(medicine.id!);
                          }
                        }
                        setState(() {
                          isAdd = false;
                          mViewModel.isExist = false;
                        });
                        mViewModel.storeOtherAlimentsCustome(medicationsId: [
                          2
                        ], otherMedicine: [
                          {
                            "name": otherMedicationsController.text,
                            "amt": amtController.text,
                            "frequency": freq,
                            "months": mon,
                            "days": days
                          },
                        ], aid: aid).whenComplete(() {
                          setState(() {
                            isAdd = false;
                          });
                          mViewModel.selectedMedicationsIdList.clear();
                          otherMedicationsController.clear();
                          amtController.clear();
                          setState(() {
                            isAdd = false;
                          });
                        });
                      }
                      // },
                      ),
                ),

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
    );
  }

  bool isValid() {
    if (mViewModel.selectedMedicationsIdList.isEmpty &&
        mViewModel.storedOtherMedicineList.isEmpty) {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectMedicine,
        color: CommonColors.mRed,
      );
      return false;
    } else {
      return true;
    }
  }
}

// Method to show the confirmation dialog
void _showDeleteConfirmationDialog(BuildContext context, mViewModel, index, aid,
    otherMedicationsController, id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Confirmation'),
        content: Text('Are you sure you want to delete this item?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // If user cancels, just dismiss the dialog
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              mViewModel.deleteMedication(id, aid).whenComplete(() {
                Navigator.of(context).pop();
              });
            },
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
}

String calculateExpireDate(dynamic obj) {
  // Assuming 'obj.date' is a string in the format "yyyy-MM-dd"
  String date = obj.date;
  String months = obj.months;
  String days = obj.days;

  // Convert the string 'date' to a DateTime object
  DateTime currentDate = DateTime.parse(date);

  // Extract the number of months and days from the input strings
  int monthCount =
      int.parse(months.split(" ")[0]); // Extract the number of months
  int dayCount = int.parse(days.split(" ")[0]); // Extract the number of days

  // First, add the months to the current date
  DateTime expirationDate = _addMonths(currentDate, monthCount);

  // Then, add the days to the resulting date
  expirationDate = expirationDate.add(Duration(days: dayCount));
  String formattedDate3 = DateFormat('yyyy, MMM dd').format(expirationDate);

  return formattedDate3;
}

// Helper function to add months to a DateTime object
DateTime _addMonths(DateTime date, int months) {
  // Calculate the new month
  int newMonth = date.month + months;
  int yearOverflow = (newMonth - 1) ~/ 12;
  newMonth = (newMonth - 1) % 12 + 1;

  // Create a new DateTime object with the updated month and year
  DateTime newDate = DateTime(date.year + yearOverflow, newMonth, date.day);

  // If the new month has fewer days than the original, adjust the day to the last valid day of the month
  if (newDate.month != newMonth) {
    int lastDayOfMonth = DateTime(newDate.year, newDate.month + 1, 0).day;
    newDate = DateTime(newDate.year, newDate.month, lastDayOfMonth);
  }

  return newDate;
}

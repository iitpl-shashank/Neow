import 'package:flutter/material.dart';
import 'package:naveli_2023/ui/common_ui/state_and_language_selection/state_selection_view_model.dart';
import 'package:naveli_2023/utils/common_colors.dart';
import 'package:naveli_2023/utils/constant.dart';
import 'package:naveli_2023/widgets/common_appbar.dart';
import 'package:naveli_2023/widgets/scaffold_bg.dart';
import 'package:provider/provider.dart';

import '../../../database/app_preferences.dart';
import '../../../generated/i18n.dart';
import '../../../models/city_master.dart';
import '../../../models/state_master.dart';
import '../../../utils/common_utils.dart';
import '../../../utils/local_images.dart';
import '../../../utils/global_variables.dart';
import '../../../widgets/primary_button.dart';
import '../../app/app_model.dart';

class StateSelectionView extends StatefulWidget {
  const StateSelectionView({super.key});

  @override
  State<StateSelectionView> createState() => _StateSelectionViewState();
}

class _StateSelectionViewState extends State<StateSelectionView> {
  late StateSelectionViewModel mViewModel;
  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      mViewModel = Provider.of<StateSelectionViewModel>(context, listen: false);
      mViewModel.attachedContext(context);
      mViewModel.getStateListApi();
    });
  }

  void setLanguage(String langCode) {
    AppPreferences.instance.setLanguageCode(langCode);
    CommonUtils.languageCode = langCode;
    Provider.of<AppModel>(mainNavKey.currentContext!, listen: false)
        .changeLanguage();
  }

  void changeLanguage(int index) {
    if (index == 1) {
      setLanguage(AppConstants.LANGUAGE_ENGLISH);
    } else if (index == 2) {
      setLanguage(AppConstants.LANGUAGE_HINDI);
    }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<StateSelectionViewModel>(context);
    return ScaffoldBG(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CommonColors.mTransparent,
          appBar: const CommonAppBar(
            title: '',
          ),
          body: Padding(
            padding: kCommonScreenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const SizedBox(),
                Column(
                  children: [
                    Text(
                      'Where are you from?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    kCommonSpaceV20,
                    Image.asset(
                      LocalImages.img_state,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(LocalImages.img_image_error);
                      },
                    ),
                    kCommonSpaceV50,
                    DropdownButtonFormField<int>(
                      value: mViewModel.selectedState.id,
                      items: [
                        DropdownMenuItem<int>(
                          value: null,
                          child: Text(
                            S.of(context)!.selectState,
                            style: const TextStyle(height: 1),
                          ),
                        ),
                        ...mViewModel.stateList.map((state) {
                          return DropdownMenuItem<int>(
                            value: state.id,
                            child: Text(state.name ?? '',
                                style: const TextStyle(height: 1)),
                          );
                        }),
                      ],
                      onChanged: (int? value) {
                        setState(() {
                          if (value == null) {
                            // Reset selectedState and selectedCity
                            mViewModel.selectedState = StateData();
                            mViewModel.selectedCity = CityData();
                            mViewModel.selectedCity.id = 0;
                          } else {
                            mViewModel.selectedState = mViewModel.stateList
                                .firstWhere((state) => state.id == value);
                            mViewModel.selectedCity = CityData();
                            mViewModel.selectedCity.id = null;
                            print(
                                'Selected State ID: ${mViewModel.selectedState.id}, Name: ${mViewModel.selectedState.name}');
                          }
                        });
                        if (value != null) {
                          mViewModel.getCityListApi(
                              stateId: mViewModel.selectedState.id);
                        }
                      },
                      decoration: InputDecoration(
                        labelText: S.of(context)!.selectState,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    kCommonSpaceV20,
                    DropdownButtonFormField<int>(
                      value: mViewModel.selectedCity.id,
                      items: [
                        DropdownMenuItem<int>(
                          value: null,
                          child: Text(
                            S.of(context)!.selectDistrict,
                            style: const TextStyle(height: 1),
                          ),
                        ),
                        ...mViewModel.cityList.map((state) {
                          return DropdownMenuItem<int>(
                            value: state.id,
                            child: Text(
                              state.name ?? '',
                              style: const TextStyle(height: 1),
                            ),
                          );
                        }),
                      ],
                      onChanged: (int? value) {
                        setState(() {
                          if (value == null) {
                            // Reset selectedState and selectedCity
                            mViewModel.selectedCity = CityData();
                          } else {
                            mViewModel.selectedCity = mViewModel.cityList
                                .firstWhere((state) => state.id == value);
                            print(
                                'Selected State ID: ${mViewModel.selectedCity.id}, Name: ${mViewModel.selectedCity.name}');
                          }
                        });
                        if (value != null) {
                          mViewModel.getCityListApi(
                              stateId: mViewModel.selectedState.id);
                        }
                      },
                      decoration: InputDecoration(
                        labelText: S.of(context)!.selectDistrict,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    /*kCommonSpaceV20,
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: CommonColors.primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(30.0),
                          color: CommonColors.mTransparent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 1;
                                changeLanguage(selectedIndex);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 25, right: 25),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: selectedIndex == 1
                                      // ? Color(0xFFC06CF9)
                                      ? CommonColors.primaryColor
                                      : CommonColors.mTransparent),
                              child: Text(
                                "English",
                                style: getAppStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedIndex == 1
                                        ? CommonColors.mWhite
                                        : CommonColors.blackColor),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = 2;
                                changeLanguage(selectedIndex);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 25, right: 25),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: selectedIndex == 2
                                      // ? Color(0xFFC06CF9)
                                      ? CommonColors.primaryColor
                                      : CommonColors.mTransparent),
                              child: Text(
                                "हिंदी",
                                style: getAppStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedIndex == 2
                                        ? CommonColors.mWhite
                                        : CommonColors.blackColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),*/
                  ],
                ),
                PrimaryButton(
                  width: kDeviceWidth / 1.3,
                  label: S.of(context)!.next,
                  buttonColor: CommonColors.primaryColor,
                  onPress: () {
                    if (isValid()) {
                      mViewModel.storeStateApi(
                          stateId: mViewModel.selectedState.id);
                      mViewModel.storeCityApi(
                          cityId: mViewModel.selectedCity.id);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValid() {
    if (mViewModel.selectedState.id == null ||
        mViewModel.selectedState.name == null) {
      CommonUtils.showSnackBar(
        S.of(context)!.plSelectState,
        color: CommonColors.mRed,
      );
      return false;
    } else if (mViewModel.selectedCity.id == null ||
        mViewModel.selectedCity.name == null) {
      CommonUtils.showSnackBar(S.of(context)!.plSelectCity,
          color: CommonColors.mRed);
      return false;
    } else {
      return true;
    }
  }
}

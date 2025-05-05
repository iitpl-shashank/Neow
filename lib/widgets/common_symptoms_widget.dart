import 'package:flutter/material.dart';
import 'package:naveli_2023/widgets/primary_button.dart';
import '../utils/common_colors.dart';
import '../utils/constant.dart';

class CommonSymptomsWidget extends StatefulWidget {
  final String? imagePath;
  final String? containerImagePath;
  final String? title;
  final bool isSelected;
  final bool isBoxFit;
  final double? height;
  final double? imgWidth;
  final double? imgHeight;
  final double? width;
  final Color? bgColor;
  final Color? borderColor;
  final String? underText;
  final bool isUnderText;
  final bool isContainer;
  final bool inContainerImage;
  final void Function()? onTap;

  const CommonSymptomsWidget({
    super.key,
    this.imagePath,
    this.containerImagePath,
    this.title,
    required this.isSelected,
    this.onTap,
    this.isBoxFit = false,
    this.height,
    this.imgWidth,
    this.imgHeight,
    this.width,
    this.bgColor,
    this.borderColor,
    this.isContainer = false,
    this.inContainerImage = false,
    this.underText,
    this.isUnderText = false,
  });

  @override
  State<CommonSymptomsWidget> createState() => _CommonSymptomsWidgetState();
}

class _CommonSymptomsWidgetState extends State<CommonSymptomsWidget> {
  @override
  Widget build(BuildContext context) {
    var tcolor =
        widget.isSelected ? CommonColors.primaryColor : CommonColors.greyText;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        kCommonSpaceV5,
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            // width: widget.width ?? 80,
            // height: widget.height ?? 95,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              // color: Colors.orange,
              shape: BoxShape.rectangle,
              // border: Border.all(
              //     color: widget.isSelected
              //         ? CommonColors.primaryColor
              //         : Colors.transparent,
              //     width: 3),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.isContainer
                    ? Container(
                        width: 80,
                        height: 65,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: widget.bgColor,
                            border: Border.all(
                              width: 1,
                              color: widget.borderColor ??
                                  CommonColors.mTransparent,
                            ),
                            shape: BoxShape.circle),
                        child: Center(
                          child: widget.inContainerImage
                              ? Image.asset(
                                  widget.containerImagePath!,
                                  fit: widget.isBoxFit ? BoxFit.cover : null,
                                )
                              : Text(
                                  widget.title!,
                                  textAlign: TextAlign.center,
                                  style: getGoogleFontStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: CommonColors.primaryColor),
                                ),
                        ),
                      )
                    : Column(children: [
                        Container(
                          width: 75,
                          height: 80,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            color: widget.isSelected
                                ? Color(0xFFFAEEFF)
                                : CommonColors.mWhite,
                            boxShadow: [
                              widget.isSelected
                                  ? const BoxShadow(
                                      color: CommonColors.primaryColor,
                                      blurRadius: 0.0,
                                    )
                                  : const BoxShadow(
                                      color: CommonColors.mTransparent,
                                      blurRadius: 0.0,
                                    )
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                            border: Border.all(
                              width: 1,
                              color: widget.isSelected
                                  ? CommonColors.primaryColor
                                  : CommonColors.mGrey.withOpacity(0.3),
                            ),
                          ),
                          child: Image.asset(
                            widget.imagePath!,
                            fit: widget.isBoxFit ? BoxFit.cover : null,
                          ),
                        ),
                        kCommonSpaceV8,
                        widget.isUnderText
                            ? FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  widget.underText!,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: tcolor),
                                ),
                              )
                            : const SizedBox(),
                      ])
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CommonSymptomsTitle extends StatefulWidget {
  final String title;
  final GestureTapCallback? onTap;
  final bool isMiddleTitle;
  final bool isHintIcon;
  final String? dialogText;

  const CommonSymptomsTitle(
      {super.key,
      required this.title,
      this.onTap,
      this.isMiddleTitle = false,
      this.dialogText,
      this.isHintIcon = false});

  @override
  State<CommonSymptomsTitle> createState() => _CommonSymptomsTitleState();
}

class _CommonSymptomsTitleState extends State<CommonSymptomsTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (widget.isMiddleTitle) ...[
        kCommonSpaceV10,
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  maxLines: 1,
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: CommonColors.blackColor),
                ),
              ),
              kCommonSpaceH5,
              widget.isHintIcon
                  ? GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierColor: Colors.black54, // Optional dim effect
                          builder: (BuildContext context) {
                            Future.delayed(const Duration(seconds: 3), () {
                              Navigator.of(context).pop();
                            });

                            return Dialog(
                              backgroundColor: Colors.transparent,
                              insetPadding: const EdgeInsets.all(20),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  /// Main dialog box
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: CommonColors.primaryColor,
                                          width: 2),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        /// Close button
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: const Icon(Icons.close,
                                                color:
                                                    CommonColors.primaryColor),
                                          ),
                                        ),

                                        /// Title
                                        Text(
                                          widget.title ?? "Working Ability",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: CommonColors.primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),

                                        /// Description
                                        Text(
                                          widget.dialogText ??
                                              "Capacity to perform tasks effectively while on periods",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// Push-pin like pointer at the top-left
                                  Positioned(
                                    top: -20,
                                    left: 12,
                                    child: Icon(
                                      Icons.push_pin,
                                      size: 32,
                                      color: CommonColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const Icon(
                        Icons.info,
                        color: CommonColors.primaryColor,
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
        kCommonSpaceV10,
      ],
      if (!widget.isMiddleTitle) ...[
        kCommonSpaceV10,
        Row(
          children: [
            Text(
              widget.title,
              // overflow: TextOverflow.ellipsis,
              // maxLines: 1,
              style: TextStyle(
                color: CommonColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            kCommonSpaceH5,
            widget.isHintIcon
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          Future.delayed(
                            const Duration(seconds: 3),
                            () {
                              // Navigator.of(context).pop();
                            },
                          );
                          return Stack(
                            children: [
                              AlertDialog(
                                backgroundColor: CommonColors.mTransparent,
                                content: Container(
                                    // color:CommonColors.mWhite,
                                    height: kDeviceHeight / 4,
                                    width: kDeviceWidth - 20,
                                    decoration: BoxDecoration(
                                      color: CommonColors.mWhite,
                                      /* image: DecorationImage(
                                      image: AssetImage(LocalImages.img_info_banner),
                                      fit: BoxFit.cover,
                                    ), */
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                    onTap: () =>
                                                        Navigator.pop(context),
                                                    child: Icon(Icons.cancel)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Container(
                                            color: CommonColors.mWhite,
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 15, bottom: 5),
                                            child: Text(
                                              widget.title,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color:
                                                      CommonColors.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          Container(
                                            color: CommonColors.mWhite,
                                            padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                            ),
                                            child: Text(
                                              widget.dialogText ?? "Some text",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color:
                                                      CommonColors.blackColor,
                                                  fontSize: 14),
                                            ),
                                          )
                                          /* Text(
                                        widget.dialogText ?? "Some text",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: CommonColors.primaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ), */
                                        ])),

                                /* Text(
                                  widget.dialogText ?? "Some text",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: CommonColors.primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ), */
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height / 2 -
                                    125,
                                left: 55,
                                child: Image.asset(
                                  "assets/images/ic_pin.png",
                                  width: 35,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.info,
                      color: CommonColors.primaryColor,
                    ))
                : const SizedBox.shrink()
          ],
        ),
        kCommonSpaceV10,
      ],
    ]);
  }
}

class CommonSymptomsBadge extends StatefulWidget {
  final String? imagePath;
  final String? containerImagePath;
  final String? title;
  final bool isSelected;
  final bool isBoxFit;
  final double? height;
  final double? imgWidth;
  final double? imgHeight;
  final double? width;
  final Color? bgColor;
  final Color? borderColor;
  final String? underText;
  final bool isUnderText;
  final bool isContainer;
  final bool inContainerImage;
  final void Function()? onTap;

  const CommonSymptomsBadge({
    super.key,
    this.imagePath,
    this.containerImagePath,
    this.title,
    required this.isSelected,
    this.onTap,
    this.isBoxFit = false,
    this.height,
    this.imgWidth,
    this.imgHeight,
    this.width,
    this.bgColor,
    this.borderColor,
    this.isContainer = false,
    this.inContainerImage = false,
    this.underText,
    this.isUnderText = false,
  });

  @override
  State<CommonSymptomsBadge> createState() => _CommonSymptomsBadgeState();
}

class _CommonSymptomsBadgeState extends State<CommonSymptomsBadge> {
  @override
  Widget build(BuildContext context) {
    var tcolor =
        widget.isSelected ? CommonColors.primaryColor : CommonColors.black87;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        kCommonSpaceV5,
        GestureDetector(
          onTap: widget.onTap,
          child: IntrinsicWidth(
            child: Container(
              // width: widget.width ?? 80,
              // height: widget.height ?? 95,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          color: widget.isSelected
                              ? Color(0xFFFAEEFF)
                              : CommonColors.mWhite,
                          boxShadow: [
                            widget.isSelected
                                ? const BoxShadow(
                                    color: CommonColors.primaryColor,
                                    blurRadius: 0.0,
                                  )
                                : const BoxShadow(
                                    color: CommonColors.mTransparent,
                                    blurRadius: 0.0,
                                  )
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          border: Border.all(
                            width: 1,
                            color: widget.isSelected
                                ? CommonColors.primaryColor
                                : CommonColors.mGrey.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            widget.imagePath != null
                                ? Image.asset(
                                    widget.imagePath!,
                                    fit: widget.isBoxFit ? BoxFit.cover : null,
                                  )
                                : const SizedBox(),
                            Text(
                              widget.underText!,
                              // textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: tcolor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

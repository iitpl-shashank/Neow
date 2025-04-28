import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../generated/i18n.dart';
import '../utils/common_colors.dart';
import '../utils/constant.dart';
import '../utils/global_variables.dart';

commonDialogWithActionButton(
    {required String title,
    double? titleSize,
    required List<Widget> children,
    required String btnLabel,
    void Function()? onTapButton,
    TextAlign? textAlign}) {
  showCupertinoDialog(
    context: mainNavKey.currentContext!,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: kCommonScreenPadding,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (title.isNotEmpty)
                      Text(
                        title,
                        textAlign: textAlign ?? TextAlign.center,
                        style: getAppStyle(
                          fontSize: titleSize ?? 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    kCommonSpaceV15,
                    Column(
                      children: children,
                    ),
                    kCommonSpaceV15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            S.of(context)!.cancel,
                            style: getAppStyle(
                                color: CommonColors.darkPink,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ),
                        kCommonSpaceH10,
                        InkWell(
                          onTap: onTapButton,
                          child: Text(
                            S.of(context)!.ok,
                            style: getAppStyle(
                                color: CommonColors.darkPink,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    kCommonSpaceH10,
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

void deleteAlertDialog({void Function()? onDeleteButton}) {
  showCupertinoModalPopup<bool>(
    context: mainNavKey.currentContext!,
    builder: (context) => CupertinoAlertDialog(
      title: Text(S.of(context)!.areYouSure),
      content: Text(S.of(context)!.thisActionPermanentlyDelete),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context)!.cancel),
        ),
        CupertinoDialogAction(
          onPressed: onDeleteButton,
          child: Text(S.of(context)!.delete),
        ),
      ],
    ),
  );
}

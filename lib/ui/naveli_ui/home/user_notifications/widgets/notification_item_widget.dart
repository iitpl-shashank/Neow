import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../generated/i18n.dart';
import '../../../../../utils/common_colors.dart';
import '../../../../../utils/common_utils.dart';
import '../../../calendar/calendar_view.dart';
import '../../../health_mix/health_mix_view.dart';
import '../../all_about_periods/all_about_periods_view.dart';
import '../../home_view_model.dart';
import '../../log_your_symptoms/log_your_symptoms_view.dart';

class NotificationItemWidget extends StatefulWidget {
  final NotificationItem item;

  const NotificationItemWidget({
    super.key,
    required this.item,
  });

  @override
  State<NotificationItemWidget> createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  late HomeViewModel mViewModel;

  void _handleTap(BuildContext context) {
    if (widget.item.key == "Log Symptoms") {
      if (mViewModel.isWithinNoTime(mViewModel.periodStartLogDateTime,
          mViewModel.periodEndLogDateTime, mViewModel.today)) {
        push(const LogYourSymptoms());
      } else {
        CommonUtils.showToastMessage(
          S.of(context)!.logOnlyOnPeriodDay,
        );
      }
    } else if (widget.item.key == "Log Period") {
      push(CalendarView());
    } else if (widget.item.key == "Health Mix") {
      push(
        HealthMixView(
          title: S.of(context)!.healthMix,
        ),
      );
    } else if (widget.item.key == "Article") {
      push(const AllAboutPeriodsView());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            S.of(context)!.noNotificationYet,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<HomeViewModel>(context);
    return InkWell(
      onTap: () => isToday(widget.item.date) ? _handleTap(context) : null,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: CommonColors.blueShade,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.item.icon,
                    color: isToday(widget.item.date)
                        ? CommonColors.purple
                        : CommonColors.purple.withAlpha(102),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.item.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isToday(widget.item.date)
                                  ? CommonColors.blackColor
                                  : CommonColors.blackColor.withAlpha(102),
                            ),
                          ),
                          Text(
                            widget.item.date,
                            style: TextStyle(
                              fontSize: 12,
                              color: isToday(widget.item.date)
                                  ? CommonColors.greyText
                                  : CommonColors.greyText.withAlpha(102),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        widget.item.subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: isToday(widget.item.date)
                              ? CommonColors.greyText
                              : CommonColors.greyText.withAlpha(102),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Divider(
              height: 1,
              thickness: 0.6,
              color: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem {
  final IconData icon;
  final String title;
  final String date;
  final String subtitle;
  final String key;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.date,
    required this.subtitle,
    required this.key,
  });
}

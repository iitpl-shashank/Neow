// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:naveli_2023/utils/common_colors.dart';

// class DialogOption {
//   final String label;
//   final String value;
//   final VoidCallback? onClick;

//   DialogOption(this.label, this.value, {this.onClick});
// }

// class DialogOption {
//   final String label;
//   final String value;
//   final Future<void> Function()? onClick; // Can also use FutureOr<void> if preferred

//   DialogOption(this.label, this.value, {this.onClick});
// }

// class CustomAlertDialog extends StatelessWidget {
//   final Widget? icon;
//   final String title;
//   final String? description;
//   final List<DialogOption> options;
//   final bool isHorizontalButtons;
//   final bool showCloseIcon;
//   final bool showPurpleButton;

//   const CustomAlertDialog({
//     super.key,
//     this.icon,
//     required this.title,
//     this.description,
//     required this.options,
//     this.isHorizontalButtons = false,
//     this.showCloseIcon = true,
//     this.showPurpleButton = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (showCloseIcon)
//               Align(
//                 alignment: Alignment.topRight,
//                 child: IconButton(
//                   icon: const Icon(Icons.close),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ),
//             if (icon != null) icon!,
//             const SizedBox(height: 12),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             if (description != null) ...[
//               const SizedBox(height: 8),
//               Text(
//                 description!,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 14, color: Colors.black87),
//               ),
//             ],
//             const SizedBox(height: 20),
//             Divider(height: 1, color: Colors.grey.shade300),
//             const SizedBox(height: 16),

//             // ✅ Purple button
//             if (showPurpleButton && options.isNotEmpty)
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: CommonColors.purple,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(32)),
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                   ),
//                   onPressed: () async {
//                     final first = options.first;
//                     if (first.onClick != null) await first.onClick!();
//                     Navigator.of(context).pop(first.value);
//                   },
//                   child: Text(
//                     options.first.label,
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               )

//             // ✅ Horizontal buttons
//             else if (isHorizontalButtons)
//               IntrinsicHeight(
//                 child: Row(
//                   children: List.generate(options.length, (index) {
//                     return Expanded(
//                       child: Column(
//                         children: [
//                           TextButton(
//                             onPressed: () async {
//                               final opt = options[index];
//                               if (opt.onClick != null) await opt.onClick!();
//                               Navigator.of(context).pop(opt.value);
//                             },
//                             child: Text(
//                               options[index].label,
//                               style: const TextStyle(color: CommonColors.purple),
//                             ),
//                           ),
//                           if (index != options.length - 1)
//                             VerticalDivider(
//                                 width: 1, color: Colors.grey.shade300),
//                         ],
//                       ),
//                     );
//                   }),
//                 ),
//               )

//             // ✅ Vertical buttons
//             else
//               Column(
//                 children: List.generate(options.length, (index) {
//                   return Column(
//                     children: [
//                       TextButton(
//                         onPressed: () async {
//                           final opt = options[index];
//                           if (opt.onClick != null) await opt.onClick!();
//                           Navigator.of(context).pop(opt.value);
//                         },
//                         child: Text(
//                           options[index].label,
//                           style: const TextStyle(color: CommonColors.purple),
//                         ),
//                       ),
//                       if (index != options.length - 1)
//                         Divider(height: 1, color: Colors.grey.shade300),
//                     ],
//                   );
//                 }),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // class CustomAlertDialog extends StatelessWidget {
// //   final Widget? icon;
// //   final String title;
// //   final String? description;
// //   final List<DialogAction> actions;
// //   final bool isHorizontalButtons;
// //   final bool showCloseIcon;
// //   final bool showPurpleButton;

// //   const CustomAlertDialog({
// //     super.key,
// //     this.icon,
// //     required this.title,
// //     this.description,
// //     required this.actions,
// //     this.isHorizontalButtons = false,
// //     this.showCloseIcon = true,
// //     this.showPurpleButton = false,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Dialog(
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             if (showCloseIcon)
// //               Align(
// //                 alignment: Alignment.topRight,
// //                 child: IconButton(
// //                   icon: const Icon(Icons.close),
// //                   onPressed: () => Navigator.pop(context),
// //                 ),
// //               ),
// //             if (icon != null) icon!,
// //             const SizedBox(height: 12),
// //             Text(
// //               title,
// //               textAlign: TextAlign.center,
// //               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// //             ),
// //             if (description != null) ...[
// //               const SizedBox(height: 8),
// //               Text(
// //                 description!,
// //                 textAlign: TextAlign.center,
// //                 style: const TextStyle(fontSize: 14, color: Colors.black87),
// //               ),
// //             ],
// //             const SizedBox(height: 20),
// //             Divider(height: 1, color: Colors.grey.shade300),

// //             const SizedBox(height: 16),

// //             // ✅ Show full-length purple button if flag is true
// //             if (showPurpleButton && actions.isNotEmpty)
// //               SizedBox(
// //                 width: double.infinity,
// //                 child: ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: CommonColors.purple,
// //                     shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(32)),
// //                     padding: const EdgeInsets.symmetric(vertical: 14),
// //                   ),
// //                   onPressed: () =>
// //                       Navigator.of(context).pop(actions.first.value),
// //                   child: Text(
// //                     actions.first.label,
// //                     style: const TextStyle(color: Colors.white),
// //                   ),
// //                 ),
// //               )

// //             // ➕ Else use horizontal/vertical buttons
// //             else if (isHorizontalButtons)
// //               IntrinsicHeight(
// //                 child: Row(
// //                   children: List.generate(actions.length, (index) {
// //                     return Expanded(
// //                       child: Column(
// //                         children: [
// //                           TextButton(
// //                             onPressed: () =>
// //                                 Navigator.of(context).pop(actions[index].value),
// //                             child: Text(
// //                               actions[index].label,
// //                               style:
// //                                   const TextStyle(color: CommonColors.purple),
// //                             ),
// //                           ),
// //                           if (index != actions.length - 1)
// //                             VerticalDivider(
// //                                 width: 1, color: Colors.grey.shade300),
// //                         ],
// //                       ),
// //                     );
// //                   }),
// //                 ),
// //               )
// //             else
// //               Column(
// //                 children: List.generate(actions.length, (index) {
// //                   return Column(
// //                     children: [
// //                       TextButton(
// //                         onPressed: () =>
// //                             Navigator.of(context).pop(actions[index].value),
// //                         child: Text(
// //                           actions[index].label,
// //                           style: const TextStyle(color: CommonColors.purple),
// //                         ),
// //                       ),
// //                       if (index != actions.length - 1)
// //                         Divider(height: 1, color: Colors.grey.shade300),
// //                     ],
// //                   );
// //                 }),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// Future<String?> showCustomDialog({
//   required BuildContext context,
//   required String title,
//   String? description,
//   String? icon,
//   List<DialogOption>? options,
//   bool isHorizontal = false,
//   bool showCloseIcon = false,
//   bool showPurpleButton = false,
// }) {
//   return showDialog<String>(
//     context: context,
//     barrierDismissible: false,
//     builder: (_) => CustomAlertDialog(
//       icon: icon != null
//           ? SvgPicture.asset(icon, height: 60)
//           : null,
//       title: title,
//       description: description,
//       options: options ?? [],
//       isHorizontalButtons: isHorizontal,
//       showCloseIcon: showCloseIcon,
//       showPurpleButton: showPurpleButton,
//     ),
//   );
// }

// // Future<String?> showCustomDialog({
// //   required BuildContext context,
// //   required String title,
// //   String? description,
// //   String? icon,
// //   List<DialogOption>? options,
// //   bool isHorizontal = false,
// //   bool showCloseIcon = false,
// //   bool showPurpleButton = false,
// // }) {
// //   return showDialog<String>(
// //     context: context,
// //     barrierDismissible: false,
// //     builder: (_) => CustomAlertDialog(
// //       icon: icon != null
// //           ? SvgPicture.asset(
// //               icon,
// //               height: 60,
// //             )
// //           : null,
// //       title: title,
// //       description: description,
// //       actions: options != null
// //           ? options
// //               .map((option) => DialogAction(option.label, option.value))
// //               .toList()
// //           : [],
// //       isHorizontalButtons: isHorizontal,
// //       showCloseIcon: showCloseIcon,
// //       showPurpleButton: showPurpleButton,
// //     ),
// //   );
// // }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naveli_2023/utils/common_colors.dart';

// DialogOption now includes an optional Future<void> function for onClick
class DialogOption {
  final String label;
  final String value;
  final Future<void> Function()?
      onClick; // Future<void> instead of VoidCallback

  DialogOption(this.label, this.value, {this.onClick});
}

// Custom Alert Dialog class
class CustomAlertDialog extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String? description;
  final List<DialogOption> options; // List of DialogOption objects
  final bool isHorizontalButtons;
  final bool showCloseIcon;
  final bool showPurpleButton;

  const CustomAlertDialog({
    super.key,
    this.icon,
    required this.title,
    this.description,
    required this.options, // Changed to use DialogOption
    this.isHorizontalButtons = false,
    this.showCloseIcon = true,
    this.showPurpleButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showCloseIcon)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            if (icon != null) icon!,
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(
                description!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
            const SizedBox(height: 20),
            Divider(height: 1, color: Colors.grey.shade300),

            const SizedBox(height: 16),

            // Show purple button if required
            if (showPurpleButton && options.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CommonColors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(options.first.value);
                    if (options.first.onClick != null) {
                      options.first.onClick!(); // Run onClick if provided
                    }
                  },
                  child: Text(
                    options.first.label,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )

            // Horizontal buttons
            else if (isHorizontalButtons)
              IntrinsicHeight(
                child: Row(
                  children: List.generate(options.length, (index) {
                    return Expanded(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(options[index].value);
                              if (options[index].onClick != null) {
                                options[index]
                                    .onClick!(); // Run onClick if provided
                              }
                            },
                            child: Text(
                              options[index].label,
                              style:
                                  const TextStyle(color: CommonColors.purple),
                            ),
                          ),
                          if (index != options.length - 1)
                            VerticalDivider(
                                width: 1, color: Colors.grey.shade300),
                        ],
                      ),
                    );
                  }),
                ),
              )

            // Vertical buttons
            else
              Column(
                children: List.generate(options.length, (index) {
                  return Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(options[index].value);
                          if (options[index].onClick != null) {
                            options[index]
                                .onClick!(); // Run onClick if provided
                          }
                        },
                        child: Text(
                          options[index].label,
                          style: const TextStyle(color: CommonColors.purple),
                        ),
                      ),
                      if (index != options.length - 1)
                        Divider(height: 1, color: Colors.grey.shade300),
                    ],
                  );
                }),
              ),
          ],
        ),
      ),
    );
  }
}

// Function to show the custom dialog
Future<String?> showCustomDialog({
  required BuildContext context,
  required String title,
  String? description,
  String? icon,
  List<DialogOption>? options,
  bool isHorizontal = false,
  bool showCloseIcon = false,
  bool showPurpleButton = false,
}) {
  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (_) => CustomAlertDialog(
      icon: icon != null
          ? SvgPicture.asset(
              icon,
              height: 60,
            )
          : null,
      title: title,
      description: description,
      options: options ?? [],
      isHorizontalButtons: isHorizontal,
      showCloseIcon: showCloseIcon,
      showPurpleButton: showPurpleButton,
    ),
  );
}

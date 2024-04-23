import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

import '../routes/routes.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
TextTheme txtTheme(context) => Theme.of(context).textTheme;
Widget get loading => const Center(child: CircularProgressIndicator());

Widget vSpace(double height) => SizedBox(height: height.h);
Widget hSpace(double width) => SizedBox(width: width.w);
Widget get empty => const SizedBox();
PreferredSizeWidget leadingAppBar(context, onTap, [List<Widget>? actions]) =>
    AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: onTap,
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.blue,
        ),
      ),
      actions: actions,
    );

Future<T?> showBtmSheet<T>(context, Widget child) async =>
    await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      enableDrag: false,
      isDismissible: false,
      builder: (context) {
        return child;
      },
    );

AppLocalizations get t =>
    AppLocalizations.of(routes.configuration.navigatorKey.currentContext!)!;

Padding headingTitle(BuildContext context, title) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Text(
      title,
      style: txtTheme(context).headlineMedium!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
    ),
  );
}

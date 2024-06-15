import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/appconstnace/media.dart';
import '../../../../core/tools/tools.dart';

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        headingTitle(context, t.goodGo),
        SvgPicture.asset(Media.coverAuth.path),
        Text(t.allDone),
        headingTitle(context, t.letsWonderful),
      ],
    );
  }
}

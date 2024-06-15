import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/appconstnace/media.dart';
import '../tools.dart';

class CustomSuccessDialog extends StatelessWidget {
  const CustomSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(Media.doneState.path),
              Text(
                t.cong,
                style: txtTheme(context)
                    .headlineMedium!
                    .copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              vSpace(3),
              Text(t.addedTask),
              vSpace(3),
              ElevatedButton(
                onPressed: () {
                  BotToast.removeAll();
                },
                child: Text(t.continueTxt),
              )
            ],
          ),
        ),
      ),
    );
  }
}

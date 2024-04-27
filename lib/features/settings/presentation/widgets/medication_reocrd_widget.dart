import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gradeuration/core/helper/local_data.dart';
import 'package:gradeuration/core/tools/tools.dart';

class MedicationRecordWidget extends StatelessWidget {
  const MedicationRecordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: leadingAppBar(context, () {
        context.pop();
      }),
      body: Column(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(currentUser.medicalReportImg),
            ),
          ),
          vSpace(3),
          ListTile(
            leading: Text(
              t.diagosis,
              style: txtTheme(context)
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            title: Text(
              currentUser.diagnosis,
              style: txtTheme(context).headlineSmall,
            ),
          ),
          ListTile(
            leading: Text(
              t.strage,
              style: txtTheme(context)
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            title: Text(
              currentUser.stage,
              style: txtTheme(context).headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}

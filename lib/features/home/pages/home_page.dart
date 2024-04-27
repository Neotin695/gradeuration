import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gradeuration/config/appconstnace/media.dart';
import 'package:gradeuration/core/helper/local_data.dart';
import 'package:gradeuration/core/routes/routes.dart';
import 'package:gradeuration/core/tools/tools.dart';
import 'package:gradeuration/features/settings/presentation/pages/map_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.hello,
              style: txtTheme(context)
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              t.mr(currentUser.fullName.split(' ').first),
              style: txtTheme(context).headlineSmall!.copyWith(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              showBtmSheet(context, const MapPage());
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(
                  Icons.location_pin,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.chat_outlined)),
          IconButton(
              onPressed: () {
                context.go(homeRoute(AppRoutes.settings.path));
              },
              icon: const Icon(Icons.settings_outlined)),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ItemWidget(
                  image: Media.medication.path,
                  color: const Color.fromARGB(255, 184, 69, 255),
                  title: t.medicatiokn,
                  onTap: () {
                    context.go(homeRoute(AppRoutes.medication.path));
                  },
                ),
                ItemWidget(
                  image: Media.schedule.path,
                  color: const Color.fromARGB(255, 66, 190, 101),
                  title: t.schedule,
                ),
              ],
            ),
            vSpace(3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ItemWidget(
                  image: Media.dailyTask.path,
                  color: const Color.fromARGB(255, 241, 194, 27),
                  title: t.dailyTask,
                ),
                ItemWidget(
                  image: Media.game.path,
                  color: const Color.fromARGB(255, 250, 77, 86),
                  title: t.games,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.image,
    required this.title,
    required this.color,
    this.onTap,
  });
  final String image;
  final String title;
  final Color color;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 57, 57, 57),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset(image),
              ),
            ),
            vSpace(2),
            Text(
              title,
              style: txtTheme(context)
                  .headlineSmall!
                  .copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

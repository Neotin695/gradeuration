import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradeuration/core/tools/tools.dart';
import 'package:gradeuration/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/service/injection_container.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (context) => sl()..add(RequestLocationPermissionEvent()),
      child: const MapView(),
    );
  }
}

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final SettingsBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsLoading) {
          BotToast.showLoading();
        }
        if (state is SettingsFailure) {
          BotToast.closeAllLoading();
          BotToast.showText(text: state.message);
        }
        if (state is SettingsSuccess) {
          BotToast.closeAllLoading();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: leadingAppBar(context, () {
            context.pop();
          }),
          body: SafeArea(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMap(
                  initialCameraPosition: bloc.cameraPosition,
                  myLocationButtonEnabled: true,
                  onMapCreated: (controller) {
                    bloc.mapController = controller;
                    bloc.add(GetCurrentLocationEvent());
                  },
                  markers: bloc.currentLocation,
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.only(bottom: 3.h),
                  child: SizedBox(
                    width: 90.w,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                      child: Text(
                        bloc.placeName,
                        style: txtTheme(context).headlineSmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

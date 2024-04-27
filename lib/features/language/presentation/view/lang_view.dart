import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/tools/tools.dart';
import '../cubit/language_cubit.dart';

class LangView extends StatefulWidget {
  const LangView({super.key});

  @override
  State<LangView> createState() => _LangViewState();
}

class _LangViewState extends State<LangView> {
  late final LanguageCubit cubit;
  @override
  void initState() {
    cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.lang),
      ),
      body: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  cubit.changeLang('en', context);
                },
                title: const Text('English'),
              ),
              ListTile(
                onTap: () {
                  cubit.changeLang('ar', context);
                },
                title: const Text('العربية'),
              ),
            ],
          );
        },
      ),
    );
  }
}

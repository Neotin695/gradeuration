import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/helper/local_data.dart';
import '../../../app/app_page.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  String selectedLnag = 'ar';

  void fetchAllLang() {
    emit(LanguageLoading());

    emit(LanguageSuccess());
  }

  Future changeLang(String code, context) async {
    emit(LanguageLoading());
    selectedLnag = code;
    await prefs
        .setString('lang', code)
        .then((value) => AppPage.restartApp(context));
    emit(LanguageSuccess());
  }

  bool isSelected = false;
  void getCurrentLang(String code) {
    emit(LanguageLoading());
    isSelected = code == (prefs.getString('lang') ?? 'en');
    emit(LanguageSuccess());
  }
}

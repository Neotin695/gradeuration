enum Media {
  coverAuth(path: 'assets/icons/cover_auth.svg'),
  finger(path: 'assets/icons/fingerprint.svg'),
  logo(path: 'assets/icons/logo.svg'),
  medication(path: 'assets/icons/medication.svg'),
  schedule(path: 'assets/icons/schedule.svg'),
  dailyTask(path: 'assets/icons/daily_task.svg'),
  game(path: 'assets/icons/game.svg'),
  init(path: '');

  const Media({required this.path});
  final String path;
}

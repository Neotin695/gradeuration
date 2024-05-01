enum Media {
  coverAuth(path: 'assets/icons/cover_auth.svg'),
  finger(path: 'assets/icons/fingerprint.svg'),
  logo(path: 'assets/icons/logo.svg'),
  medication(path: 'assets/icons/medication.svg'),
  schedule(path: 'assets/icons/schedule.svg'),
  dailyTask(path: 'assets/icons/daily_task.svg'),
  game(path: 'assets/icons/game.svg'),
  pill(path: 'assets/images/pills.svg'),
  doneState(path: 'assets/images/done_state.svg'),
  amount(path: 'assets/icons/amount.svg'),
  cause(path: 'assets/icons/cause.svg'),
  capSize(path: 'assets/icons/cap_size.svg'),
  duration(path: 'assets/icons/duration.svg'),
  init(path: '');

  const Media({required this.path});
  final String path;
}

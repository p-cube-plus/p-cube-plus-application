enum MainNavigationType {
  project(0),
  fee(-2),
  home(2),
  alarm(1),
  user(3),
  ;

  const MainNavigationType(this.navigationIndex);
  final int navigationIndex;
}

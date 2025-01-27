enum FeeFilterType {
  total("전체"),
  income("입금"),
  outgo("출금"),
  ;

  final String name;
  const FeeFilterType(this.name);
}

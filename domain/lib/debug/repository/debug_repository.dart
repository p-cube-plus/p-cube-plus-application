abstract interface class DebugRepository {
  bool getIsMocking();
  void setIsMocking(bool value);

  bool getIsTestingEmptyData();
  void setIsTestingEmptyData(bool value);

  bool getIsTestingException();
  void setIsTestingException(bool value);
}

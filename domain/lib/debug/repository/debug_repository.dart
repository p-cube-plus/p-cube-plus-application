abstract interface class DebugRepository {
  bool getIsMocking();
  void setIsMocking(bool value);

  double getMockDelay();
  void setMockDelay(double value);

  bool getIsTestingException();
  void setIsTestingException(bool value);
}

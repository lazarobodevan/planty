abstract class ILedService{

  Future<void> toggleLed();
  Future<bool> getLedState();

}
import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue: Float = 0;
  stable var startTime = Time.now();

  Debug.print("DBank created");
  Debug.print(debug_show(startTime));
  let id = 2313109349949449;

  public func topUp(amount: Float) {
    compound();
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float) {
    compound();
    if (currentValue > amount) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Current balance is lower than requested value. Cannot withdraw.");
    }
  };

  public query func checkBalance(): async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNanos = currentTime - startTime;
    let timeElapsedSeconds = timeElapsedNanos / 1000000000;

    // we assume a 0.01% per second interest rate
    currentValue := currentValue * 1.0001 ** Float.fromInt(timeElapsedSeconds);
    startTime := currentTime;
  }
}
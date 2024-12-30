import 'dart:async';

import 'package:domain/common/extensions/future_extension.dart';
import 'package:domain/login/usecases/confirm_auth_number_use_case.dart';
import 'package:domain/login/usecases/send_auth_number_use_case.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/ui/login/input_auth_number/input_auth_number_state.dart';
import 'package:presentation/utils/throttler.dart';

class LoginAuthNumberPageViewModel extends BaseViewModel<InputAuthNumberState> {
  final sendAuthNumber = SendAuthNumberUseCase();
  final _confirmAuthNumberUseCase = ConfirmAuthNumberUseCase();

  final String phoneNumner;
  String authText = "";
  bool isNeedToRetry = false;
  bool isFailedInputAuth = false;
  String timerText = "";
  StreamSubscription<int>? _timer;

  final timeoutDuration = const Duration(minutes: 3);
  Duration _timeoutCount = const Duration(minutes: 3);
  final Throttler _throttler = Throttler(const Duration(milliseconds: 500));

  LoginAuthNumberPageViewModel(String phoneNumber) : phoneNumner = phoneNumber {
    requestAuth();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void requestAuth() {
    _throttler.run(() async {
      authText = "";
      timerText = _getTimerText(_timeoutCount);
      _startTimer();

      triggerEvent(InputAuthNumberState.showSendingAuthNumberToast);

      final result = await sendAuthNumber.call(phoneNumner).getOrNull();
      var isSuccess = result?.isValid ?? false;
      if (!isSuccess) {
        _timer?.cancel();
        isNeedToRetry = true;
        isFailedInputAuth = true;
        timerText = "인증번호 발송에 실패했어요.";
        notifyListeners();
        triggerEvent(InputAuthNumberState.showFailedSendAuthNumberDialog);
      }
    });
  }

  void onChangedInputAuthNumber(String inputText) async {
    if (inputText.length > 6) {
      inputText = inputText.substring(0, 6);
    }
    if (inputText.length == 6) {
      triggerEvent(InputAuthNumberState.checkIsValidAuthNumber);

      final isVerified = await _confirmAuthNumberUseCase.call(inputText);
      isNeedToRetry = !isVerified;
      notifyListeners();
      triggerEvent(InputAuthNumberState.completeVerification);

      if (isVerified) {
        _timer?.cancel();
        triggerEvent(InputAuthNumberState.validAuthNumber);
      } else {
        _timer?.cancel();
        isNeedToRetry = true;
        timerText = "본인 인증에 실패했어요.";
        notifyListeners();
        triggerEvent(InputAuthNumberState.invalidAuthNumber);
      }
    }
  }

  String _getTimerText(Duration dutation) {
    final minutes = dutation.inMinutes;
    final seconds = dutation.inSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, "0")}";
  }

  void _startTimer() {
    isNeedToRetry = false;
    if (_timer != null) _timer!.cancel();

    _timeoutCount = timeoutDuration;
    timerText = _getTimerText(_timeoutCount);
    notifyListeners();

    _timer = Stream.periodic(const Duration(seconds: 1), (count) => count)
        .listen((count) {
      _timeoutCount -= const Duration(seconds: 1);
      timerText = _getTimerText(_timeoutCount);

      if (_timeoutCount == const Duration(minutes: 2, seconds: 50)) {
        isNeedToRetry = true;
      }

      if (_timeoutCount == const Duration(minutes: 0, seconds: 0)) {
        timerText = "인증 시간이 만료되었어요.";
        _timer?.cancel();
      }

      notifyListeners();
    });
  }
}

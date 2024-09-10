import 'dart:async';

import 'package:domain/usecase/login/send_auth_number_usecase.dart';
import 'package:presentation/common/base_viewmodel.dart';
import 'package:presentation/extensions/future_extension.dart';
import 'package:presentation/ui/login/input_auth_number/input_auth_number_event.dart';
import 'package:presentation/ui/login/input_auth_number/input_auth_number_state.dart';
import 'package:presentation/utils/throttler.dart';

class LoginAuthNumberPageViewModel
    extends BaseViewModel<InputAuthNumberState, InputAuthNumberEvent> {
  final sendAuthNumber = SendAuthNumberUseCase();

  bool get isNeedToRetry => _isNeedToRetry;
  String get authText => _authText;
  String get timerText => _timerText;

  final String _phoneNumber;
  String get phoneNumner => _phoneNumber;

  String _authText = "";
  bool _isNeedToRetry = false;
  String _timerText = "";
  StreamSubscription<int>? _timer;

  final timeoutDuration = const Duration(minutes: 3);
  Duration _timeoutCount = const Duration(minutes: 3);
  final Throttler _throttler;

  LoginAuthNumberPageViewModel(String phoneNumber)
      : _phoneNumber = phoneNumber,
        _throttler = Throttler(const Duration(milliseconds: 500)) {
    _setEventListener();
    _requestAuth();
  }

  void _setEventListener() {
    userActionEventStream.listen((event) {
      switch (event) {
        case InputAuthNumberEventRequestAuthNumber():
          _requestAuth();
        case InputAuthNumberEventInputAuthNumber():
          _onChangedInputAuthNumber(event.text);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _requestAuth() {
    _throttler.run(() async {
      _authText = "";
      _timerText = _getTimerText(_timeoutCount);
      _startTimer();

      changeState(InputAuthNumberState.showSendingAuthNumberToast);

      final result = await sendAuthNumber(_phoneNumber).getOrNull();
      var isSuccess = result?.isValid ?? false;
      if (!isSuccess) {
        _timer?.cancel();
        _isNeedToRetry = true;
        _timerText = "인증번호 발송에 실패했어요.";
        notifyListeners();
        changeState(InputAuthNumberState.showFailedSendAuthNumberDialog);
      }
    });
  }

  void _onChangedInputAuthNumber(String inputText) async {
    if (inputText.length > 6) {
      inputText = inputText.substring(0, 6);
    }
    if (inputText.length == 6) {
      changeState(InputAuthNumberState.checkIsValidAuthNumber);

      await Future.delayed(const Duration(seconds: 2));
      var isVerified = true;
      _isNeedToRetry = !isVerified;
      notifyListeners();
      changeState(InputAuthNumberState.completeVerification);

      if (isVerified) {
        _timer?.cancel();
        changeState(InputAuthNumberState.validAuthNumber);
      } else {
        _timer?.cancel();
        _isNeedToRetry = true;
        _timerText = "본인 인증에 실패했어요.";
        notifyListeners();
        changeState(InputAuthNumberState.invalidAuthNumber);
      }
    }
  }

  String _getTimerText(Duration dutation) {
    final minutes = dutation.inMinutes;
    final seconds = dutation.inSeconds % 60;
    return "$minutes:${seconds.toString().padLeft(2, "0")}";
  }

  void _startTimer() {
    _isNeedToRetry = false;
    if (_timer != null) _timer!.cancel();

    _timeoutCount = timeoutDuration;
    _timerText = _getTimerText(_timeoutCount);
    notifyListeners();

    _timer = Stream.periodic(const Duration(seconds: 1), (count) => count)
        .listen((count) {
      _timeoutCount -= const Duration(seconds: 1);
      _timerText = _getTimerText(_timeoutCount);

      if (_timeoutCount == const Duration(minutes: 2, seconds: 45)) {
        _isNeedToRetry = true;
      }

      if (_timeoutCount == const Duration(minutes: 0, seconds: 0)) {
        _timerText = "인증 시간이 만료되었어요.";
        _timer?.cancel();
      }

      notifyListeners();
    });
  }
}

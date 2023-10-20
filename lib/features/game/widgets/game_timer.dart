import 'dart:async';

class GameTimer {
  late Timer _timer;
  late Duration _duration;
  late Function(Duration) _onTick;
  bool _isActive = false;

  GameTimer({
    Duration? duration,
    Function(Duration)? onTick,
  }) {
    _duration = duration ?? Duration(seconds: 1);
    _onTick = onTick ?? (Duration duration) {};
  }

  bool get isActive => _isActive;

  void start() {
    if (!_isActive) {
      _timer = Timer.periodic(_duration, _tick);
      _isActive = true;
    }
  }

  void pause() {
    if (_isActive) {
      _timer.cancel();
      _isActive = false;
    }
  }

  void resume() {
    if (!_isActive) {
      _timer = Timer.periodic(_duration, _tick);
      _isActive = true;
    }
  }

  void stop() {
    if (_isActive) {
      _timer.cancel();
      _isActive = false;
    }
  }

  void _tick(Timer timer) {
    _onTick(_duration * (timer.tick - 1));
  }
}
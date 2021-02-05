import 'dart:async';
import 'package:async/async.dart';

class LoadFetchTimer {
  final int _WAIT_TIME = 1;
  RestartableTimer _timer;

  LoadFetchTimer();

  void _startTimer(ZoneCallback callback){
    _timer = new RestartableTimer(new Duration(seconds: _WAIT_TIME), callback);
  }

  void loadTimer(ZoneCallback callback){
    if(_timer == null){
      _startTimer(callback);
    } else {
      _timer.reset();
    }
  }

  void cancelTimer(){
    _timer.cancel();
    _timer = null;
  }
}
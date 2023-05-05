import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class SoundService {
  late Soundpool _pool;
  late int _soundId;

  SoundService() {
    _pool = Soundpool.fromOptions();
    prepareSoundService();
  }

  prepareSoundService() async {
    _soundId = await rootBundle
        .load("assets/sounds/sound.wav")
        .then((ByteData soundData) {
      return _pool.load(soundData);
    });
  }

  play() {
    _pool.play(_soundId);
  }
}

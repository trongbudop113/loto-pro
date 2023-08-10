import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CallNumberBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CallNumberController());
  }
}

class CallNumberController extends GetxController {

  late FlutterTts flutterTts;
  final RxString engine = ''.obs;
  final RxDouble volume = (0.7).obs;
  final RxDouble  pitch = (1.1).obs;
  final RxDouble  rate = (0.8).obs;
  bool isCurrentLanguageInstalled = false;

  final RxString newVoiceText = ''.obs;
  final RxList<String> listTextNumber = <String>[].obs;

  final Rx<TtsState> ttsState = TtsState.stopped.obs;

  get isPlaying => ttsState.value == TtsState.playing;
  get isStopped => ttsState.value == TtsState.stopped;
  get isPaused => ttsState.value == TtsState.paused;
  get isContinued => ttsState.value == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  @override
  void onInit() {
    initTts();
    super.onInit();
  }

  initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      ttsState.value = TtsState.playing;
    });

    if (isAndroid) {
      flutterTts.setInitHandler(() {

      });
    }

    flutterTts.setCompletionHandler(() {
      ttsState.value = TtsState.stopped;
    });

    flutterTts.setCancelHandler(() {
      ttsState.value = TtsState.stopped;
    });

    flutterTts.setPauseHandler(() {
      ttsState.value = TtsState.paused;
    });

    flutterTts.setContinueHandler(() {
      ttsState.value = TtsState.continued;
    });

    flutterTts.setErrorHandler((msg) {
      ttsState.value = TtsState.stopped;
    });

    changedLanguageDropDownItem("vi-VN");
  }

  Future<dynamic> _getLanguages() async => await flutterTts.getLanguages;

  Future<dynamic> _getEngines() async => await flutterTts.getEngines;

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  Future _speak() async {
    await flutterTts.setVolume(volume.value);
    await flutterTts.setSpeechRate(rate.value);
    await flutterTts.setPitch(pitch.value);

    if (newVoiceText!.isNotEmpty) {
      await flutterTts.speak(newVoiceText.value);
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future onClickStop() async {
    var result = await flutterTts.stop();
    if (result == 1) ttsState.value = TtsState.stopped;
    isPlay = false;
    stt = 0;
    listRandom = randomize(89, 1, 90);
    listTextNumber.clear();
    newVoiceText.value = "";

    initTts();
  }

  Future onClickPause() async {
    var result = await flutterTts.pause();
    if (result == 1) ttsState.value = TtsState.paused;
    isPlay = false;
  }

  List<DropdownMenuItem<String>> getEnginesDropDownMenuItems(dynamic engines) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in engines) {
      items.add(DropdownMenuItem(
          value: type as String?, child: Text(type as String)));
    }
    return items;
  }

  void changedEnginesDropDownItem(String? selectedEngine) async {
    await flutterTts.setEngine(selectedEngine!);
    engine.value = selectedEngine;
  }

  List<DropdownMenuItem<String>> getLanguageDropDownMenuItems(
      dynamic languages) {
    var items = <DropdownMenuItem<String>>[];
    for (dynamic type in languages) {
      items.add(DropdownMenuItem(
          value: type as String?, child: Text(type as String)));
    }
    return items;
  }

  void changedLanguageDropDownItem(String selectedType) {
    flutterTts.setLanguage(selectedType);
    if (isAndroid) {
      flutterTts.isLanguageInstalled(selectedType).then((value) => isCurrentLanguageInstalled = (value as bool));
    }

    listRandom = randomize(89, 1, 90);
  }

  List<int> listRandom = [];
  int stt = 0;
  bool isPlay = false;
  RxInt timeDelay = 4.obs;

  Future<void> getArgument() async {
    isPlay = true;
    timer = Timer.periodic(Duration(seconds: timeDelay.value), (Timer t) {
      if(isPlay == false){
        t.cancel();
        return;
      }
      if(stt >= listRandom.length){
        t.cancel();
        return;
      }
      print('[${listRandom[stt]}]');
      newVoiceText.value = 'số ${listRandom[stt]}';
      listTextNumber.add('${listRandom[stt]} ');
      _speak();
      stt++;
    });
  }

  Timer? timer;

  List<int> randomize(int count, int min, int max)
  {
    Random r = Random();
    List<int> result = [];
    if (count < max)
    {
      while(result.length <= count){
        int number = r.nextInt(max);
        if (!result.contains(number))
        {
          result.add(number);
        }
      }
    }
    else
    {
      print("Select another boundaries or number count");
    }
    return result;
  }

  @override
  void onClose() {
    timer?.cancel();
    flutterTts.stop();
    super.onClose();
  }

}

enum TtsState { playing, stopped, paused, continued }
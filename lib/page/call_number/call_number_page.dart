import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/call_number/call_number_controller.dart';

class CallNumberPage extends GetView<CallNumberController>{
  const CallNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter TTS'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Obx(() => Text(controller.newVoiceText.value)),
              Obx(() => Text(controller.listTextNumber.toString())),
              _btnSection(),
              _buildSliders(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btnSection() {
    return Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Colors.green, Colors.greenAccent, Icons.play_arrow,
              'PLAY', controller.getArgument),
          _buildButtonColumn(
              Colors.red, Colors.redAccent, Icons.stop, 'STOP', controller.onClickStop),
          _buildButtonColumn(
              Colors.blue, Colors.blueAccent, Icons.pause, 'PAUSE', controller.onClickPause),
        ],
      ),
    );
  }

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
          Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(label,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: color)))
        ]);
  }

  Widget _buildSliders() {
    return Column(
      children: [_volume(), _pitch(), _rate()],
    );
  }

  Widget _volume() {
    return Obx(() => Slider(
        value: controller.volume.value,
        onChanged: (newVolume) {
          controller.volume.value = newVolume;
        },
        min: 0.0,
        max: 1.0,
        divisions: 10,
        label: "Volume: ${controller.volume.value}"
    ));
  }

  Widget _pitch() {
    return Obx(() => Slider(
      value: controller.pitch.value,
      onChanged: (newPitch) {
        controller.pitch.value = newPitch;
      },
      min: 0.5,
      max: 2.0,
      divisions: 15,
      label: "Pitch: ${controller.pitch.value}",
      activeColor: Colors.red,
    ));
  }

  Widget _rate() {
    return Obx(() => Slider(
      value: controller.rate.value,
      onChanged: (newRate) {
        controller.rate.value = newRate;
      },
      min: 0.0,
      max: 1.0,
      divisions: 10,
      label: "Rate: ${controller.rate.value}",
      activeColor: Colors.green,
    ));
  }

}
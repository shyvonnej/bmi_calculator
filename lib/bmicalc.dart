import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const BmiCalcPage());

class BmiCalcPage extends StatefulWidget {
  const BmiCalcPage({Key? key}) : super(key: key);

  @override
  State<BmiCalcPage> createState() => _BmiCalcPageState();
}

class _BmiCalcPageState extends State<BmiCalcPage>{
  TextEditingController heightEditingController = TextEditingController();
  TextEditingController weightEditingController = TextEditingController();
double height = 0.0, weight =0.0, bmi = 0.0;
AudioCache audioCache = new AudioCache();
AudioPlayer audioPlayer = new AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
        body: Column(
          children: [
            Flexible(flex:2, 
            child: Image.asset('assets/images/bmicalc.png', scale: 2)),
            Flexible(
              flex: 9, 
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      const Text("BMI CALCULATOR", 
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10), 
                    TextField(
                      controller: heightEditingController,
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        hintText: "Height in Meter",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        )
                      )
                    ),
                    const SizedBox(height:10),
                    TextField(
                      controller: weightEditingController,
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        hintText: "Weight in Kg",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)))
                      ),
                    const SizedBox(height:10),
                    ElevatedButton(onPressed: _calBMI, child: const Text("Calculate BMI")),
                    const SizedBox(height:10),
                    Text("Your BMI " + bmi.toStringAsPrecision(3),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              )),
          ]
        ),
      );
  }

  void _calBMI() {
    setState(() {
    height = double.parse(heightEditingController.text);
    weight = double.parse(weightEditingController.text);
      bmi = weight/ (height *height);
    });
    if (bmi > 25) {
      loadFail();
      } else if ((bmi <= 24.9) && (bmi >= 18.5)) { loadOk();
      } else if (bmi < 18.5) { loadFail();
}
  }
  
loadOk() async {
audioPlayer = await AudioCache().play("audios/bell.wav");
}
loadFail() async {
audioPlayer = await AudioCache().play("audios/poker.wav");
}


}
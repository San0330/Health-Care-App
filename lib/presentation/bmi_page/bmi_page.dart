import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  static String routeName = '/bmi';

  const BMIScreen();

  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  //some default values
  int age = 17;
  int weight = 50;
  double bmi;

  int height = 180;
  double maxHeight = 220;
  double minHeight = 120;

  void ageIncrement() {
    setState(() {
      age++;
    });
  }

  void ageDecrement() {
    setState(() {
      age--;
    });
  }

  void weightIncrement() {
    setState(() {
      weight++;
    });
  }

  void weightDecrement() {
    setState(() {
      weight--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headlines = TextStyle(
      letterSpacing: 2.0,
      fontSize: 15,
      color: Theme.of(context).primaryColor,
    );

    final boldNumber = TextStyle(
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: 50.0,
    );

    final secondaryButtonColorStyle = TextStyle(
      color: Theme.of(context).secondaryHeaderColor,
      fontWeight: FontWeight.bold,
      fontSize: 26.0,
    );

    const primaryButtonStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      letterSpacing: 1,
      wordSpacing: 2,
      color: Colors.white,
    );

    final resultNumber = TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 80.0,
        letterSpacing: 0.1);

    final heightContainer = Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('HEIGHT', style: headlines),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("$height", style: boldNumber),
          ),
          Slider(
              value: height.toDouble(),
              min: minHeight,
              max: maxHeight,
              activeColor: Colors.blue,
              inactiveColor: Colors.black,
              onChanged: (double newValue) {
                setState(() {
                  height = newValue.round();
                });
              },
              semanticFormatterCallback: (double newValue) {
                return '$newValue.round()';
              })
        ],
      ),
    );

    final weightContainer = Container(
      margin: const EdgeInsets.all(10.0),
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('WEIGHT', style: headlines),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("$weight", style: boldNumber),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: weightDecrement,
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.blue),
                  child: Center(
                    child: Text(
                      "-",
                      style: secondaryButtonColorStyle,
                    ),
                  ),
                ),
              ),
              Container(
                height: 40.0,
                width: 40.0,
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.blue,
                ),
                child: InkWell(
                  onTap: weightIncrement,
                  child: Center(
                    child: Text(
                      "+",
                      style: secondaryButtonColorStyle,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );

    final ageContainer = Container(
      margin: const EdgeInsets.all(10.0),
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('AGE', style: headlines),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("$age", style: boldNumber),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: ageDecrement,
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.blue),
                  child: Center(
                    child: Text(
                      "-",
                      style: secondaryButtonColorStyle,
                    ),
                  ),
                ),
              ),
              Container(
                height: 40.0,
                width: 40.0,
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.blue),
                child: InkWell(
                  onTap: ageIncrement,
                  child: Center(
                    child: Text(
                      "+",
                      style: secondaryButtonColorStyle,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );

    var comment = '';
    var headline = '';
    bmi = (weight / (height * height)) * 10000;

    if (bmi < 18.5) {
      comment = "You are under Weight";
      headline = "UNDERWEIGHT";
    } else if (bmi >= 18.5 && bmi < 25) {
      comment = "You are at a healthy weight.";
      headline = "NORMAL";
    } else if (bmi > 25 && bmi <= 29.99) {
      comment = "You are at overweight.";
      headline = "OVERWEIGHT";
    } else {
      comment = "You are obese.";
      headline = "OBESE";
    }

    Future bmiresult() {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("BMI Result"),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(headline,
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 15,
                                color: Theme.of(context).primaryColor,
                              )),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${bmi.round()}',
                              style: resultNumber,
                            ),
                          ),
                          const Text('Normal BMI range:'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "18.5 - 25 kg/m",
                              style: headlines,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              comment,
                              style: headlines,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                OutlineButton(
                  textColor: Theme.of(context).primaryColor,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Close".toUpperCase(),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI"),
        actions: const [
          Icon(Icons.info),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: heightContainer,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: weightContainer,
              ),
              Expanded(
                child: ageContainer,
              )
            ],
          ),
          InkWell(
            onTap: () => bmiresult(),
            child: Container(
              color: Theme.of(context).primaryColor,
              margin: const EdgeInsets.only(top: 10.0),
              height: MediaQuery.of(context).size.height * 0.1,
              child: const Center(
                child: Text('CALCULATE BMI', style: primaryButtonStyle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

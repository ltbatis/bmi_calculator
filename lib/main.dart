import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  String _infoText = "Fill in the fields";

  void _calculate(){
    setState(() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double bmi = weight / (height * height);
    double n = num.parse(bmi.toStringAsFixed(2));
    print(n);
    if(n<18.6){
      _infoText = "Under weight (${n})";
    } else if(n >= 18.6 && n < 24.9){
      _infoText = "Ideal weight (${n})";
    } else if(n >= 24.9 && n < 29.9){
      _infoText = "Slightly overweight (${n})";
    } else if(n >= 29.9 && n < 34.9){
      _infoText = "Grade I Obesity (${n})";
    } else if(n >= 34.9 && n <= 39.9){
      _infoText = "Grade II Obesity (${n})";
    } else {
      _infoText = "Grade III Obesity (${n})";
    }
    });

  }
  
  void _resetFields(){
    setState(() {
    weightController.text = "";
    heightController.text = "";
    _infoText = "Fill in the fields";
    _formKey = GlobalKey<FormState>();
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculate your BMI"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
          onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.person_outline, size: 120.0, color: Colors.green),
          
          TextFormField(keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Weight (Kg)",
            labelStyle: TextStyle(color: Colors.green)
          ),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 20.0),
          controller: weightController,
          validator: (value){
            if(value.isEmpty){
              return "Insert your weight";
            } 
          },
          ),

          TextFormField(keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Height (cm)",
            labelStyle: TextStyle(color: Colors.green)
          ),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.green, fontSize: 20.0),
          controller: heightController,
          validator: (value){
            if(value.isEmpty){
              return "Insert your height";
            } 
          }
          ),

          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Container(
            height: 50.0,
            child: RaisedButton(
            onPressed: (){
              if(_formKey.currentState.validate()){
                _calculate();
              }
            },
            child: Text("Calculate", style: TextStyle(color: Colors.white, fontSize: 25.0)),
            color: Colors.green,
          ),
          ),
          ),

          Text(
            _infoText,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 25.0),
          ),


        ],
      ),
        ),
      ),
    );
  }
}



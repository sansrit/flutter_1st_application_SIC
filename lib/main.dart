import 'package:flutter/material.dart';

void main(){
  runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: ' simple interest calc',
          home: SIForm(), 
            theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.indigo,
            accentColor: Colors.indigoAccent,
          ),    //stateful widget will be created below
        ),


  );
}

class SIForm extends StatefulWidget{    //creating staeful widgets
  @override
  State<StatefulWidget> createState() {
  
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm>{ //defining state with some properties inside

   var _formkey = GlobalKey<FormState>();

   var _currencies = ['Rupees', 'Dollers', 'yuan'];
   final _minimumPadding = 5.0;

   var _currentItemSelected = '';

   TextEditingController principalController = TextEditingController();
   TextEditingController roiController = TextEditingController();
   TextEditingController timeController = TextEditingController();
   var displayResult = '';

  @override

      void initState(){
        super.initState();
        _currentItemSelected = _currencies[0];

      }

  Widget build(BuildContext context) {
  
      TextStyle textStyle = Theme.of(context).textTheme.title;
              return Scaffold(
                // resizeToAvoidBottomPadding: false,
                appBar: AppBar(
                  title: Text('SIMPLE INTEREST CALCULATOR'),
                ),

                body: Form(
                  key: _formkey, //this key provides current status of a form
                  child: Padding(
                    

                        padding: EdgeInsets.all(_minimumPadding*2),
                          child: ListView(
                          children: <Widget>[

                            getImageAsset(),
                            
                            Padding(
                              
                              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),

                              child: TextFormField(
                              style: textStyle,
                              controller: principalController,
                              validator: (String value){
                                if (value.isEmpty){
                                  return 'Please enter principal amount';
                                }
                              },
                              keyboardType: TextInputType.number ,
                              decoration: InputDecoration(
                                labelText: 'Principle',
                                hintText: 'Enter Amt e.g 10000',
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                                ),
                              ),
                            )),


                            Padding(

                              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),

                              child:TextFormField(
                              
                              keyboardType: TextInputType.number ,
                              style: textStyle,
                              controller: roiController,
                              validator: (String value){
                                if (value.isEmpty){
                                  return 'Please enter Rate in %';
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Rate',
                                hintText: 'Enter Rate In Percentage ',
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ), 
                          ),    

                        
                        Padding(
                              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                              child:
                          Row(
                          children: <Widget>[

                              Expanded(
                                child: TextFormField(
                              style: textStyle,
                              controller: timeController,
                              validator: (String value){
                                if (value.isEmpty){
                                  return 'Please enter proper time';
                                }
                              },
                              keyboardType: TextInputType.number ,
                              decoration: InputDecoration(
                                labelText: 'Time',
                                hintText: 'Enter time In years ',
                                labelStyle: textStyle,
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                                ),
                              ),
                           ), 
                         ),

                            Container(
                              width: _minimumPadding*5,
                            ),
                              
                                            Expanded(
                                              
                                              child:   DropdownButton<String>(
                                              items: _currencies.map((String value){
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),

                                              value: _currentItemSelected,

                                              onChanged: (String newValueSelected){
                                                //code to execute when new value is selected

                                                _onDropDownItemSelected(newValueSelected);

                                              }

                                            ), 
                                            ),
                                        

                                      


                                          ],

                                        ),),

                          Padding(
                              padding: EdgeInsets.only(bottom: _minimumPadding, top: _minimumPadding),
                                  child: Row(children: <Widget>[
                                      Expanded(
                                        child: RaisedButton(
                                            color:Theme.of(context).accentColor,
                                            textColor: Colors.white,
                                            child: Text('Calculate', textScaleFactor: 1.5,),
                                            onPressed: (){    //event handler


                                            setState(() {
                                              if(_formkey.currentState.validate()){   //if user input is valid then only calculates total
                                              this.displayResult = _calculateTotalReturns();
                                              }

                                            });
                                          

                                            },
                                        ), ),


                        Expanded(
                        child: RaisedButton(
                            color:Colors.redAccent,
                            textColor: Colors.white,

                            child: Text('Reset', textScaleFactor: 1.5,),
                            onPressed: (){   //event handler

                            setState(() {

                                _reset(); 
                            });
                           

                            },
                        ), ),


                    ],),),   

                    Padding(
                      padding: EdgeInsets.all(_minimumPadding*2),
                      child: Text(this. displayResult, style: textStyle),
                         ),

                    
                          ],
                        ),
                 
                ),
                )
              );
  }

              Widget getImageAsset(){
                AssetImage assetImage = AssetImage('images/dn.jpeg');
                Image image = Image(image: assetImage,);

                return Container(
                  child: image,
                  margin: EdgeInsets.all(_minimumPadding*10) ,);
              }

              _onDropDownItemSelected(String newValueSelected){

                    setState(() {
                     this._currentItemSelected = newValueSelected;
                    });
              }

              String _calculateTotalReturns(){
                double principal = double.parse(principalController.text); 
                double roi = double.parse(roiController.text);
                double time = double.parse(timeController.text);

                double totalAmpuntPayable = principal +(principal*roi*time)/100;
                String result = ' After $time years , your investment will be $totalAmpuntPayable  $_currentItemSelected';
                return result;
              }

              void _reset(){

                principalController.text = '';
                roiController.text = '';
                timeController.text = '';
                displayResult = '';
                
                _currentItemSelected = _currencies[0];

              }
}



 

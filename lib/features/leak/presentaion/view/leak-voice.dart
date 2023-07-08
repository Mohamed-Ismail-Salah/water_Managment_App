import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class LeakVoice extends StatefulWidget{
  @override
  State<LeakVoice> createState() => _LeakVoiceState();
}

class _LeakVoiceState extends State<LeakVoice> {
  FilePickerResult?_data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Leak Data Voice")),
      ),
        body: getBody()
    );

  }


  Widget  getBody(){
    if(_data==null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 30,),
          Container(

              height: 150,

              width: 150,

              child: Image.asset("assets/images/file audio.png",)),

          SizedBox(height: 30,),

          Text("You must upload a audio file for hydrophone Sensor",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 25,
            ),
          ),

          SizedBox(height: 80,),
          ElevatedButton(

            style:
            ButtonStyle(
              maximumSize:MaterialStateProperty.all(const Size(200, 40)),
              backgroundColor:MaterialStateProperty.all<Color>(Colors.black),
              textStyle: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return TextStyle(fontSize: 35, );
                }
                return TextStyle(fontSize: 20, );
              }),
            ) ,
            child: const Text("Upload audio FIle",style: TextStyle(color: Colors.blue),),
            onPressed:(){
              _pickFile();
            },
          ),




        ],
      );
    }else
    {

      return

        Column(
            children: [


              ElevatedButton(

                style:
                ButtonStyle(
                  maximumSize:MaterialStateProperty.all(const Size(200, 40)),
                  backgroundColor:MaterialStateProperty.all<Color>(Colors.black),
                  textStyle: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return TextStyle(fontSize: 35, );
                    }
                    return TextStyle(fontSize: 20, );
                  }),
                ) ,
                child: const Text("Branched-hydrophone",style: TextStyle(color: Colors.blue),),
                onPressed:(){
                  setState(() {
                    print(_data);

                  });


                },
              ),



              ElevatedButton(

                style:
                ButtonStyle(
                  maximumSize:MaterialStateProperty.all(const Size(200, 40)),
                  backgroundColor:MaterialStateProperty.all<Color>(Colors.black),
                  textStyle: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return TextStyle(fontSize: 35, );
                    }
                    return TextStyle(fontSize: 20, );
                  }),
                ) ,
                child: const Text("looped-hydrophone",style: TextStyle(color: Colors.blue),),
                onPressed:(){
                  setState(() {
                    print(_data);

                  });


                },
              ),



            ]
        );



    }

  }

  void _pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
  type:FileType.audio
  );
  if (result == null) {
  print("No file selected");
  } else {
    print(result.files.single.name);
    setState(() {
      _data = result;
    });

  }


  }


}
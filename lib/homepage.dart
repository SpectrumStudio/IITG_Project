import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File? imageFile;

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please choose an option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              InkWell(
                onTap: (){
                  _getFromCamera();
               },
                child: Row(
                  children: const [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.camera,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    'Camera', style: TextStyle(fontSize:20,color: Colors.purple),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8,),

            InkWell(
              onTap: (){
                _getFromGallery();
              },
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.image,
                      color: Colors.yellow,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    'Gallery',
                    style: TextStyle(fontSize:20,color: Colors.green),
                  ),
                ],
              ),
            ),

          ],
        ),
      );
    }
    );
  }



  void _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 1080,
      maxWidth: 1080,
    ) ;
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    File? croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    if(croppedImage!= null) {
      setState(() {
        imageFile = croppedImage;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [

            const SizedBox(height:  40,),

            Container(
                child: const Text(
                  'IITG ML PROJECT',
                  textAlign: TextAlign.center,
                  style: TextStyle(backgroundColor: Colors.yellow,color: Colors.black,fontSize: 28,fontWeight: FontWeight.w200),

                )
            ),

            const SizedBox(height:  30,),
            imageFile != null?


            GestureDetector(
              onTap: (){
                _showImageDialog();
              },
              child: Image.file(imageFile!),
            ) :

            GestureDetector(
              onTap: (){
                _showImageDialog();
              },
              child: Icon(
                Icons.camera_enhance_rounded,
                color: Colors.blue,
                size: MediaQuery.of(context).size.width * .8,
              ),
            )

          ],
        )
    );
  }
}

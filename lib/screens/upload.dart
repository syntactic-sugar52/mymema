// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:my_mema/components/progress.dart';
import 'dart:io';
import 'package:image/image.dart' as Im;
import 'package:my_mema/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:my_mema/screens/root/root.dart';

class Upload extends StatefulWidget {
  final Users currentUser;
  Upload({this.currentUser});
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload>
    with AutomaticKeepAliveClientMixin<Upload> {
  TextEditingController captionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController requirementController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  bool isUploading = false;
  File file;
  String postId = Uuid().v4();
  final imagePicker = ImagePicker();
  User firebaseAuth = FirebaseAuth.instance.currentUser;
  List<TypeItem> _dropdownItems = [
    TypeItem(1, "Product"),
    TypeItem(2, "Service"),
    TypeItem(3, "Money"),
    TypeItem(4, "Referral"),
    TypeItem(5, "Information"),
    TypeItem(6, "Investment")
  ];

  List<DropdownMenuItem<TypeItem>> _dropdownMenuItems;
  TypeItem _selectedItem;
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<TypeItem>> buildDropDownMenuItems(List typeItems) {
    List<DropdownMenuItem<TypeItem>> items = List();
    for (TypeItem typeItem in typeItems) {
      items.add(
        DropdownMenuItem(
          child: Text(typeItem.name),
          value: typeItem,
        ),
      );
    }
    return items;
  }

  handleImageFromCamera() async {
    Navigator.pop(context);
    final picked = await imagePicker.getImage(
        source: ImageSource.camera, maxHeight: 675, maxWidth: 960);
    if (picked != null) {
      setState(() {
        file = File(picked.path);
      });
    }
  }

  handleImageFromGallery() async {
    Navigator.pop(context);
    final picked = await imagePicker.getImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        file = File(picked.path);
      });
    }
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text("Create Post"),
            children: [
              SimpleDialogOption(
                child: Text("Photo with Camera"),
                onPressed: () {
                  handleImageFromCamera();
                },
              ),
              SimpleDialogOption(
                child: Text("Photo from Gallery"),
                onPressed: () {
                  handleImageFromGallery();
                },
              ),
              SimpleDialogOption(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  Scaffold buildSplashScreen() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Container(
          color: Colors.white54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/upload.svg',
                height: 260.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    "Upload Image",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                  color: Colors.deepOrange,
                  onPressed: () => selectImage(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  clearImage() {
    setState(() {
      file = null;
    });
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 90));
    setState(() {
      file = compressedImageFile;
    });
  }

  Future<String> uploadImage(imageFile) async {
    StorageUploadTask uploadTask =
        storageRef.child("post_$postId.jpg").putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  createPostInFirestore(
      {String mediaUrl,
      String location,
      String description,
      String type,
      String reason,
      String item,
      String requirement}) {
    List<String> type = [];
    type.add(_selectedItem.name);
    postsRef
        .doc(widget.currentUser.uid)
        .collection("userPosts")
        .doc(postId)
        .set({
      "postId": postId,
      "ownerId": widget.currentUser.uid,
      "username": widget.currentUser.username,
      "mediaUrl": mediaUrl,
      "location": location,
      "description": description,
      "item": item,
      "reason": reason,
      "requirements": requirement,
      "type": type,
      "timestamp": timestamp,
      "views": {}
    });
  }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage(file);
    // List<TypeItem> typeItem = [];
    // typeItem.add(_selectedItem);
    createPostInFirestore(
      mediaUrl: mediaUrl,
      location: locationController.text,
      description: captionController.text,
      reason: reasonController.text,
      item: itemController.text,
      requirement: requirementController.text,
      type: _selectedItem.toString(),
    );
    captionController.clear();
    locationController.clear();
    requirementController.clear();
    itemController.clear();
    reasonController.clear();
    setState(() {
      file = null;
      isUploading = false;
      postId = Uuid().v4();
    });
  }

  getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0]
    String completeAddress =
        '${placemark.subAdministrativeArea} ,${placemark.position} ,${placemark.country}, ${placemark.name}, ${placemark.administrativeArea} ,${placemark.isoCountryCode}, ${placemark.locality} ,${placemark.thoroughfare}, ${placemark.postalCode},${placemark.subAdministrativeArea}, ${placemark.subLocality}';
    print(completeAddress);
    String formattedAddress = "${placemark.locality}, ${placemark.country}";
    locationController.text = formattedAddress;
  }

  Scaffold buildUploadForm() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: clearImage,
        ),
        title: Text(
          "",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          FlatButton(
            onPressed: isUploading ? null : () => handleSubmit(),
            child: Text(
              "Post",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          isUploading ? linearProgress() : Text(""),
          Container(
            height: 220.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(file),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          ListTile(
            leading: Text(
              "Item:",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              // backgroundImage:
              // CachedNetworkImageProvider(widget.currentUser.photoUrl),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 250.0,
                  alignment: Alignment.centerRight,
                  child: TextField(
                    textAlign: TextAlign.center,
                    maxLines: 6,
                    minLines: 3,
                    controller: itemController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(),
                      hintText: "What's your item",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Text(
              "Description:",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              //   backgroundImage:
              //   CachedNetworkImageProvider(widget.currentUser.photoUrl),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 250.0,
                  // alignment: Alignment.centerRight,
                  child: TextField(
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    controller: captionController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(),
                      hintText: "Write a Description of your item.",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Text(
              "Type:",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            // leading: Icon(Icons.adjust_rounded,
            //     color: Colors.deepOrange, size: 35.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 250.0,
                  child: DropdownButton<TypeItem>(
                      value: _selectedItem,
                      items: _dropdownMenuItems,
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value;
                        });
                      }),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Text(
              "Requirements:",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            // leading: Icon(Icons.adjust_rounded,
            //     color: Colors.deepOrange, size: 35.0),
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 250.0,
                  child: TextField(
                    maxLines: 6,
                    minLines: 3,
                    textAlign: TextAlign.center,
                    controller: requirementController,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(),
                        hintText: "What do you require for the trade?",
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Text(
              "Reason :",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            // leading: Icon(Icons.adjust_rounded,
            //     color: Colors.deepOrange, size: 35.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 250.0,
                  child: TextField(
                    textAlign: TextAlign.center,
                    maxLines: 6,
                    minLines: 3,
                    controller: reasonController,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(),
                        hintText: "Why do you want to trade?",
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Text(
              "Location",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            // leading: Icon(
            //   Icons.pin_drop,
            //   color: Colors.deepOrange,
            //   size: 35.0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 250.0,
                  child: TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                        hintText: "Where was this photo taken?",
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 200.0,
            height: 100.0,
            alignment: Alignment.center,
            child: RaisedButton.icon(
              label: Text(
                "Use Current Location",
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.blue,
              onPressed: () {},
              icon: Icon(
                Icons.my_location,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return file == null ? buildSplashScreen() : buildUploadForm();
  }
}

class TypeItem {
  int value;
  String name;

  TypeItem(this.value, this.name);
}

import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:apptracker/services/firebaseServices.dart';
import 'dart:html';
import 'components/customPageRoute.dart';
import 'components/gradientElevatedbutton.dart';
// import 'dart:developer' as developer;
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:apptracker/screens/dasboard.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:apptracker/model/appInfoModel.dart';

class HomePage extends StatefulWidget {
  final String? docID;
  final AppInfoModel? instanse;
  const HomePage({
    Key? key,
    this.docID,
    this.instanse,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // File file;
  bool isLoading = false;
  String buttonText = "create";
  late DropzoneViewController controller;
  TextEditingController appNameController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController apiKeyController = TextEditingController();
  File? img;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> osCatgories = ["Android", "iOS", "UWP"];
  String? selected;
  bool isSelected = true;
  bool isImageSelected = true;
  bool isUpdateImage = false;
  late Timer _timer;

  int bgColor = 0xffFFF9F9;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.instanse != null) {
      setState(() {
        isUpdateImage = true;
        isImageSelected = true;
        appNameController.text = widget.instanse!.appname.toString();
        ownerNameController.text = widget.instanse!.ownername.toString();
        apiKeyController.text = widget.instanse!.xAPIToken.toString();
        selected = widget.instanse!.os;
        buttonText = "update";
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(bgColor),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                "assets/images/homepage_left_vector.png",
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Stack(
                  children: [
                    DropzoneView(
                      onCreated: (controller) => this.controller = controller,
                      onDrop: onDroup,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.43,
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          shadowColor: const Color(0xff000000),
                          elevation: 9,
                          margin: const EdgeInsets.all(100),
                          color: const Color(0xffFFFFFF),
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(50, 18, 50, 0),
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(scrollbars: false),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ListView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: [
                                          const Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Admin",
                                              style: TextStyle(
                                                color: Color(0xff000000),
                                                fontFamily: "Nunito",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 23,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 4),
                                            child: Text(
                                              "App Name",
                                              style: TextStyle(
                                                color: Color(0xff000000),
                                                fontFamily: "NunitoSemiBold",
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 8),
                                            child: TextFormField(
                                              controller: appNameController,
                                              validator: (value) => value ==
                                                          null ||
                                                      value.isEmpty
                                                  ? "App name can't be empty"
                                                  : null,
                                              style: const TextStyle(
                                                color: Color(0xff000000),
                                                fontFamily: "NunitoSemiBold",
                                                fontSize: 18,
                                              ),
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                filled: true,
                                                hintStyle: const TextStyle(
                                                  color: Color(0xffBABABA),
                                                ),
                                                hintText: "Enter app name",
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 4),
                                            child: Text(
                                              "Owner Name",
                                              style: TextStyle(
                                                color: Color(0xff000000),
                                                fontFamily: "NunitoSemiBold",
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 8),
                                            child: TextFormField(
                                              controller: ownerNameController,
                                              validator: (value) => value ==
                                                          null ||
                                                      value.isEmpty
                                                  ? "Owner name can't be empty"
                                                  : null,
                                              style: const TextStyle(
                                                color: Color(0xff000000),
                                                fontFamily: "NunitoSemiBold",
                                                fontSize: 18,
                                              ),
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                filled: true,
                                                hintStyle: const TextStyle(
                                                  color: Color(0xffBABABA),
                                                ),
                                                hintText: "Enter Owner name",
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 4),
                                            child: Text(
                                              "Api Key",
                                              style: TextStyle(
                                                color: Color(0xff000000),
                                                fontFamily: "NunitoSemiBold",
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 8),
                                            child: TextFormField(
                                              controller: apiKeyController,
                                              validator: (value) =>
                                                  value == null || value.isEmpty
                                                      ? "Api-key can't be empty"
                                                      : null,
                                              style: const TextStyle(
                                                color: Color(0xff000000),
                                                fontFamily: "NunitoSemiBold",
                                                fontSize: 18,
                                              ),
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                filled: true,
                                                hintStyle: const TextStyle(
                                                  color: Color(0xffBABABA),
                                                ),
                                                hintText: "Enter Api-key",
                                                fillColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 8),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Upload app icon",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff000000),
                                                          fontFamily:
                                                              "NunitoSemiBold",
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      DottedBorder(
                                                        borderType:
                                                            BorderType.RRect,
                                                        radius: const Radius
                                                            .circular(10),
                                                        dashPattern: const [
                                                          3,
                                                          3
                                                        ],
                                                        color: const Color(
                                                            0xff000000),
                                                        strokeWidth: 1,
                                                        child: Container(
                                                          width: 155,
                                                          height: 38,
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  4, 0, 4, 0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              img == null &&
                                                                      isUpdateImage ==
                                                                          false
                                                                  ? const Expanded(
                                                                      child:
                                                                          Text(
                                                                        "Drag and \ndrop or",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xff979797),
                                                                          fontFamily:
                                                                              "NunitoSemiBold",
                                                                          fontSize:
                                                                              12,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : const Expanded(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .done_rounded,
                                                                        size:
                                                                            28,
                                                                        color: Color(
                                                                            0xff34976C),
                                                                      ),
                                                                    ),
                                                              ElevatedButton(
                                                                style:
                                                                    ButtonStyle(
                                                                  splashFactory:
                                                                      NoSplash
                                                                          .splashFactory,
                                                                  shape: MaterialStateProperty
                                                                      .all<
                                                                          RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              3),
                                                                    ),
                                                                  ),
                                                                  backgroundColor:
                                                                      MaterialStateProperty
                                                                          .all(
                                                                    const Color(
                                                                      0xffD5EDFF,
                                                                    ),
                                                                  ),
                                                                  elevation:
                                                                      MaterialStateProperty
                                                                          .all(
                                                                              0),
                                                                  shadowColor:
                                                                      MaterialStateProperty.all(
                                                                          Colors
                                                                              .transparent),
                                                                ),
                                                                onPressed: () {
                                                                  onChoseFileClicked();
                                                                },
                                                                child:
                                                                    const Text(
                                                                  "choose file",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xff000000),
                                                                    fontFamily:
                                                                        "NunitoSemiBold",
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      isImageSelected
                                                          ? const Text(
                                                              "File supported: png, jpg, jpeg",
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff000000),
                                                                fontFamily:
                                                                    "Nunito",
                                                                fontSize: 10,
                                                              ),
                                                            )
                                                          : const Text(
                                                              "please chose a file",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontFamily:
                                                                    "Nunito",
                                                                fontSize: 10,
                                                              ),
                                                            )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "OS",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff000000),
                                                          fontFamily:
                                                              "NunitoSemiBold",
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 43,
                                                        decoration:
                                                            const ShapeDecoration(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: BorderSide(
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .solid,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  12),
                                                            ),
                                                          ),
                                                        ),
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child:
                                                                DropdownButton(
                                                              focusColor:
                                                                  Colors.white,
                                                              icon: const Icon(
                                                                Icons
                                                                    .keyboard_arrow_down_rounded,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              isDense: true,
                                                              hint: const Text(
                                                                'Select',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xffBABABA),
                                                                  fontFamily:
                                                                      "NunitoSemiBold",
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                              value: selected,
                                                              onChanged: (String?
                                                                  newValue) {
                                                                setState(() {
                                                                  isSelected =
                                                                      true;
                                                                  selected =
                                                                      newValue;
                                                                });
                                                              },
                                                              elevation: 9,
                                                              dropdownColor:
                                                                  Color(
                                                                      bgColor),
                                                              isExpanded: true,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              items: osCatgories
                                                                  .map((items) {
                                                                return DropdownMenuItem(
                                                                  enabled: true,
                                                                  child: Text(
                                                                    items,
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Color(
                                                                          0xff2C0033),
                                                                      fontFamily:
                                                                          "NunitoSemiBold",
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                  ),
                                                                  value: items,
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      isSelected
                                                          ? const SizedBox
                                                              .shrink()
                                                          : const Text(
                                                              "please select any one!",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontFamily:
                                                                    "Nunito",
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 18),
                                              child: GradientElevatedButton(
                                                borderRadius: 30,
                                                child: Text(
                                                  buttonText,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Nunito",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  buttonText == "create"
                                                      ? onCreateClicked(context)
                                                      : onUpdateClicked(
                                                          context);
                                                },
                                                height: 45,
                                                width: 350,
                                                shadow: false,
                                                startColor:
                                                    const Color(0xffFF58C6),
                                                endColor:
                                                    const Color(0xff501E82),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 55, 100, 0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          "assets/images/person_image.png",
                          cacheHeight: 115,
                          cacheWidth: 115,
                          height: 115,
                          width: 115,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GradientElevatedButton(
        borderRadius: 30,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Dashboard",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.arrow_forward_rounded,
              size: 24,
            ),
          ],
        ),
        onPressed: () {
          navigateToDashboard();
        },
        height: 48,
        width: 184,
        shadow: true,
        startColor: const Color(0xffFF6B84),
        endColor: const Color(0xff9D0071),
      ),
    );
  }

  navigateToDashboard() {
    Navigator.of(context).pushReplacement(
      CustomPageRoute(
        axisDirection: AxisDirection.down,
        child: const Dashboard(),
      ),
    );
  }

  // on drop method which assigns value to the file
  Future onDroup(value) async {
    img = await value;
    setState(() {
      isImageSelected = true;
      img;
    });
    debugPrint(value.name);
  }

  //whn chose file button clicked
  onChoseFileClicked() {
    FileUploadInputElement input = FileUploadInputElement();
    input.accept = '.png,.jpg,.jpeg'; //supported file format
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) async {
        img = file;
        setState(() {
          isImageSelected = true;
          img;
        });
        debugPrint(file.toString());
        debugPrint(img!.name);
      });
    });
  }

  bool formValidatior() {
    final FormState form = _formKey.currentState!;
    if (form.validate() && img != null && selected != null) {
      return true;
    } else {
      debugPrint('Form is invalid');
      setState(() {
        img == null ? isImageSelected = false : isImageSelected = true;
        selected == null
            ? isSelected = false
            : selected!.isEmpty
                ? isImageSelected = false
                : isSelected = true;
      });
      return false;
    }
  }

  onCreateClicked(BuildContext context) {
    formValidatior() ? sendDataToFirebase(context) : null;
  }

  sendDataToFirebase(BuildContext context) async {
    showPopUp(context);
    debugPrint('Form is valid');
    String url =
        await FirebaseServices.uploadImageToFirebaseStorage(image: img!);
    AppInfoModel instance = AppInfoModel();
    instance.appname = appNameController.text;
    instance.ownername = ownerNameController.text;
    instance.xAPIToken = apiKeyController.text;
    instance.imageUrl = url;
    instance.os = selected!;
    await FirebaseServices.createAppInfo(instance: instance);
  }

  showPopUp(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext builderContext) {
          _timer = Timer(const Duration(milliseconds: 1390), () {
            Navigator.of(context).pop();
            navigateToDashboard();
          });
          return _buildPopupDialog();
        }).then((value) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }

  _buildPopupDialog() {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      content: SizedBox(
        width: 308,
        height: 261,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                "assets/images/tick_animation_lotie.json",
                width: 135,
                height: 135,
                frameRate: FrameRate.max,
              ),
              const SizedBox(
                height: 27,
              ),
              Text(
                buttonText + "d successfully",
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w700,
                  fontSize: 19,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onUpdateClicked(BuildContext context) async {
    if (updateFormValidatior()) {
      if (isUpdated() || img != null) {
        AppInfoModel instance = AppInfoModel();
        instance.appname = appNameController.text;
        instance.ownername = ownerNameController.text;
        instance.xAPIToken = apiKeyController.text;
        instance.imageUrl = widget.instanse!.imageUrl;
        instance.os = selected!;
        await FirebaseServices.updateAppInfo(
          instance: instance,
          docId: widget.docID!,
          image: img,
        );
        showPopUp(context);
      } else {
        navigateToDashboard();
      }
    }
  }

  updateFormValidatior() {
    final FormState form = _formKey.currentState!;
    if (form.validate() && selected != null) {
      return true;
    } else {
      debugPrint('Form is invalid');
      setState(() {
        selected == null
            ? isSelected = false
            : selected!.isEmpty
                ? isImageSelected = false
                : isSelected = true;
      });
      return false;
    }
  }

  isUpdated() {
    if (widget.instanse!.appname.toString() != appNameController.text ||
        widget.instanse!.ownername.toString() != ownerNameController.text ||
        widget.instanse!.xAPIToken.toString() != apiKeyController.text ||
        widget.instanse!.os.toString() != selected ||
        img != null) {
      return true;
    } else {
      return false;
    }
  }
}
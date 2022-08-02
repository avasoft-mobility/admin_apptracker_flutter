import 'dart:async';
import 'components/gradientElevatedbutton.dart';
import 'package:apptracker/model/appInfoModel.dart';
import 'package:flutter/material.dart';
import 'package:apptracker/screens/homePage.dart';
import 'components/customPageRoute.dart';
import 'package:apptracker/services/firebaseServices.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Timer _timer;
  final CollectionReference allAppInfo =
      FirebaseFirestore.instance.collection('devappinfocloudfirestore');
  int bgColor = 0xffFFF9F9;
  TextStyle titleStyle = const TextStyle(
    color: Color(0xff000000),
    fontFamily: "Nunito",
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );
  TextStyle itemsStyle = const TextStyle(
    color: Color(0xff6D003B),
    fontFamily: "Nunito",
    fontSize: 16,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(bgColor),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    "assets/images/dashboard_left_vector.png",
                    height: 550,
                    cacheHeight: 550,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    "assets/images/dashboard_right_vector.png",
                    cacheHeight: 550,
                    height: 550,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(72, 70, 72, 75),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Projects",
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w700,
                      fontSize: 44,
                    ),
                  ),
                  const Text(
                    "Here is the list of all projects",
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: "Nunito",
                      fontSize: 24,
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: allAppInfo.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data == null ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text(
                                "No data available try creating a new one!",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 67, 0, 31),
                                  fontFamily: "NunitoSemiBold",
                                  fontSize: 18,
                                ),
                              ),
                            );
                          }

                          return Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                            color: const Color(0xffFFF0FE),
                            elevation: 4,
                            shadowColor: const Color(0xff000000),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(7.5, 8, 7.5, 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  40, 0, 0, 0),
                                              child: Text(
                                                "Application",
                                                style: titleStyle,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Owner",
                                              style: titleStyle,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Api-key",
                                                style: titleStyle,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Operating system",
                                              style: titleStyle,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 68, 0),
                                              child: Text(
                                                "Actions",
                                                style: titleStyle,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final DocumentSnapshot
                                            documentSnapshot =
                                            snapshot.data!.docs[index];
                                        return buildAppInfo(documentSnapshot);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              "Error in establishing connection with firebase!",
                              style: TextStyle(
                                color: Color.fromARGB(255, 67, 0, 31),
                                fontFamily: "NunitoSemiBold",
                                fontSize: 18,
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 7,
                                  backgroundColor: Color(0xffA63EC5),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xffF56D91))));
                        }
                      },
                    ),
                  )
                ],
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
              "Create new",
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
          Navigator.of(context).pushReplacement(
            CustomPageRoute(
              axisDirection: AxisDirection.up,
              child: HomePage(),
            ),
          );
        },
        height: 48,
        width: 184,
        shadow: true,
        startColor: const Color(0xffFF6B84),
        endColor: const Color(0xff9D0071),
      ),
    );
  }

  Widget buildAppInfo(DocumentSnapshot snapshot) {
    var docID = snapshot.id;
    var instanceOfAppInfo =
        AppInfoModel.fromJson(snapshot.data()! as Map<String, dynamic>);

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
      ),
      color: const Color(0xffFFE5F3),
      elevation: 4,
      shadowColor: const Color.fromARGB(187, 192, 80, 142),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 50, 0),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            instanceOfAppInfo.imageUrl!.isNotEmpty
                ? Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 192, 80, 142),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        )),
                    width: 47,
                    height: 47,
                    padding: EdgeInsets.zero,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.network(
                        instanceOfAppInfo.imageUrl!,
                        fit: BoxFit.cover,
                        cacheHeight: 47,
                        cacheWidth: 47,
                        width: 47,
                        height: 47,
                      ),
                    ),
                  )
                : Icon(
                    Icons.image_rounded,
                    color: itemsStyle.color,
                    size: 47,
                  ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    instanceOfAppInfo.appname.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: itemsStyle,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    instanceOfAppInfo.ownername.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: itemsStyle,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: SafeArea(
                  child: Text(
                    instanceOfAppInfo.xAPIToken.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: itemsStyle,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  instanceOfAppInfo.os.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: itemsStyle,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                      child: IconButton(
                        hoverColor: const Color.fromARGB(100, 233, 59, 129),
                        highlightColor: Colors.white,
                        icon: Icon(
                          Icons.edit_rounded,
                          color: itemsStyle.color,
                        ),
                        onPressed: () {
                          showEditPopUp(context, docID, instanceOfAppInfo);
                        },
                      ),
                    ),
                    IconButton(
                      highlightColor: Colors.white,
                      hoverColor: const Color.fromARGB(100, 233, 59, 129),
                      icon: Icon(
                        Icons.delete_rounded,
                        color: itemsStyle.color,
                      ),
                      onPressed: () {
                        showAlertPopUp(
                            context, docID, instanceOfAppInfo.imageUrl!);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showAlertPopUp(
    BuildContext context,
    String docID,
    String imageUrl,
  ) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext builderContext) {
          return _buildAlertPopupDialog(docID, imageUrl);
        });
  }

  _buildAlertPopupDialog(String docID, String imageUrl) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      title: const Center(
        child: Text(
          "Alert",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ),
      content: SizedBox(
        width: 308,
        height: 161,
        child: Center(
          child: LottieBuilder.asset(
            "assets/images/alert_animation_lotie.json",
            width: 135,
            height: 135,
            frameRate: FrameRate.max,
          ),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OutlinedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 42),
                  ),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'close',
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              GradientElevatedButton(
                shadow: true,
                endColor: const Color(0xffFF005C),
                startColor: const Color(0xffFF6B7D),
                onPressed: () {
                  Navigator.of(context).pop();
                  showDeletePopUp(context, docID, imageUrl);
                },
                child: const Text(
                  "delete",
                  style: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                borderRadius: 30,
                width: 120,
                height: 33,
              ),
            ],
          ),
        ),
      ],
    );
  }

  showDeletePopUp(BuildContext context, String docID, String imageUrl) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext builderContext) {
          _timer = Timer(const Duration(milliseconds: 1550), () {
            Navigator.of(context).pop();
            Future.delayed(const Duration(seconds: 3));
            FirebaseServices.deleteAppInfo(docID: docID, url: imageUrl);
          });
          return _buildDeletePopupDialog();
        }).then((value) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }

  _buildDeletePopupDialog() {
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
                "assets/images/delete_animation_lotie.json",
                width: 155,
                height: 155,
                frameRate: FrameRate.max,
              ),
              const SizedBox(
                height: 27,
              ),
              const Text(
                "Deleted successfully",
                style: TextStyle(
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

  showEditPopUp(BuildContext context, String docID, AppInfoModel instanse) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext builderContext) {
          _timer = Timer(const Duration(milliseconds: 1600), () {
            Navigator.of(context).pushReplacement(
              CustomPageRoute(
                axisDirection: AxisDirection.up,
                child: HomePage(docID: docID, instanse: instanse),
              ),
            );
          });
          return _buildEditPopupDialog();
        }).then((value) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }

  _buildEditPopupDialog() {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      content: SizedBox(
        width: 308,
        height: 261,
        child: Center(
          child: LottieBuilder.asset(
            "assets/images/loading3_animation_lotie.json",
            width: 250,
            height: 250,
            frameRate: FrameRate.max,
          ),
        ),
      ),
    );
  }
}
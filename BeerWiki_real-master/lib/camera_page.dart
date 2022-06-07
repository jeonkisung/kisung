import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tflite/tflite.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;

  const CameraPage({this.cameras, Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;

  static AudioCache player = new AudioCache();

  XFile? pictureFile;
  bool pic_exist = false;
  late PageController _pageController;
  int activePage = 0;
  bool is_loading = false;
  bool camera_btn = true;

  // 초기화
  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,


    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    int pic_len = context
        .read<ListBundle>()
        .pictureList
        .length; // 홈페이지를 갔다 오면 슬라이더에 마지막 사진으로 이동하기 위해
    if (pic_len <= 0) {
      pic_len = 0;
    } else {
      pic_len = pic_len - 1;
    }
    activePage = pic_len;
    _pageController =
        PageController(viewportFraction: 0.3, initialPage: activePage);
    loadModel().then((value) {
      // 모델 불러옴
      setState(() {});
    });


  }


  // 모델과 label.txt를 가져온다.
  // void loadModel() async {
  //   print('loadModel() !!');
  //   await Tflite.loadModel(
  //     model: 'assets/mobilenet_imagenet_model2.tflite', labels: 'assets/labels.txt',);
  // }
  loadModel() async {
    await Tflite.loadModel(
      // Tflite 객체에 모델 장착
      //model: "assets/mobilenet_imagenet_model.tflite",
      //model: "assets/beer_model_kor_beer_bigsize_01.tflite",
      //model: "assets/beer_model_220504_kor_label.tflite",
      //model: "assets/beer_model_220509_label_300_300.tflite",
      model: "assets/beer_model_220509_label_244_244.tflite",
      //model: "assets/beer_model_220508_label.tflite",
      //model: "assets/beer_model_220508_label_244_400.tflite",
      //model: "assets/beer_model_220508_label_244_350.tflite",
      //model: "assets/beer_model_220508_label_244_300.tflite",
      //model: "assets/beer_model_220508_label_244_244.tflite",
      //model: "assets/beer_model_220508_label_200_350.tflite",
      //model: "assets/beer_model_220508_label_300_300.tflite",

      //model: "assets/beer_model_20220503.tflite",
      labels: "assets/labels.txt",
    ).then((value) {
      setState(() {});
    });
  }

  // 사진을 찍었을때 슬라이더를 찍은 사진으로 표시하기 위해
  void initState_page(page) {
    is_loading = true; // 사진은 찍혔고 모델 output은 나오지 않아 기달릴때 take picture 제어
    _pageController.jumpToPage(page);
  }

  // 이미지 분류
  Future classifyImage(File image) async {
    var a = image.path;
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        // defaults to 117.0
        imageStd: 255.0,
        // defaults to 1.0
        numResults: 73,
        // defaults to 5
        threshold: 0.2,
        // defaults to 0.1
        asynch: true // defaults to true
        );

    int count_time = 0;
    while (count_time < 20) {
      // 0.1초씩 20번 돌려서 그사이에 output나오면 break
      print('@@@ sleep count_time count_time : $count_time  @@@ ');
      if (output!.length != 0) {
        break;
      }
      count_time += 1;
      //sleep(Duration(milliseconds: 100));
      await Future.delayed(Duration(milliseconds: 100));
    }

    var out_len = output!.length;
    // 찾지못했을때를 Default로 설정
    var label_value = '찾지 못했습니다.';
    double conf_value = 0.0;
    var desc_value = '칮지 못했습니다.';

    print('#####################   Output   #######################');
    print(output);
    print('#####################   Output   #######################');

    // output을 2,3개씩 가져오는 경우가 있어 마지막꺼만 리스트에 add 되게 설정
    if (out_len != 0) {
      output.forEach((op_each) {
        label_value = op_each['label'];
        conf_value = double.parse(op_each['confidence'].toStringAsFixed(3));
        desc_value = '맛있어요, 청량감 있어요, Good, Not Bad, Cool, 오이시이';
      });
    } else {
      print('#####  output 없음...!! #######');
    }
    setState(() {
      context
          .read<ListBundle>()
          .add_list(label_value, conf_value, desc_value); // 리스트에 저장
      is_loading = false; //로딩 해제
      camera_btn = true; //사진 연속 두번 눌리지 않게 제어
    });
  }


  // 페이지 종료시 카메라, 모델 close
  @override
  void dispose() {
    controller.dispose();
    Tflite.close();
    super.dispose();
  }

  // 화면 나타냄
  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      // if문은 카메라가 초기화 되지 않았을때 처리하는 if
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    //Future.delayed(Duration.zero, () => showDialog(context));
    Future.delayed(
        Duration(milliseconds: 300),
        () => context.read<ListBundle>().popclose == false
            ? showDialog(context)
            : print('zz'));
    //Future.delayed(Duration(milliseconds: 100));

    //return MaterialApp(
//    debugShowCheckedModeBanner: false, // debug 라벨
    return Container(
        // 배경색을 top에서 bottom 까지 적용하기위해 Container안에 Scaffold를 넣음
        decoration: BoxDecoration(
            // 배경화면 gridient
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.black,
            Colors.deepOrange,
            Colors.yellow,
          ],
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // Bottom Overflower ~~... 발생
          resizeToAvoidBottomInset: false,
          //추가하고 body를 SingleChildScrollView로 감싼다.
          appBar: AppBar(
              title: Text(
                '라벨이 나오도록 찍어주세요',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              backgroundColor: Colors.deepOrangeAccent),
          //appBar: AppBar(title: Text('Take a Picture'),),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    // 카메라 뷰화면
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                        height: 380,
                        width: 250,
                        child: CameraPreview(controller),
                      ),
                    ),
                  ),
                  Padding(
                      // 갤러리에 저장, 체크박스, 사진버튼 을 한 Row에
                      padding: const EdgeInsets.all(0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(2.0), // 체크박스 보더
                                  ),
                                  side: MaterialStateBorderSide.resolveWith(
                                    (states) => BorderSide(
                                        width: 2.0,
                                        color: Colors.white), // 체크박스 보더
                                  ),
                                  activeColor: Colors.white,
                                  checkColor: Colors.red,
                                  value:
                                      context.read<ListBundle>().gallery_save,
                                  onChanged: (value) {
                                    setState(() {
                                      context.read<ListBundle>().gallery_save =
                                          value!; // 체크 유무에 따라 mainpage의 gallery_save 값 변경
                                    });
                                  }),
                            ),
                            Text(
                              'Gallery에 저장     ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            ElevatedButton(
                              // 카메라 버튼
                              onPressed: () async {
                                // 누르면
                                if (camera_btn) {
                                  // 2중 클릭 방지
                                  pictureFile =
                                      await controller.takePicture(); // 사진찍기
                                  setState(() {
                                    pic_exist = true;
                                    camera_btn = false;
                                  });


                                  if (pic_exist) {
                                    if (context
                                            .read<ListBundle>()
                                            .pictureList
                                            .length >
                                        20) {
                                      // 사진이 20장이 넘으면 앞에서 부터 지운다.
                                      context
                                          .read<ListBundle>()
                                          .del_first_pic();
                                      context
                                          .read<ListBundle>()
                                          .del_first_list();
                                    }
                                    context.read<ListBundle>().add_pic_list(
                                        pictureFile!); // 사진을 리스트에 넣는다.
                                    context.read<ListBundle>().add_list(
                                        'should_be_changed',
                                        'should_be_changed',
                                        'should_be_changed'); // 모델의 output이 나오기 까지 시간이 걸려 label등의 값을 임의의 값으로 넣고 output이 나오면 update

                                    classifyImage(
                                        File(pictureFile!.path)); // 이미지 분류
                                  }
                                  //player.play('camera_sound.mp3', mode: PlayerMode.LOW_LATENCY); // 카메라 셔터 사운드
                                  player.play('camera_sound_02.mp3', mode: PlayerMode.MEDIA_PLAYER); // 카메라 셔터 사운드

                                  var pList_len = context
                                      .read<ListBundle>()
                                      .pictureList
                                      .length; //이미지 리스트의 길이
                                  print('pictureList.length :  $pList_len ');
                                  // 아래 주석은 리스트값들을 확인하기 위한 for문
                                  // context.read<ListBundle>().pictureList.forEach((pic) {
                                  //   var picpath = pic.path;
                                  //   print('picture :  $picpath ');
                                  // });
                                  // context.read<ListBundle>().label_list.forEach((la) {
                                  //   print('label :  $la ');
                                  // });
                                  // context.read<ListBundle>().conf_list.forEach((co) {
                                  //   print('conf :  $co ');
                                  // });

                                  if (context.read<ListBundle>().gallery_save) {
                                    // 갤러리에 저장 하겠다고 체크되어있으면 저장
                                    GallerySaver.saveImage(pictureFile!.path)
                                        .then((value) =>
                                            print('>>>> save value= $value'))
                                        .catchError((err) {
                                      print('error :( $err');
                                    });
                                  }
                                  if (context
                                          .read<ListBundle>()
                                          .pictureList
                                          .length >
                                      0) {
                                    //  사진리스트가 0이 아니면
                                    initState_page(
                                        pList_len); // 슬라이더가 방금찍은것을 가리키도록
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                // 카메라 모양 버튼
                                primary: is_loading == false
                                    ? Colors.indigoAccent
                                    : Colors.grey,
                                // 찍고 모델에서 output이 아직 나오지 않았다면 gray
                                minimumSize: Size(80, 50),
                              ),
                              //child: const Text('Capture Image7'),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 40,
                              ),
                            ),
                          ])),
                  // 사진이 있으면 슬라이더 보여주기 if
                  if (context.read<ListBundle>().pictureList.length > 0)
                    Container(
                        child: Center(
                            child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: PageView.builder(
                              itemCount:
                                  context.read<ListBundle>().pictureList.length,
                              pageSnapping: true,
                              controller: _pageController,
                              onPageChanged: (page) {
                                setState(() {
                                  activePage = page;
                                });
                              },
                              itemBuilder: (context, pagePosition) {
                                bool active = pagePosition == activePage;
                                return slider(
                                    context.read<ListBundle>().pictureList,
                                    pagePosition,
                                    active);
                              }),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: indicators(
                                context.read<ListBundle>().pictureList.length,
                                activePage))
                      ],
                    ))),
                  // 라벨이 있으면 라벨 등을 보여주기위한 if
                  context.read<ListBundle>().label_list.length > 0
                      ? is_loading ==
                              false // 아직 읽고있으면(output기달리면) 로딩중보여주고 끝났으면 값 보여주고
                          ? Container(
                              child: Column(children: <Widget>[
                              Text(
                                ' 라벨 : ${context.read<ListBundle>().label_list[activePage]} \n 정확도 : ${context.read<ListBundle>().conf_list[activePage]} ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Text(''),
                              SizedBox(
                                  height: 300,
                                  width: 300,
                                  child: Image.asset(
                                      'assets/wc_image/${context.read<ListBundle>().label_list[activePage]}.png')),
                                Text(''),
                                Text(''),
                                Text(''),
                                Text(''),
                            ]))
                          : Text(
                              ' 라벨 : 로딩중.... \n 정확도 : 로딩중.... ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                      : Container(),
                ],
              ),
            ),
          ),
        ));
  }
}

AnimatedContainer slider(pictureList, pagePosition, active) {
  double margin = active ? 10 : 20;
  Image s_img = Image.file(File(pictureList[pagePosition].path));
  ImageProvider s_image = s_img.image;

  return AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    decoration: BoxDecoration(image: DecorationImage(image: s_image)),
  );
}

imageAnimation(PageController animation, pictureList, pagePosition) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, widget) {
      return SizedBox(
        width: 200,
        height: 200,
        child: widget,
      );
    },
    child: Container(
      margin: EdgeInsets.all(10),
      child: Image.file(File(pictureList[pagePosition].path),
          width: 50, height: 50),
    ),
  );
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}

void showDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return Container(
          child: CupertinoAlertDialog(
        title: Text("사진 찍는법(예시)\n"),
        content: Column(children: [
          Text("아래와 같이 라벨이 나오도록 \n 찍어주세요.\n"),
          SizedBox(
              height: 400,
              width: 300,
              child: Image.asset('assets/capture_ex.jpg')),
          CupertinoDialogAction(
              child: Text("확인"),
              onPressed: () {
                //Navigator.of(context).pop();
                print(
                    'context.read<ListBundle>().popclose 1 : ${context.read<ListBundle>().popclose}');
                context.read<ListBundle>().popclose = !context
                    .read<ListBundle>()
                    .popclose; // 체크 유무에 따라 mainpage의 gallery_save 값 변경
                print(
                    'context.read<ListBundle>().popclose 2 : ${context.read<ListBundle>().popclose}');

                Navigator.pop(context);
              }),
        ]),
        actions: [],
      ));
    },
  );
}

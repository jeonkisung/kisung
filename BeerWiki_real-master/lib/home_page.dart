import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'camera_page.dart';
import 'gallery_page.dart';
import 'info_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false, // 키보드가 올라와도 배경 이미지가 밀려 올라가지 않도록
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/beer_img_01.jpeg'), // 배경 이미지
                  ),
                ),
                child: Center(
                    child: Column(
                        // 아래로 쭉 세우겠다.
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Padding(
                        // 'Beer Wiki' 텍스트
                        padding: const EdgeInsets.all(30),
                        child: const Text(
                          'Beer Wiki',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        ),
                      ),
                      Padding(
                        // 카메라 버튼
                        padding: const EdgeInsets.all(40),
                        child: ElevatedButton(
                          onPressed: () async {
                            await availableCameras().then(
                              (value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CameraPage(
                                    // 카메라 페이지로 이동
                                    cameras: value,
                                  ),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            minimumSize: const Size(200, 50),
                            maximumSize: const Size(200, 50),
                          ),
                          child: const Text(
                            'Camera',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                      Padding(
                        // Picture 버튼
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Carousel(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            minimumSize: const Size(200, 50),
                            maximumSize: const Size(200, 50),
                          ),
                          child: const Text(
                            'Picture',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                      Padding(
                        // BeerWiki란
                        padding: const EdgeInsets.all(40),
                        child: ElevatedButton(
                          onPressed: () async {
                            await availableCameras().then(
                              (value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InfoPage(),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            minimumSize: const Size(200, 50),
                            maximumSize: const Size(200, 50),
                          ),
                          child: const Text(
                            'Beer Wiki?',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                    ])))));
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'package:flutter/cupertino.dart';


class Carousel extends StatefulWidget {
  const Carousel({
    Key? key,
  }) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;
  int activePage = 0;

  @override
  void initState() {
    super.initState();

    int pic_len = context.read<ListBundle>().pictureList.length;
    if (pic_len <= 0) {
      pic_len = 0;
    } else {
      pic_len = pic_len - 1;
    }
    activePage = pic_len;
    _pageController =
        PageController(viewportFraction: 0.7, initialPage: activePage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
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
            resizeToAvoidBottomInset: false,
            //추가하고 body를 SingleChildScrollView로 감싼다.
            appBar: AppBar(
                title: Text('Picture', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 26)),
                centerTitle: true,
                backgroundColor: Colors.deepOrangeAccent),
            body: SingleChildScrollView(
              child: Center(
                  child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,

                    height: context.read<ListBundle>().label_list.length > 0 ? 500 : 20,
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
                          return slider(context.read<ListBundle>().pictureList,
                              pagePosition, active);
                        }),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: indicators(
                          context.read<ListBundle>().pictureList.length,
                          activePage)),
                  context.read<ListBundle>().label_list.length > 0
                      ? Container(
                          child: Column(children: <Widget>[
                          Text(
                            ' 라벨 : ${context.read<ListBundle>().label_list[activePage]} \n 정확도 : ${context.read<ListBundle>().conf_list[activePage]} ',
                            //' 라벨 : ${label_list[activePage]} \n 정확도 : ${conf_list[activePage]} ',
                            //' is_loading : $is_loading  \n activePage : $activePage \n 라벨 : ${label_list[activePage]} \n 정확도 : ${conf_list[activePage]} ',
                            //'now_Page : $now_Page  active_Page : $activePage',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20),
                          ),
                            Text(''),

                            SizedBox(
                                height: 300,
                                width: 300,
                                child: Image.asset('assets/wc_image/${context.read<ListBundle>().label_list[activePage]}.png')),
                            Text(''),
                            Text(''),
                            Text(''),
                            Text(''),
                        ]))
                      :
                    const Text(
                      '사진이 없습니다.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),

                ],
              )),
            )));
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
      print(pagePosition);

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

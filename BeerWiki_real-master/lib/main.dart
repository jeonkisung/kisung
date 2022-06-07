import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:provider/provider.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return const MaterialApp(
  //     home: HomePage(),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListBundle>(  // 사진, 라벨 등의 리스트를 모든 화며에서 공유하기 위해
      create: (_) => ListBundle(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // 오른쪽 상단의 Debug 라벨 삭제
        title: 'HomePage',
        home: HomePage(),
      ),
    );
  }

}

class ListBundle extends ChangeNotifier {

  List pictureList = [];
  List label_list = [];
  List conf_list = [];
  List desc_list = [];
  bool gallery_save = false; // 찍은 사진을 갤러리에 저장할 것인지의 Flag
  bool popclose = false;
  void add_list(label, conf, desc){
    if(label == 'should_be_changed'){
      //print('add_list if label : $label , conf : $conf , desc : $desc ');
      label_list.add(label);
      conf_list.add(conf);
      desc_list.add(desc);
    }else{
      //print('add_list else label-1 : $label : ${label_list.length -1 }  , conf : $conf , desc : $desc ');
      label_list[label_list.length -1] = label;
      conf_list[conf_list.length -1] = conf;
      desc_list[desc_list.length -1] = desc;
    }
  }
  void add_pic_list(pic) {
    pictureList.add(pic);
  }
  void del_first_pic(){
    pictureList.removeAt(0);
  }
  void del_first_list(){
    label_list.removeAt(0);
    conf_list.removeAt(0);
    desc_list.removeAt(0);
  }
  void change_gallery_save() {
    gallery_save = !gallery_save;
  }

}
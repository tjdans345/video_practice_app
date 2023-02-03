import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_practice_app/component/custom_video_player.dart';

// statefulWidget 은 statelessWidget 과 다르게 context 를 어디서든 가져와서 활용할 수 있다.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(videoFile: video!),
    );
  }

  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width,
      // color 와 decoration 을 같이 사용하면 안된다.
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onLogoTap,
          ),
          // SizedBox 를 사용하는 이유 ?? : 패딩을 사용하면 한번 감싸기 때문에 탭(뎁스)가 하나 더 들어가야 하는데 SizedBox 를 활용해도 좋다.
          const SizedBox(
            height: 30.0,
          ),
          const _AppName()
        ],
      ),
    );
  }

  // 파일 선택 후 파일 객체에 선택한 파일 저장
  void onLogoTap() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video != null) {
      setState(() {
        // 여기서 this 는 statefulWidget 을 가리킨다.
        this.video = video;
      });
    }
  }

  BoxDecoration getBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2A3A7C),
            Color(0xFF00118),
          ]),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap, child: Image.asset("asset/image/logo.png"));
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("VIDEO", style: textStyle),
        Text("PLAYER", style: textStyle.copyWith(fontWeight: FontWeight.w700))
      ],
    );
  }
}

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
// import 'package:video_player/video_player.dart';

// class BackGround extends StatefulWidget {
//   final Widget childwidget;
//   const BackGround(
//       {super.key, required this.childwidget, required Widget child});

//   @override
//   State<BackGround> createState() => _BackGroundState();
// }

// class _BackGroundState extends State<BackGround> {
//   late VideoPlayerController _playerController;
//   late VoidCallback playerListener;

//   void _createVideo() async {
//     if (_playerController == null) {
//       _playerController =
//           VideoPlayerController.asset('asset/videos/onbordingScreen/nature.mp4')
//             ..initialize().then((value) => playerListener);
//       _playerController.setVolume(0.0);
//       _playerController.setLooping(true);
//     }
//     await _playerController.play();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     playerListener = () {
//       setState(() {});
//     };
//   }

//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//     _createVideo();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _playerController.dispose();
//     super.dispose();
//   }

//   @override
//   void deactivate() {
//     // TODO: implement deactivate
//     _playerController.removeListener(playerListener);
//     super.deactivate();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Container(
//       height: size.height,
//       width: size.width,
//       child: SizedBox.expand(
//         child: Stack(
//           children: [
//             Transform.scale(
//               scale: 6.9,
//               child: AspectRatio(
//                 aspectRatio: _playerController.value.aspectRatio,
//                 child: SizedBox(
//                   width: _playerController.value.size?.width ?? 0,
//                   height: _playerController.value.size?.height ?? 0,
//                   child: (_playerController != null)
//                       ? VideoPlayer(
//                           _playerController,
//                         )
//                       : Container(),
//                 ),
//               ),
//             ),
//             widget.childwidget,
//           ],
//         ),
//       ),
//     );
//   }
// }

class BackGround extends StatefulWidget {
  const BackGround({
    super.key,
  });

  @override
  State<BackGround> createState() => _BackGroundState();
}

class _BackGroundState extends State<BackGround> {
  // final VideoPlayerController videoPlayerController =
  //     VideoPlayerController.asset("asset/videos/onbordingScreen/nature.mp4");
  // ChewieController? chewieController;

  // @override
  // void initState() {
  //   chewieController = ChewieController(
  //     videoPlayerController: videoPlayerController,
  //     aspectRatio: 10 / 20,
  //     autoPlay: true,
  //     looping: true,
  //     autoInitialize: true,
  //     showControls: false,
  //   );

  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   videoPlayerController.dispose();
  //   chewieController!.dispose();

  //   super.dispose();
  // }

  late Size _size;
  late double _appbarsize;
  int _noofpages = 3;
  int _currentpage = 0;
  PageController _controller = PageController(initialPage: 0);

  List<Widget> _buildIndicators() {
    List<Widget> wlist = [];
    for (int i = 0; i < _noofpages; i++) {
      wlist.add((i == _currentpage) ? _indicator(true) : _indicator(false));
    }
    return wlist;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(microseconds: 150),
      height: 8.0,
      width: 8.0,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white70,
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
    );
  }

  void _setpagestate(int page) {
    setState(() {
      _currentpage = page;
    });
  }

  void _systemUIConfig() {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _systemUIConfig();
  }

  void _moveToNextPage() {
    _controller.jumpToPage(_currentpage + 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    _appbarsize = MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Expanded(
            //   child: Chewie(controller: chewieController!),
            // ),
            SizedBox.expand(
              child: Container(
                height: _size.height,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: _appbarsize),
                        // color: Colors.blue,
                        child: TextButton(
                          child: const Text(
                            'Skip',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () => {},
                        ),
                      ),
                      Container(
                        height: _size.height / 1.7,
                        // color: Colors.amber,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PageView(
                            controller: _controller,
                            onPageChanged: (value) => _setpagestate(value),
                            physics: ClampingScrollPhysics(),
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.all_inclusive,
                                    size: 95,
                                  ),
                                  SizedBox(
                                    height: _size.height / 2.9,
                                  ),
                                  const Text(
                                    'title',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'stitle',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.ac_unit,
                                    size: 95,
                                  ),
                                  SizedBox(
                                    height: _size.height / 2.9,
                                  ),
                                  const Text(
                                    'title',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'stitle',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.extension,
                                    size: 95,
                                  ),
                                  SizedBox(
                                    height: _size.height / 2.9,
                                  ),
                                  const Text(
                                    'title',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'stitle',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        //color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildIndicators(),
                        ),
                      ),
                      Container(
                        child: Expanded(
                          child: Container(
                            // color: Colors.indigo,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ButtonTheme(
                                  minWidth: 100,
                                  height: 45,
                                  child: (_currentpage != _noofpages - 1)
                                      ? OutlinedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                side: const BorderSide(
                                                    width: 3,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          onPressed: () => _moveToNextPage(),
                                          child: const Text(
                                            'Continue',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      : OutlinedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStatePropertyAll(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                side: const BorderSide(
                                                    width: 3,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          onPressed: () => _moveToNextPage(),
                                          child: const Text(
                                            'Start',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spider_dream/Animations/fadeAnimation.dart';
import 'package:spider_dream/components/background.dart';
import 'package:spider_dream/screens/LoginScreen/loginScreen.dart';
import 'package:video_player/video_player.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _scale2Controller;
  late AnimationController _widthController;
  late AnimationController _positionController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _scale2Animation;
  late Animation<double> _widthAnimation;
  late Animation<double> _positionAnimation;

  bool hideIcon = false;

  final VideoPlayerController videoPlayerController =
      VideoPlayerController.asset("asset/video/onbordingScreen/nature.mp4");
  ChewieController? chewieController;

  // @override
  // void initState() {
  //   chewieController = ChewieController(
  //     videoPlayerController: videoPlayerController,
  //     aspectRatio: 9 / 20,
  //     autoPlay: true,
  //     looping: true,
  //     autoInitialize: true,
  //     showControls: false,
  //   );
  //   _systemUIConfig();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   videoPlayerController.dispose();
  //   chewieController!.dispose();
  //   _controller.dispose();
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void initState() {
    super.initState();
    _systemUIConfig();
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });

    _widthController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _widthAnimation =
        Tween<double>(begin: 80, end: 300).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController.forward();
            }
          });
    ;

    _positionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _positionAnimation =
        Tween<double>(begin: 0, end: 215).animate(_positionController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller.forward();
            }
          });

    _scale2Controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32).animate(_scale2Controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.push(
                  context,
                  PageTransition(
                      child: LogInScreen(), type: PageTransitionType.fade));
            }
          });
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
    return Scaffold(backgroundColor: Color.fromRGBO(3, 9, 23, 1), body: _body()
        // SafeArea(top: true, child:
        );
  }

  Widget _body() {
    return SizedBox.expand(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('asset/images/onbordingScreen/one.png'),
              fit: BoxFit.contain),
        ),
        height: _size.height,
        //  color: Colors.red,
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
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogInScreen()),
                    ),
                  },
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
                            style: TextStyle(color: Colors.white, fontSize: 24),
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
                            style: TextStyle(color: Colors.white, fontSize: 24),
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
                            style: TextStyle(color: Colors.white, fontSize: 24),
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
                                            width: 3, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  onPressed: () => _moveToNextPage(),
                                  child: const Text(
                                    'Continue',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : OutlinedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: const BorderSide(
                                            width: 3, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LogInScreen()),
                                    );
                                  },
                                  child: const Text(
                                    'Start',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FadeAnimation(
                1.6,
                AnimatedBuilder(
                  animation: _scaleController,
                  builder: (context, child) => Transform.scale(
                    scale: _scaleAnimation.value,
                    child: AnimatedBuilder(
                      animation: _widthController,
                      builder: (context, child) => Container(
                        width: _widthAnimation.value,
                        height: 80,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blue.withOpacity(.4),
                        ),
                        child: InkWell(
                          onTap: () {
                            _scaleController.forward();
                          },
                          child: Stack(
                            children: [
                              AnimatedBuilder(
                                animation: _positionAnimation,
                                builder: (context, child) => Positioned(
                                  left: _positionAnimation.value,
                                  child: AnimatedBuilder(
                                    animation: _scale2Controller,
                                    builder: (context, child) =>
                                        Transform.scale(
                                      scale: _scale2Animation.value,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                        ),
                                        child: hideIcon == false
                                            ? const Icon(
                                                Icons.forward,
                                                color: Colors.white,
                                              )
                                            : Container(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

class TaylorSwift extends StatefulWidget {
  @override
  _TaylorSwiftState createState() => _TaylorSwiftState();
}

class _TaylorSwiftState extends State<TaylorSwift> with TickerProviderStateMixin {
  Color _backgroundColor = Color.fromRGBO(236, 226, 209, 1);

  // transform animation
  AnimationController _transformAnimationController;
  Animation<double> transformAnimation;

  // slide animation
  AnimationController _slideAnimationController;
  Animation<double> slideAnimation;

  var padding = 16.0;

  String title = "Animation Example";
  String _image = "assets/guitar.jpg";

  bool isClicked = false;

  String _lyrics = """You're on the phone with your girlfriend She's upset.
She's going off about something that you said
'Cuz she doesn't get your humor like I do... 
I'm in the room
It's a typical Tuesday night
I'm listening to the kind of music she doesn't like
And she'll never know your story like I do'

But she wears short skirts
I wear T-shirts
She's cheer captain
And I'm on the bleachers
Dreaming about the day when you wake up
And find that what you're looking for has been here the whole time

If you could see that I'm the one who understands you
Been here all along so why can't you see
You belong with me
You belong with me

Walk in the streets with you and your worn-out jeans
I can't help thinking this is how it ought to be
Laughing on a park bench, thinking to myself
Hey isn't this easy?

And you've got a smile that could light up this whole town
I haven't seen it in a while since she brought you down
You say your fine
I know you better than that
Hey whatcha doing with a girl like that

She wears high heels
I wear sneakers
She's cheer captain and I'm on the bleachers
Dreaming about the day when you wake up
And find that what you're looking for has been here the whole time

If you could see that I'm the one who understands you
Been here all along so why can't you see
You belong with me

Standing by and waiting at your back door
All this time how could you not know
Baby... 
You belong with me
You belong with me

Oh'
I remember you drivin' to my house in the middle of the night
I'm the one who makes you laugh
When you know you're about to cry
And I know your favorite songs
And you tell me about your dreams
I think I know where you belong
I think I know it's with me... 

Can't you see that I'm the one who understands you
Been here all along
So why can't you see
You belong with me

Standing by and waiting at your back door
All this time
How could you not know
Baby you belong with me
You belong with me

You belong with me
Have you ever thought just maybe
You belong with me
You belong with me?
  """;

  @override
  void initState() {
    // transform animation
    _transformAnimationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
//    ..forward();

    transformAnimation = Tween<double>(begin: 0.0, end: pi / 2).animate(
      CurvedAnimation(
          parent: _transformAnimationController,
          curve: Curves.fastLinearToSlowEaseIn),
    )..addListener(() {
      setState(() {});
    });

    // slide up animation
    _slideAnimationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
//      ..forward();

    slideAnimation = Tween<double>(begin: 0.0, end: 500).animate(
      CurvedAnimation(
          parent: _slideAnimationController,
          curve: Curves.fastLinearToSlowEaseIn),
    )..addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _transformAnimationController?.dispose();
    _slideAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Stack(
        children: <Widget>[
          // top transform page
          Positioned(
            top: -slideAnimation.value / 2,
            left: 0,
            right: 0,
            height: screenHeight,
            child: InkWell(
              onTap: () {
                _onClicked();
              },
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(-transformAnimation.value),
                alignment: FractionalOffset.center,
                child: AnimatedContainer(
                  duration: Duration(seconds: 3),
                  curve: Curves.fastLinearToSlowEaseIn,
                  color: isClicked ? Colors.white : _backgroundColor,
                  child: Stack(
                    children: <Widget>[
                      // text : Taylor Swift
                      Positioned(
                        top: 120.0,
                        left: padding * 5,
                        child: Transform.rotate(
                          angle: 0.1,
                          child: Text(
                            "taylor".toUpperCase(),
                            style: TextStyle(
                              fontSize: 60.0,
                              color: Colors.grey[600].withOpacity(0.50),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 180.0,
                        right: 20.0,
                        child: Transform.rotate(
                          angle: 0.1,
                          child: Text(
                            "Swift".toUpperCase(),
                            style: TextStyle(
                              fontSize: 60.0,
                              color: Colors.grey[600].withOpacity(0.50),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // center image
                      Positioned(
                        right: padding,
                        bottom: 0,
                        child: Image.asset(
                          _image,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // bottom slide page
          Positioned(
            top: screenHeight - slideAnimation.value * 1.17,
            left: 0,
            right: 0,
            height: screenHeight - 98,
            child: Container(
              color: Colors.orange[100],
              child: Container(
                padding: EdgeInsets.only(
                    top: 150.0, left: padding, right: padding
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      // image

                      // lyrics
                      Text(_lyrics,
                        style: TextStyle(

                        ),)
                    ],
                  ),
                ),
              ),
            ),
          ),

          // appbar
          Positioned(
            top: 0,
            left: padding,
            right: padding,
            child: SafeArea(
              top: true,
              left: true,
              right: true,
              child: Container(
                height: 40.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // left
                    Icon(
                      Icons.menu,
                      size: 28.0,
                      color: Colors.black,
                    ),

                    // center text : title
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // spacer
                    Container(
                      width: 28.0,
//                      child: Placeholder(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // bottom text
          Positioned(
            top: screenHeight - 200 - slideAnimation.value / 1.3,
            left: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                _onClicked();
              },
              child: Container(
                color: isClicked ? Colors.orange.withOpacity(0.4) : null,
                height: 130.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: padding),
                      child: Text(
                        "YOU\nBELONG\nWITH ME",
                        style: TextStyle(
                            fontSize: 36.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Image.network(isClicked ? "https://musicmeta-phinf.pstatic.net/album/000/153/153912.jpg?type=r360Fll&v=20190727123614" : ""),
                  ],
                ),
              ),
            ),
          ),

          // arrow icon
          Positioned(
            top: screenHeight - 110 - slideAnimation.value / 1.3,
            left: 175.0,
            child: InkWell(
              onTap: () {
                _onClicked();
              },
              child: Icon(
                isClicked ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 24.0,
                color: Colors.black,
              ),
            ),

          ),
        ],
      ),
    );
  }

  // click event : animation forward & reverse
  void _onClicked() {
    setState(() {
      isClicked = !isClicked;
      if (isClicked) {
        _transformAnimationController.forward();
        _slideAnimationController.forward();
      } else {
        _transformAnimationController.reverse();
        _slideAnimationController.reverse();
      }
    });
  }
}

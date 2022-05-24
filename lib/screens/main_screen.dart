// ignore_for_file: prefer_const_constructors, unused_field, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

import '../constant/constant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: items.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reels App by Abhi"),
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(items.length, (index) {
          return VideoPlayerItem(
            url: items[index]['url'],
          );
        }),
      ),
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String url;
  const VideoPlayerItem({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _videoController;
  bool isShowPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(widget.url)
      ..initialize().then((value) {
        _videoController.play();
        setState(() {
          isShowPlaying = false;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  Widget isPlaying() {
    return _videoController.value.isPlaying && !isShowPlaying
        ? Container()
        : Icon(
            Icons.play_arrow,
            size: 80,
            color: Colors.white.withOpacity(0.5),
          );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _videoController.value.isPlaying
              ? _videoController.pause()
              : _videoController.play();
        });
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            VideoPlayer(_videoController),
            Center(
              child: Container(
                decoration: BoxDecoration(),
                child: isPlaying(),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 20,
              child: Container(
                height: 400,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    CircleAvatar(
                      child: Icon(
                        FontAwesomeIcons.tiktok,
                        color: Colors.pinkAccent,
                      ),
                      radius: 30,
                    ),
                    CircleAvatar(
                      child: Icon(
                        FontAwesomeIcons.share,
                        color: Colors.purple,
                      ),
                      radius: 30,
                    ),
                    CircleAvatar(
                      child: Icon(
                        FontAwesomeIcons.download,
                        color: Colors.green,
                      ),
                      radius: 30,
                    ),
                    CircleAvatar(
                      child: Icon(
                        FontAwesomeIcons.plus,
                        color: Colors.yellow,
                      ),
                      radius: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

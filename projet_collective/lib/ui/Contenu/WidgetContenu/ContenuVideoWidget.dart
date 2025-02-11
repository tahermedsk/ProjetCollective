
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seriouse_game/models/mediaCours.dart';
import 'package:seriouse_game/ui/Contenu/ContenuCoursViewModel.dart';
import 'package:video_player/video_player.dart';

 
class ContenuVideoWidget extends StatelessWidget {

  late MediaCours data;
  late ContenuCoursViewModel fileLoader;
  late VideoPlayerController controller;

  ContenuVideoWidget({super.key});

  @override
  Widget build(BuildContext context) {

    try {
      controller = fileLoader.VideoLoader(data);
    } on Exception catch (e) {
        return (
          MaterialApp(
            home: Text("Video can't be loaded : "+ e.toString() ),
          )
        );
    }
  
    
    
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return VideoPlayerScreen(controller: controller);
      }
      
    );
      
    
   ;
  }
}


class VideoPlayerScreen extends StatefulWidget {

  final VideoPlayerController controller;

  const VideoPlayerScreen({Key? key, required this.controller}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState(controller);
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  Duration videoLength = const Duration();
  Duration videoPosition = const Duration();

  bool errorLoadingVideo = false;
  double volume = 0.5;

  bool isFullscreen = false;
  bool fullscreenWidgetButtons = false;
  bool HasVideoNotStarted = true;

  _VideoPlayerScreenState(VideoPlayerController controller){
    _controller = controller;
  }

  void startTimerWidgetFullscreen() {
    fullscreenWidgetButtons = true;
    Timer(const Duration(seconds: 3), handleTimeoutWidgetFullscreen);
  }

  void handleTimeoutWidgetFullscreen() { 
    fullscreenWidgetButtons = false;
  }

  @override
  void initState() {

    super.initState();

    try {
      _initializeVideoPlayerFuture = _controller.initialize().then((_) => setState(() {
          
            try {
              videoLength = _controller.value.duration;
            } on Exception catch (e) {
              errorLoadingVideo = true;
            }
          }));


      _controller.setLooping(true);

      _controller.addListener(() => setState(() {
            videoPosition = _controller.value.position;
            errorLoadingVideo = _controller.value.hasError;
          }));

    } on Exception catch (e) {
      errorLoadingVideo = true;
    }

  }

  @override
  void dispose() {
    
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(errorLoadingVideo){
      return (
          const Scaffold(
            body: Center(
              child: 
              SizedBox(
                child: Text("Video can't be loaded"),
              )
            )
            
          )
        );
    }else {

      //if (DeviceOrientation.values == DeviceOrientation.landscapeLeft ||
          //DeviceOrientation.values == DeviceOrientation.landscapeRight) {
        //enterFullScreen();
        //isFullscreen = true;
      //} else {
        //exitFullScreen();
        //isFullscreen = false;
      //}


      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        exitFullScreen();
        isFullscreen = false;
        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  
                  children: <Widget>[
        
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () =>
                          _controller.value.isPlaying ? _controller.pause() : _controller.play(),
                        child:
                      
                          FutureBuilder(
                            future: _initializeVideoPlayerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                          
                                return AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                      
                                child: VideoPlayer(_controller),
                                );
                              } else {
                                            
                                return const Center(
                                child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                      ),        
                        
                    
                        Slider(
                            value: videoPosition.inSeconds.toDouble(),
                            min: 0,
                            max: videoLength.inSeconds.toDouble(),
                            thumbColor: const Color.fromARGB(255, 246, 1, 1),
                            activeColor: const Color.fromARGB(255, 246, 1, 1),  
                            onChanged: (_videoPosition) => setState(() {
                                                videoPosition = Duration.zero + Duration(seconds: _videoPosition.toInt());
                                                _controller.seekTo(videoPosition);
                                              
                                              }
                            ),
                        ),
                  Row(
                    children : <Widget>[
                            IconButton(
                              icon: Icon(_controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow),
                              onPressed: () {
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : {_controller.play(), HasVideoNotStarted = false};
                                });
                              },
                            ),
        
                            Icon(animatedVolumeIcon(volume)),
        
                            SizedBox(
                                width: 100,
                                child: Slider(
                                  value: volume,
                                  min: 0,
                                  max: 1,
                                  onChanged: (_volume) => setState(() {
                                    volume = _volume;
                                    _controller.setVolume(_volume);
                                  
                                  }
                                  ),
                                ),
                            ),
        
                            Spacer(),
                            
                            Text(
                              '${convertToMinutesSeconds(videoPosition)} / ${convertToMinutesSeconds(videoLength)}'),
                              const SizedBox(width: 10),
        
                            Spacer(),
        
                            IconButton(
                              onPressed: () {
                                setState(() {
                                    _controller.seekTo(Duration.zero);
                                });
                              }, 
                              icon: const Icon(
                                Icons.restart_alt_rounded,
                              ),
                            ),
        
                            
        
                            IconButton(
                              onPressed: () {
                                  isFullscreen 
                                  ? {isFullscreen = false, exitFullScreen(), SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),enableRotation()}
                                  : {isFullscreen = true, enterFullScreen(), SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]),startTimerWidgetFullscreen()};
                              }, 
                              icon: const Icon(
                                Icons.fullscreen,
                              ),
                            )
                          ],
                      ),
                ],
              
              
              );
            }
            
            );
      }else{
        enterFullScreen();
        isFullscreen = true;
        return (
          Scaffold(
            body: Center(
              child: 
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) { 
                    return Stack(
                            children: <Widget>[
                              SizedBox(
                                height: constraints.maxHeight,
                                width: constraints.maxWidth,
                                child : 
                          
                                  GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => {
                                  //_controller.value.isPlaying ? _controller.pause() : _controller.play(),
                                  fullscreenWidgetButtons ? fullscreenWidgetButtons = false : startTimerWidgetFullscreen(),
                                  },
                                  child:
                              
                                    FutureBuilder(
                                        future: _initializeVideoPlayerFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.done) {
                                                      
                                            return AspectRatio(
                                            aspectRatio: _controller.value.aspectRatio,
                                                  
                                            child: VideoPlayer(_controller),
                                            );
                                          } else {
                                                        
                                            return const Center(
                                            child: CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                      ),                    
                                  ), 
                                                
                             
                              ),
                              Visibility(
                                maintainSize: true, 
                                maintainAnimation: true,
                                maintainState: true,
                                visible: fullscreenWidgetButtons || HasVideoNotStarted,
                                child:

                                  Column(
                                    children: [

                                      Spacer(),

                                      Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: IconButton(
                                                          icon: Icon(_controller.value.isPlaying
                                                              ? Icons.pause
                                                              : Icons.play_arrow),
                                                              color: Colors.white,
                                                              iconSize: 70,

                                                          onPressed: () {
                                                            setState(() {
                                                              _controller.value.isPlaying
                                                                  ? _controller.pause()
                                                                  : {_controller.play(), HasVideoNotStarted = false};
                                                            }
                                                            
                                                            );
                                                            startTimerWidgetFullscreen();
                                                          },
                                                        ),

                                        ),
                                      ),

                                      Spacer(),

                                      Align(
                                        alignment: Alignment.bottomCenter,
                                          child : SizedBox(
                                          width: constraints.maxWidth,
                                          height : 110,
                                          child: 
                                            Column(
                                                children: [
                                                  Slider(
                                                      value: videoPosition.inSeconds.toDouble(),
                                                      min: 0,
                                                      max: videoLength.inSeconds.toDouble(),
                                                      thumbColor: const Color.fromARGB(255, 246, 1, 1),
                                                      activeColor: const Color.fromARGB(255, 246, 1, 1),  
                                                      onChanged: (_videoPosition) => setState(() {
                                                                          videoPosition = Duration.zero + Duration(seconds: _videoPosition.toInt());
                                                                          _controller.seekTo(videoPosition);
                                                                        
                                                                        }
                                                      ),
                                                  ),
                                                  Row(
                                                    
                                                    children : <Widget>[
                                                        IconButton(
                                                          icon: Icon(_controller.value.isPlaying
                                                              ? Icons.pause
                                                              : Icons.play_arrow,
                                                              color: Colors.white,
                                                              size: 20,
                                                              ),
                                                              
                                                          onPressed: () {
                                                            setState(() {
                                                              _controller.value.isPlaying
                                                                  ? _controller.pause()
                                                                  : {_controller.play(), HasVideoNotStarted = false};
                                                            }
                                                            
                                                            );
                                                            startTimerWidgetFullscreen();
                                                          },
                                                        ),
                                                                      
                                                        Icon(animatedVolumeIcon(volume),
                                                              color: Colors.white),
                                                                      
                                                        SizedBox(
                                                            width: 100,
                                                            child: Slider(
                                                              value: volume,
                                                              min: 0,
                                                              max: 1,
                                                              onChanged: (_volume) => setState(() {
                                                                volume = _volume;
                                                                _controller.setVolume(_volume);
                                                              
                                                              }
                                                              ),
                                                            ),
                                                        ),
                                                                      
                                                        Spacer(),
                                                        
                                                        Text(
                                                          '${convertToMinutesSeconds(videoPosition)} / ${convertToMinutesSeconds(videoLength)}',
                                                            style : const TextStyle(
                                                                fontSize: 15.0,
                                                                color: Colors.white,
                                                                 // insert your font size here
                                                              ),
                                                            ),
                                      
                                                        Spacer(),
                                                                      
                                                        IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                                _controller.seekTo(Duration.zero);
                                                            });
                                                          }, 
                                                          icon: const Icon(
                                                            Icons.restart_alt_rounded,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                        ),
                                                                      
                                                        
                                                                      
                                                        IconButton(
                                                          onPressed: () {
                                                              isFullscreen 
                                                              ? {isFullscreen = false, exitFullScreen(), SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),enableRotation()}
                                                              : {isFullscreen = true, enterFullScreen(), SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight])};
                                                          }, 
                                                          icon: const Icon(
                                                            Icons.fullscreen,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                        )
                                                      ],
                                                  ),
                                                ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ), 
                              ), 
                        ]          
                    );        
                }
              )
            )
            
          )
        );
      }
  }}

    
}

String convertToMinutesSeconds(Duration duration) {
  final parsedMinutes = duration.inMinutes < 10
      ? '0${duration.inMinutes}'
      : duration.inMinutes.toString();

  final seconds = duration.inSeconds % 60;

  final parsedSeconds =
      seconds < 10 ? '0${seconds % 60}' : (seconds % 60).toString();
  return '$parsedMinutes:$parsedSeconds';
}

IconData animatedVolumeIcon(double volume) {
  if (volume == 0)
    return Icons.volume_mute;
  else if (volume < 0.5)
    return Icons.volume_down;
  else
    return Icons.volume_up;
}

void enterFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

void exitFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
}

void enableRotation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}
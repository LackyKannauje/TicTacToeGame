import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:learn_provider/const.dart';
import 'package:learn_provider/grid.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  Random random = Random();
  void _handleTap(int row, int col) {
    if (grid[row][col] == "") {
      setState(() {
        final player = AudioPlayer();
        grid[row][col] = isPlayerX ? "X" : "O";
        //sound
        player
            .play(AssetSource('sounds/${isPlayerX ? 'click1' : 'click2'}.mp3'));
        isPlayerX = !isPlayerX;
      });
      _checkWinner();
    }
  }

  void _checkWinner() {
    // check Rows
    for (int i = 0; i < 3; i++) {
      if (grid[i][0] == grid[i][1] &&
          grid[i][1] == grid[i][2] &&
          grid[i][0] != "") {
        _showWinner(grid[i][0]);
        return;
      }
    }
    // check Columns
    for (int i = 0; i < 3; i++) {
      if (grid[0][i] == grid[1][i] &&
          grid[1][i] == grid[2][i] &&
          grid[0][i] != "") {
        _showWinner(grid[0][i]);
        return;
      }
    }
    // check Diagonals
    if ((grid[0][0] == grid[1][1] &&
            grid[1][1] == grid[2][2] &&
            grid[0][0] != "") ||
        (grid[0][2] == grid[1][1] &&
            grid[1][1] == grid[2][0] &&
            grid[0][2] != "")) {
      _showWinner(grid[1][1]);
      return;
    }
    // Check for tie
    bool isTie = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (grid[i][j] == "") {
          isTie = false;
          break;
        }
      }
    }
    if (isTie) {
      _showWinner("Tie");
    }
  }

  void _showWinner(String winner) {
    final winSound = AudioPlayer();

    winSound
        .play(AssetSource('sounds/${winner == "Tie" ? 'lose' : 'win'}.wav'));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: popUpPageColor,
        title: Container(
          height: 260,
          child: Column(
            children: [
              Image.asset(
                winner == "Tie" ? 'assets/tie.gif' : 'assets/win.gif',
                height: 200,
                width: 200,
              ),
              winner != "Tie"
                  ? Text(
                      '🎊Congratulations🎊',
                      style: TextStyle(
                          fontFamily: gameFontFamily,
                          color: textContentColor,
                          fontSize: 19),
                    )
                  : Text(
                      '🥲 You Both Happy? 😗',
                      style: TextStyle(
                          fontFamily: gameFontFamily,
                          color: textContentColor,
                          fontSize: 19),
                    ),
              Text(
                winner == "Tie" ? "😐 It's a Tie 😑" : "🌟 $winner wins 🌟",
                style: TextStyle(
                    fontFamily: gameFontFamily,
                    color: textContentColor,
                    fontSize: 22),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              winSound.pause();
              final btn = AudioPlayer();
              btn.play(AssetSource('sounds/btn2.wav'));
              Navigator.of(context).pop();
              _resetGame();
            },
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  gradient: customGradient,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Play Again',
                  style: TextStyle(
                      fontFamily: gameFontFamily,
                      color: textContentColor,
                      fontSize: 17),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReset() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: popUpPageColor,
        title: Container(
          height: 260,
          child: Column(
            children: [
              Image.asset(
                'assets/reset.gif',
                height: 220,
                width: 250,
              ),
              Text(
                "Do You Want to Reset?",
                style: TextStyle(
                    fontFamily: gameFontFamily,
                    color: textContentColor,
                    fontSize: 19),
              )
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  final btn = AudioPlayer();
                  btn.play(AssetSource('sounds/btn2.wav'));
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: customGradient,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'No',
                    style: TextStyle(
                        fontFamily: gameFontFamily,
                        color: textContentColor,
                        fontSize: 17),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              TextButton(
                onPressed: () {
                  final btn = AudioPlayer();
                  btn.play(AssetSource('sounds/btn2.wav'));
                  Navigator.of(context).pop();
                  _resetGame();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: customGradient,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                        fontFamily: gameFontFamily,
                        color: textContentColor,
                        fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _resetGame() {
    setState(() {
      grid = [
        ["", "", ""],
        ["", "", ""],
        ["", "", ""]
      ];
      isPlayerX = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isAppstarted) {
      final bgSound = AudioPlayer();
      bgSound.play(AssetSource('sounds/bg${random.nextInt(3) + 1}.mp3'),
          volume: 0.17);
      bgSound.setReleaseMode(ReleaseMode.loop);
      isAppstarted = false;
    }
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: bgGradient,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Container(
              height: 80,
              width: 300,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: customGradient,
                // border: Border.all(width: 5, color: Colors.grey.shade900),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Player's Turn : ",
                      style: TextStyle(
                        fontFamily: gameFontFamily,
                        color: textContentColor,
                        fontSize: 30,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${isPlayerX ? 'X' : 'O'}',
                      style: TextStyle(
                        // fontFamily: gameFontFamily,
                        color: isPlayerX ? firstPlayerColor : secondPlayerColor,
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(5),
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                int row = index ~/ 3;
                int col = index % 3;
                return GestureDetector(
                  onTap: () {
                    _handleTap(row, col);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(3),
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      gradient: customGradient,
                      // border: Border.all(width: 5, color: Colors.grey.shade900),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        grid[row][col],
                        style: TextStyle(
                          color: grid[row][col] == "X"
                              ? firstPlayerColor
                              : secondPlayerColor,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                final btn = AudioPlayer();
                btn.play(AssetSource('sounds/btn2.wav'));
                _showReset();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: customGradient,
                ),
                child: Text(
                  'Reset Game',
                  style: TextStyle(
                      fontFamily: gameFontFamily,
                      color: textContentColor,
                      fontSize: 30),
                ),
              ),
            ),
            SizedBox(height: 50),
            Text(
              "@LK_Creation",
              style: TextStyle(fontSize: 5, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

class TicTacToe {
  List<List<String>> board;
  String currentPlayer;

  TicTacToe()
      : board = List.generate(3, (_) => List.generate(3, (_) => ' ')),
        currentPlayer = 'X';



  void printBoard() {
    for (var row in board) {
      print(row.join(' | '));
      print('---------');
    }
  }

  bool makeMove(int position) {
    if (position < 1 || position > 9) {
      print('Invalid input. Please enter a number between 1 and 9.');
      return false;
    }

    int row = (position - 1) ~/ 3;
    int col = (position - 1) % 3;

    if (board[row][col] == ' ') {
      board[row][col] = currentPlayer;
      return true;
    } else {
      print('Cell already occupied. Please choose an empty cell.');
      return false;
    }
  }

  bool checkWin() {
    // Check rows and columns
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == currentPlayer &&
          board[i][1] == currentPlayer &&
          board[i][2] == currentPlayer) {
        return true; // Check row
      }
      if (board[0][i] == currentPlayer &&
          board[1][i] == currentPlayer &&
          board[2][i] == currentPlayer) {
        return true; // Check column
      }
    }

    // Check diagonals
    if (board[0][0] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][2] == currentPlayer) {
      return true; // Check diagonal from top-left to bottom-right
    }
    if (board[0][2] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][0] == currentPlayer) {
      return true; // Check diagonal from top-right to bottom-left
    }

    return false;
  }

  bool isBoardFull() {
    for (var row in board) {
      if (row.contains(' ')) {
        return false;
      }
    }
    return true;
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  void playGame() {
    print('Welcome to Tic-Tac-Toe!');
    printBoard();

    while (true) {
      print('Player $currentPlayer, enter your move (1-9):');
      int? position = int.tryParse(stdin.readLineSync() ?? '');

      if (position != null) {
        if (makeMove(position)) {
          printBoard();
          if (checkWin()) {
            print('Player $currentPlayer wins!');
            break;
          } else if (isBoardFull()) {
            print('It\'s a draw!');
            break;
          } else {
            switchPlayer();
          }
        }
      } else {
        print('Invalid input. Please enter a number.');
      }
    }

    print('Do you want to play again? (yes/no)');
    String playAgain = (stdin.readLineSync() ?? '').toLowerCase();

    if (playAgain == 'yes') {
      resetGame();
      playGame();
    } else {
      print('Thanks for playing!');
    }
  }

  void resetGame() {
    board = List.generate(3, (_) => List.generate(3, (_) => ' '));
    currentPlayer = 'X';
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.playGame();
}

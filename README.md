# Tic-Tac-Toe

### Getting Started

#### What is it?
A simple, elegant, Tic-Tac-Toe game to be played via a command line, optimised for use in a
UNIX terminal.

#### Who is it for?
Anyone who enjoys playing Tic-Tac-Toe! The game supports either one or two players, depending on
the selected game mode.

#### Ace! How can I play it it?
Good question. Just follow these simple steps:
1. Clone [this](https://github.com/michaelbjacobson/tic-tac-toe.git) GitHub repo onto your machine
2. Using your terminal, navigate to the lib directory inside the main Tic-Tac-Toe
directory eg. `$ cd ~/desktop/tic-tac-toe/lib`
3. Once inside Tic-Tac-Toe's lib directory simply enter `$ ruby game.rb`
4. Enjoy the game! If, for whatever reason, you'd like to finish the game early, simply type 'ctrl + c'
into your terminal.

#### Great, is there anything else I should know?
Yes. First off, the computer player is _unbeatable_. I'm not kidding, it literally can't be beaten. If you
play against the computer you'll either draw or lose. If you don't believe me, give it a try. I dare you.

Secondly, while you're playing, you'll see two grids. The grid on the left is your game board and starts out empty,
the grid on the right is a key. Check on your game board which tile you'd like to use and then consult the handy
key for the tile's number.
#

### My Process
I began by dissecting and refactoring the original codebase. The very first step of this was tweaking the original
script to make it fully compliant with the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide). Next I
trimmed out a lot of redundant code in several methods. Finally I extracted several classes from the one existing
'God' class, in adherance with the single responsiblity principle.

Then I tackled the specific issues highlighted in the problem brief. I decided to begin by ensuring that the computer
player would be unbeatable. I did some research and decided that using the minimax algorithm would be the optimal
approach. After some more research and some spiking I successfully implemented the minimax algorithm into the Computer
class. After this I added additional functions into the Board class to allow the Computer to assess it to be able to
choose its next move. Next I created a Player superclass, from which both the Human and Computer classes inherited.
I made use of duck-typing and allowed the Human and Computer classes to both respond to the #make_move method, as 
called by the Game class. Finally I built the Game class up to wrap the other classes and act as an engine for games.

The final issue that was pointed out in the brief was how poor and inelegant the gameplay was. I was very conscious
that I didn't want to implement redundant functionality that the client may not want or need. However, I felt that
the task of improving the user experience allowed a certain amount of creativity on my part. I am particularly pleased
with the solution of having two parallel grids - one representing the active game board and another the numbered key
for the board tiles. This allows players to see a clear and uncluttered picture of the game while also having a useful
reference if they're uncertain about which number corresponds to which tile. I was also pleased with my decision to 
highlight the winning row in red when the game is won. 

Next I implemented the additional functionality requested in the original brief, that is the ability for the user to
select the game mode, their symbol, and which player should make the first move.

It goes without saying that I test-drove the development of the original refactor, the class extraction and also the
implementation of new functionality. I used the Rspec testing framework with the Simplecov gem to monitor test
coverage. Some tests written early on were later made redundant and hence removed from the test suite. In total I am
making use of 46 tests, which give total coverage of 96%. I had difficulties unit testing recursion and so opted
to implement a more feature-oriented test structure for some recursion-dependent functionality. I would love to learn
more about effective testing of recursion!

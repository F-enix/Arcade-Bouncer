# ARCADE BOUNCER
#### Video Demo: https://www.youtube.com/watch?v=NEC-XE4FENQ
#### Description: 
    In this project I developed a 2D game coded in language "lua" using the "LOVE" framework named Arcade Bouncer.
    Inspired by the famus Arkanoid game, it's a simple version with three different levels of increasing difficulty.
    Although the graphics aren't so great because every object was drawn as single or combination of geometric shapes, from the other hand the functionality and responsiveness are quite good.

##### Gameplay:
    The Player have to brake all the bricks in every level in order to win. While controling a platform(paddle) that moves only left or right, he must prevent the ball to fall below the horizontal axis of the platform, having three spare ball (credits).

##### States:
    The game is based on five states which are : Menu, Serve, Play, Victory and Game Over , where they will be explained further more. game.lua organise, initialize and split the code in smaller parts to be readable easier.
    - On application load the Menu (menu.render) screen is rendered with welcoming messages and instructions for the Player, also he is prompt to provide a name (it's ok if he doesn't "NoName" will be registered), while the folder and file of our database is initialized with name "scores.lst".
    - Subsequently we load the Serve state that renders our current level (the bricks, the background, the paddle and the ball). The Player is allowed to move left and right and by pressing "space" he serves the ball into play.
    - In Play state the ball bounce on every object when it hits a brick either it changes his color (that means decrease its durability) either it disappears (durability decreased to zero), in case the Player clears all the bricks he proceed in the next level in Serve state. Now if the Player fails to bounce the ball with the paddle credits that are rendered on top right of the screen are decreased by 1 and returns in Serve state. At last if the Player loses all of his credits he redirected on the Game Over state.
    - In case the Player clears all (three) levels of the game the Victory state render a congratulation screen with his score and introduction to continue.
    - Lastly the Game Over screen renders the names and scores stored in of our database, initialize any variable we need to start from the beginning, while giving the user the option to wipe the records with "delete" key or return again on the Menu state

##### Classes, lvls and Libraries:
    Using the class.lua library I created Classes for every object in the game: Ball, Paddle, Walls, Bricks and Lives(although Lives isn't an actual object ingame it worked out easier than using it as a table).
    In libraries i made the collision function that handles the way the ball bounce off the objects (except the walls that happens inside the Ball:update method), strangely it came out that overlapping two objects creates more bugs than i expected in LOVE framework so there is a lot of room for improvement in this sector.
    At last levels.lua is pretty simple table that uses other lvl#.lua files to load a specific level with our designed structure.

##### Resources:
    I don't own the copyright to the following as they were free to use:
    - The sound effects taken from https://sfxr.me/ .
    - The images used in the background downloaded from google and were selected so it reminds an old fashioned retro-looking game.
    - Used the libraries "class.lua", "push.lua" and font.ttf from CS50 game development, for class creating objects, changing our screen resolution into a virtual resolution of our choice and retro-looking fonts respectively.
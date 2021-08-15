import turtle
from tetris import Tetris

game = Tetris()

game.window.title('Tetris in Python by @mellomaths')
game.window.bgcolor('gray')
game.window.setup(width=500, height=600)

game.pen.draw_game_square(250, 400)

game.start()


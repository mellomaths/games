import turtle
import random

from components.drawer import Drawer
from components.piece import Piece

class Tetris:
    
    def __init__(self):
        self.window = turtle.Screen()
        self.pen = Drawer()
        self.title = turtle.Turtle()
        self.title.color('white')
        
        self.title_font = ('Arial', 24, 'bold')
        self.title_align = 'center'

        self.title.penup()
        self.title.hideturtle()
        self.title.goto(0, 225)
        self.title.write('TETRIS', align=self.title_align, font=self.title_font)

        self.pieces_prop = [
            { 'format': 'L', 'color': 'green' },
            { 'format': 'T', 'color': 'red' },
            { 'format': 'I', 'color': 'blue' },
            { 'format': 'O', 'color': 'yellow' },
            { 'format': 'S', 'color': 'purple' },
            { 'format': 'l', 'color': 'purple' },
            { 'format': 'i', 'color': 'purple' },
        ]



    def start(self):
        while True:
            self.window.update()

            next_shape = random.choice(self.pieces_prop)
            # next_shape = self.pieces_prop[0]
            piece = Piece(next_shape['format'], next_shape['color'], -75, 180)
            piece.draw()
            piece.fall()

            # self.window.mainloop()
            # enquanto a peca nao tocar no chao
            # esperar


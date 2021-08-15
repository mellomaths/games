import turtle

class Drawer(turtle.Turtle):

    def __init__(self):
        turtle.Turtle.__init__(self)
        self.hideturtle()
        self.penup()
        self.speed(15)


    def setup_position(self, x, y):
        self.up()
        self.goto(-200, -200)

    def draw_game_square(self, x_square, y_square):
        self.setup_position(-200, -200)
        self.down()
        self.pensize(5)

        self.forward(x_square)
        
        self.left(90) 
        self.forward(y_square)

        self.left(90)
        self.forward(x_square)

        self.left(90)
        self.forward(y_square)
        self.pensize(0)

        
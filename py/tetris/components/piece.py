import turtle

class Piece(turtle.Turtle):

    # Possible shapes:
    # L, T, I, O, S, l, i

    def __init__(self, shape, color, initial_x, initial_y):
        turtle.Turtle.__init__(self)

        self.color('black')
        self.fillcolor(color)

        self.initial_x = initial_x
        self.initial_y = initial_y

        self.hideturtle()
        self.penup()
        self.goto(initial_x, initial_y)
        self.speed(10)

        self.pensize(3)

        self.shape_format = shape
        self.number_of_blocks = self.get_number_of_blocks(shape)

        self.block_size = 10

    def get_number_of_blocks(self, shape):
        if shape == 'L':
            return 4
        if shape == 'T':
            return 4
        if shape == 'I':
            return 3
        if shape == 'O':
            return 4
        if shape == 'S':
            return 4
        if shape == 'l':
            return 3
        if shape == 'i':
            return 2

    def fall(self):
        pass

    def reset_position(self):
        self.goto(self.initial_x, self.initial_y)

    def draw(self):
        self.reset_position()
        self.begin_fill()
        self.pendown()
        if self.shape_format == 'L':
            self.draw_L_shape()

        self.end_fill()

    def draw_L_shape(self):
        self.forward(self.block_size)
        self.right(90)
        self.forward(self.block_size + self.block_size)
        self.right(90)
        self.forward(self.block_size)
        self.right(90)
        self.forward(self.block_size)
        self.right(90)
        self.forward(self.block_size)
        self.left(180)
        self.forward(self.block_size)
        self.right(90)
        self.forward(self.block_size)
        self.left(90)
        self.forward(self.block_size + self.block_size)
        self.left(90)
        self.forward(self.block_size)
        self.left(90)
        self.forward(self.block_size)
        self.left(90)
        self.forward(self.block_size)
        self.left(180)
        self.forward(self.block_size)
        self.left(90)
        self.forward(self.block_size)

    

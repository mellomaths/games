import turtle

class PongObject(turtle.Turtle):
    
    def __init__(self, initial_x, initial_y):
        turtle.Turtle.__init__(self)
        self.speed(0)
        self.shape('square')
        self.color('white')
        
        self.penup()
        self.goto(initial_x, initial_y)


        
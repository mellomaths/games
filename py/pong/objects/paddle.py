from models.object import PongObject

class Paddle(PongObject):
    
    def __init__(self, initial_x, initial_y):
        PongObject.__init__(self, initial_x, initial_y)
        self.shapesize(stretch_wid=5, stretch_len=1)
        self.initial_x = initial_x

    def y_max(self):
        return self.ycor() + 50

    def y_min(self):
        return self.ycor() - 50
    
    def move_up(self):
        y = self.ycor()
        y += 20
        self.sety(y)

    def move_down(self):
        y = self.ycor()
        y -= 20
        self.sety(y)

        
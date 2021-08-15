from models.object import PongObject

class Ball(PongObject):
    
    def __init__(self, dx, dy, vertical_screen_limit):
        PongObject.__init__(self, 0, 0)
        self.dx = dx
        self.dy = dy
        self.vertical_screen_limit = vertical_screen_limit


    def move(self):
        self.setx(self.xcor() + self.dx)
        self.sety(self.ycor() + self.dy)

        bounce_to = self.get_where_to_bounce()
        if bounce_to is not None:
            self.bounce(bounce_to)

    def bounce(self, y):
        self.sety(y)
        self.change_vertical_direction()


    def get_where_to_bounce(self):
        bounce_y = None

        if self.ycor() > self.vertical_screen_limit:
            bounce_y = self.vertical_screen_limit
        
        if self.ycor() < -self.vertical_screen_limit:
            bounce_y = -self.vertical_screen_limit

        return bounce_y

    def reset_position(self):
        self.goto(0, 0)


    def change_vertical_direction(self):
        self.dy *= -1

    def change_horizontal_direction(self):
        self.dx *= -1


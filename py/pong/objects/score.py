import turtle

class Score(turtle.Turtle):
    
    def __init__(self, goal_limit):
        turtle.Turtle.__init__(self)

        self.player1 = 0
        self.player2 = 0
        self.goal_limit = goal_limit

        self.align = 'center'
        self.font = ('Courier', 24, 'normal')

        self.color('white')
        self.penup()
        self.hideturtle()
        self.goto(0, 260)
        self.write(f'Player A {self.player1} X {self.player2} Player B', align=self.align, font=self.font)

    def is_game_over(self):
        return self.player1 >= self.goal_limit or self.player2 >= self.goal_limit

    def update_screen(self):
        self.clear()
        self.write(f'Player A {self.player1} X {self.player2} Player B', align=self.align, font=self.font)

        
import turtle

from objects.ball import Ball
from objects.paddle import Paddle
from objects.score import Score

class PongGame:

    def __init__(self, goal_limit):
        self.window = turtle.Screen()
        self.paddle_initial_x = 350
        self.paddle_collision_x = self.paddle_initial_x - 20
        self.goal_screen_limit = self.paddle_initial_x + 20

        self.right_paddle = Paddle(self.paddle_initial_x, 0)
        self.left_paddle = Paddle(-self.paddle_initial_x, 0)

        self.ball = Ball(0.21, 0.21, vertical_screen_limit=290)

        self.goal_limit = goal_limit
        self.score = Score(goal_limit)


    def start(self):
        while True:
            self.window.update()

            self.ball.move()

            # Player 1 goal
            if self.ball.xcor() > self.goal_screen_limit:
                self.score.player1 += 1
                self.score.update_screen()
                game_over = self.score.is_game_over()
                if game_over:
                    print('Player 1 vitorioso')
                    return

            # Player 2 goal
            if self.ball.xcor() < -self.goal_screen_limit:
                self.score.player2 += 1
                self.score.update_screen()
                game_over = self.score.is_game_over()
                if game_over:
                    print('Player 2 vitorioso')
                    return

            # On any goal
            if self.ball.xcor() > self.goal_screen_limit or self.ball.xcor() < -self.goal_screen_limit:
                self.ball.reset_position()
                self.ball.change_horizontal_direction()

            # Paddle and ball collision
            has_right_paddle_collision = self.check_ball_collision(self.right_paddle, 'right')
            has_left_paddle_collision = self.check_ball_collision(self.left_paddle, 'left')
            if has_right_paddle_collision:
                self.ball.setx(self.paddle_collision_x)
                self.ball.change_horizontal_direction()

            if has_left_paddle_collision:
                self.ball.setx(-self.paddle_collision_x)
                self.ball.change_horizontal_direction()



    def config_keybindings(self):
        self.window.onkeypress(self.left_paddle.move_up, 'w')
        self.window.onkeypress(self.left_paddle.move_down, 's')

        self.window.onkeypress(self.right_paddle.move_up, 'Up')
        self.window.onkeypress(self.right_paddle.move_down, 'Down')


    def check_ball_collision(self, paddle, paddle_type):
        if paddle_type == 'right':
            return self.ball.xcor() > self.paddle_collision_x and paddle.y_min() < self.ball.ycor() < paddle.y_max()

        if paddle_type == 'left':
            return self.ball.xcor() < -self.paddle_collision_x and paddle.y_min() < self.ball.ycor() < paddle.y_max()


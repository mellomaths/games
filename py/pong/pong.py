import turtle

from models.game import PongGame

# the game will end after 3 goals
pong = PongGame(goal_limit=3)

pong.window.title('Pong Game by @mellomaths')
pong.window.bgcolor('black')
pong.window.setup(width=800, height=600)
pong.window.tracer(0)
pong.window.listen()


pong.config_keybindings()

pong.start()


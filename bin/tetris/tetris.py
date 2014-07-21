import pyglet
from pyglet.window import key

import random
import sys

__module_name__ = 'tetris'
__module_description__ = 'a clone of tetris written in python'
__version__ = (0, 1, 0)

# these are the dimensions from the gameboy version
BOARD_WIDTH = 14
BOARD_HEIGHT = 20

BLOCK_EMPTY = 0
BLOCK_FULL = 1
BLOCK_ACTIVE = 2
BLOCK_IMG_FILE = '/home/savoca/bin/tetris/img/block.png'

block = pyglet.image.load(BLOCK_IMG_FILE)
block_sprite = pyglet.sprite.Sprite(block)

BLOCK_WIDTH = block.width
BLOCK_HEIGHT = block.height

window = pyglet.window.Window(width=BOARD_WIDTH*BLOCK_WIDTH,
                              height=BOARD_HEIGHT*BLOCK_HEIGHT)

class Shape(object):
    _shapes = [
        [[0, 1, 0, 0], [0, 1, 0, 0], [0, 1, 0, 0], [0, 1, 0, 0]],
        [[0, 0, 0, 0], [0, 1, 1, 0], [0, 1, 1, 0], [0, 0, 0, 0]],
        [[0, 0, 0, 0], [0, 1, 0, 0], [1, 1, 1, 0], [0, 0, 0, 0]],
        [[0, 0, 0, 0], [0, 0, 1, 0], [0, 0, 1, 0], [0, 1, 1, 0]],
        [[0, 0, 0, 0], [0, 0, 1, 0], [0, 1, 1, 0], [0, 1, 0, 0]],
        [[0, 0, 0, 0], [0, 1, 0, 0], [0, 1, 1, 0], [0, 0, 1, 0]],
    ]
    
    def __init__(self, x=0, y=0):
        self.shape = random.choice(self._shapes)
        self.shape = self.copy_shape()
        
        for i in range(random.choice(range(4))):
            self.rotate()
        
        self.x = x
        self.y = y
    
    def copy_shape(self):
        new_shape = []
        for row in self.shape:
            new_shape.append(row[:])
        return new_shape
    
    def clone(self):
        cloned = Shape()
        cloned.shape = self.copy_shape()
        cloned.x = self.x
        cloned.y = self.y
        return cloned
    
    def rotate(self):
        new_shape = self.copy_shape()
        for j in range(0, 4):
            for i in range(0, 4):
                new_shape[i][j] = self.shape[4 - j - 1][i]
        self.shape = new_shape

    @property
    def left_edge(self):
        for x in range(0, 4):
            for y in range(0, 4):
                if self.shape[y][x] == BLOCK_FULL:
                    return x

    @property
    def right_edge(self):
        for x in range(3, -1, -1):
            for y in range(0, 4):
                if self.shape[y][x] == BLOCK_FULL:
                    return x

    @property
    def bottom_edge(self):
        for y in range(3, -1, -1):
            for x in range(0, 4):
                if self.shape[y][x] == BLOCK_FULL:
                    return y


class Board(pyglet.event.EventDispatcher):
    active_shape = None
    pending_shape = None
    board = None
    
    def __init__(self, width, height, block):
        self.width, self.height = width, height
        self.block = block
        self.calculated_height = self.height * BLOCK_HEIGHT
        self.calculated_width = self.width * BLOCK_WIDTH
        self.reset()
    
    def reset(self):
        self.board = []
        for row in range(self.height):
            self.board.append([0] * self.width)
        
        self.pending_shape = Shape()
        self.add_shape()

    def add_shape(self):
        self.active_shape = self.pending_shape.clone()
        self.active_shape.x = self.width // 2 - self.active_shape.left_edge
        self.active_shape.y = -1
        self.pending_shape = Shape()
        
        if self.is_collision():
            self.reset()
            self.dispatch_event('on_game_over')
    
    def rotate_shape(self):
        rotated_shape = self.active_shape.clone()
        rotated_shape.rotate()

        if rotated_shape.left_edge + rotated_shape.x < 0:
            rotated_shape.x = -rotated_shape.left_edge
        elif rotated_shape.right_edge + rotated_shape.x >= self.width:
            rotated_shape.x = self.width - rotated_shape.right_edge - 1
        
        if rotated_shape.bottom_edge + rotated_shape.y > self.height:
            return False
        
        if not self.is_collision(rotated_shape):
            self.active_shape = rotated_shape
    
    def move_left(self):
        self.active_shape.x -= 1
        if self.out_of_bounds() or self.is_collision():
            self.active_shape.x += 1
            return False
        return True
    
    def move_right(self):
        self.active_shape.x += 1
        if self.out_of_bounds() or self.is_collision():
            self.active_shape.x -= 1
            return False
        return True
    
    def move_down(self):
        self.active_shape.y += 1
        
        if self.check_bottom() or self.is_collision():
            self.active_shape.y -= 1
            self.shape_to_board()
            self.add_shape()
            return False
        return True
    
    def out_of_bounds(self, shape=None):
        shape = shape or self.active_shape
        if shape.x + shape.left_edge < 0:
            return True
        elif shape.x + shape.right_edge >= self.width:
            return True
        return False
    
    def check_bottom(self, shape=None):
        shape = shape or self.active_shape
        if shape.y + shape.bottom_edge >= self.height:
            return True
        return False
    
    def is_collision(self, shape=None):
        shape = shape or self.active_shape
        for y in range(4):
            for x in range(4):
                if y + shape.y < 0:
                    continue
                if shape.shape[y][x] and self.board[y + shape.y][x + shape.x]:
                    return True
        return False
    
    def test_for_line(self):
        for y in range(self.height - 1, -1, -1):
            counter = 0
            for x in range(self.width):
                if self.board[y][x] == BLOCK_FULL:
                    counter += 1
            if counter == self.width:
                self.process_line(y)
                return True
        return False
    
    def process_line(self, y_to_remove):
        for y in range(y_to_remove - 1, -1, -1):
            for x in range(self.width):
                self.board[y + 1][x] = self.board[y][x]
    
    def shape_to_board(self):
        # transpose onto board
        # while test for line, process & increase score
        for y in range(4):
            for x in range(4):
                dx = x + self.active_shape.x
                dy = y + self.active_shape.y
                if self.active_shape.shape[y][x] == BLOCK_FULL:
                    self.board[dy][dx] = BLOCK_FULL
        
        lines_found = 0
        while self.test_for_line():
            lines_found += 1
        
        if lines_found:
            self.dispatch_event('on_lines', lines_found)

    def move_piece(self, motion_state):
        if motion_state == key.MOTION_LEFT:
            self.move_left()
        elif motion_state == key.MOTION_RIGHT:
            self.move_right()
        elif motion_state == key.MOTION_UP:
            self.rotate_shape()
        elif motion_state == key.MOTION_DOWN:
            self.move_down()
    
    def draw_game_board(self):
        for y, row in enumerate(board.board):
            for x, col in enumerate(row):
                if col == BLOCK_FULL or col == BLOCK_ACTIVE:
                    self.draw_block(x, y)
        
        for y in range(4):
            for x in range(4):
                dx = x + self.active_shape.x
                dy = y + self.active_shape.y
                if self.active_shape.shape[y][x] == BLOCK_FULL:
                    self.draw_block(dx, dy)
    
    def draw_block(self, x, y):
        y += 1 # since calculated_height does not account for 0-based index
        self.block.blit(x * BLOCK_WIDTH, self.calculated_height - y * BLOCK_HEIGHT)


Board.register_event_type('on_lines')
Board.register_event_type('on_game_over')


class Game(object):
    ticks = 0
    factor = 4
    frame_rate = 60.0
    
    is_paused = False
    
    def __init__(self, window_ref, board, starting_level=1):
        self.window_ref = window_ref
        self.board = board
        self.starting_level = int(starting_level)
        self.register_callbacks()
        self.reset()
    
    def register_callbacks(self):
        self.board.push_handlers(self)
    
    def reset(self):
        self.level = self.starting_level
        self.lines = 0
        self.score = 0
    
    def should_update(self):
        if self.is_paused:
            return False
        
        self.ticks += 1
        if self.ticks >= (self.frame_rate - (self.level * self.factor)):
            self.ticks = 0
            return True
        return False
    
    def draw_handler(self):
        self.window_ref.clear()
        self.board.draw_game_board()
    
    def keyboard_handler(self, motion):
        self.board.move_piece(motion)
    
    def on_lines(self, num_lines):
        self.score += (num_lines * self.level)
        self.lines += num_lines
        if self.lines / 10 > self.level:
            self.level = self.lines / 10
    
    def on_game_over(self):
        self.reset()
    
    def cycle(self):
        if self.should_update():
            self.board.move_down()
            self.update_caption()
    
    def toggle_pause(self):
        self.is_paused = not self.is_paused
    
    def update_caption(self):
        self.window_ref.set_caption('Tetris - %s lines [%s]' % (self.lines, self.score))


board = Board(BOARD_WIDTH, BOARD_HEIGHT, block)

if len(sys.argv) > 1:
    starting_level = int(sys.argv[1])
else:
    starting_level = 1

game = Game(window, board, starting_level)

@window.event
def on_draw():
    game.draw_handler()

@window.event
def on_text_motion(motion):
    game.keyboard_handler(motion)

@window.event
def on_key_press(key_pressed, mod):
    if key_pressed == key.P:
        game.toggle_pause()

def update(dt):
    game.cycle()

pyglet.clock.schedule_interval(update, 1 / game.frame_rate)
pyglet.app.run()

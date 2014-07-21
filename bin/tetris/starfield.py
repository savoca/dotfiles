#!/usr/bin/python

import pyglet
from pyglet.window import key

import math
import random

__module_name__ = 'starfield'
__module_description__ = 'a starfield written in python'
__version__ = (0, 1, 0)

window = pyglet.window.Window(width=800, height=600)


class Star(object):
    def __init__(self, origin, width, height):
        self.x = random.randint(1, width) - origin[0] or 1
        self.y = random.randint(1, height) - origin[1] or 1
        self.z = self.max_depth = max(width, height)
        
        self.origin = origin
        xcoeff = self.x > 0 and 1 or -1
        ycoeff = self.y > 0 and 1 or -1
        
        if abs(self.x) > abs(self.y):
            self.dx = 1.0
            self.dy = abs(float(self.y) / self.x)
        else:
            self.dx = abs(float(self.x) / self.y)
            self.dy = 1.0
        
        self.dx *= xcoeff
        self.dy *= ycoeff
        
        self.dz = -1
        
        self.ddx = .1 * self.dx
        self.ddy = .1 * self.dy
        
        self.width = 2
    
    def move(self):
        self.x += self.dx
        self.y += self.dy
        self.z += self.dz
        
        self.dx += self.ddx
        self.dy += self.ddy
        
        self.width = 2 + ((self.max_depth - self.z) * .1)
    
    @property
    def coordinates(self):
        return self.x + self.origin[0], self.y + self.origin[1]
    
    def draw(self):
        calc_x, calc_y = map(int, self.coordinates)
        w = int(self.width)
        return ('v2i', (
            calc_x, calc_y,
            calc_x + w, calc_y,
            calc_x + w, calc_y + w,
            calc_x, calc_y + w)
        )
    
    def gl_color(self, r, g, b):
        return ('c3B', (r, g, b) * 4)


class StarField(object):
    frame_rate = 40.0
    draw_3d = False
    is_paused = False
    
    num_stars = 100
    
    def __init__(self, window_ref):
        self.window_ref = window_ref
        
        self.width = self.window_ref.width
        self.height = self.window_ref.height
        self.center = (self.width/2, self.height/2)
        
        self.stars = set()
        self.update_stars()
    
    def update_stars(self):
        dead_stars = set()
        for star in self.stars:
            if not self.is_star_onscreen(star):
                dead_stars.add(star)

        self.stars -= dead_stars
        while len(self.stars) < self.num_stars:
            self.stars.add(Star(self.center, self.width, self.height))
    
    def is_star_onscreen(self, star):
        coords = star.coordinates
        if coords[0] < 0 or coords[0] > self.window_ref.width or \
           coords[1] < 0 or coords[1] > self.window_ref.height:
            return False
        return True
    
    def should_update(self):
        return not self.is_paused
    
    def draw_handler(self):
        self.window_ref.clear()
        batch = pyglet.graphics.Batch()
        for star in self.stars:
            gl_data = star.draw()
            if self.draw_3d:            
                batch.add_indexed(4, pyglet.gl.GL_TRIANGLES, None, 
                    [0, 1, 2, 0, 2, 3],
                    gl_data,
                    star.gl_color(0, 0, 255)
                )
                offset = (float(star.z) / star.max_depth) * 50 # 1 -> 0
                star.x += offset 
                gl_data = star.draw()
                star.x -= offset
                batch.add_indexed(4, pyglet.gl.GL_TRIANGLES, None, 
                    [0, 1, 2, 0, 2, 3],
                    gl_data,
                    star.gl_color(255, 0, 0)
                )
            else:
                batch.add_indexed(4, pyglet.gl.GL_TRIANGLES, None, 
                    [0, 1, 2, 0, 2, 3],
                    gl_data
                )
            
        batch.draw()
    
    def move_stars(self):
        for star in self.stars:
            star.move()
    
    def cycle(self):
        if self.should_update():
            self.move_stars()
            self.update_stars()

starfield = StarField(window)
starfield.draw_3d = True

@window.event
def on_draw():
    starfield.draw_handler()

@window.event
def on_key_press(key_pressed, mod):
    if key_pressed == key.P:
        starfield.is_paused = not starfield.is_paused
    elif key_pressed == key.EQUAL:
        starfield.num_stars += 50
    elif key_pressed == key.MINUS:
        starfield.num_stars -= 50
    elif key_pressed == key.T:
        starfield.draw_3d = not starfield.draw_3d

def update(dt):
    starfield.cycle()

pyglet.clock.schedule_interval(update, 1 / starfield.frame_rate)
pyglet.app.run()

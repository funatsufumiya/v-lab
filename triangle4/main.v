module main

import gg
import time
import math
import sokol.sgl
// import os.asset

const win_width = 600
const win_height = 300

struct App {
mut:
	gg    &gg.Context = unsafe { nil }
	// image int // gg.Image
	start time.Time
}

fn main() {
	mut app := &App{}
	app.gg = gg.new_context(
		bg_color:      gg.white
		width:         win_width
		height:        win_height
		create_window: true
		window_title:  'Triangle2'
		frame_fn:      frame
		user_data:     app
	)
	app.start = time.now()
	// logo_path := asset.get_path('../assets', 'logo.png')
	// app.image = app.gg.create_image(logo_path)!.id
	app.gg.run()
}

fn frame(app &App) {
	app.gg.begin()
	app.draw()
	app.gg.end()
}

fn (app &App) draw() {
	g := app.gg
	t := f32((time.now() - app.start).milliseconds()) / 1000
	z1 := math.sinf(t) * 10.0
	z2 := math.sinf(t + 3) * 10.0
	z3 := math.sinf(t + 6) * 10.0

	g.draw_rect_filled(10, 10, 100, 40, gg.blue)
	g.draw_rect_empty(110, 150, 80, 40, gg.black)

	w := f32(win_width)
	h := f32(win_height)

	// sgl.load_pipeline(g.pipeline.alpha)

	sgl.begin_triangles()
	sgl.c3f(1.0, 0.0, 0.0)  // red
	sgl.v3f(10, 10, z1)  // top
	sgl.v3f(10, h*g.scale - 10, z2) // bottom left
	sgl.v3f(w*g.scale - 10, h*g.scale -10, z3)  // bottom right
	sgl.end()

	g.draw_rect_filled(30, 30, 100, 30, gg.green)
}
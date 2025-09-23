module main

import gg
import sokol.sgl
// import os.asset

const win_width = 600
const win_height = 300

struct App {
mut:
	gg    &gg.Context = unsafe { nil }
	// image int // gg.Image
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
	app.gg.draw_rect_filled(10, 10, 100, 30, gg.blue)
	app.gg.draw_rect_empty(110, 150, 80, 40, gg.black)

	w := f32(win_width)
	h := f32(win_height)

	sgl.begin_triangles()
	sgl.c3f(1.0, 0.0, 0.0)  // red
	sgl.v3f(10, 10, 0.0)  // top
	sgl.v3f(10, h*2 - 10, 0.0) // bottom left
	sgl.v3f(w*2 - 10, h*2 -10, 0.0)  // bottom right
	sgl.end()

	app.gg.draw_rect_filled(30, 30, 100, 30, gg.green)
}
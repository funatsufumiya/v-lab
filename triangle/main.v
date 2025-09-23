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
		window_title:  'Triangle'
		frame_fn:      frame
		init_fn:       init
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
	sgl.defaults()
	sgl.matrix_mode_projection()
	sgl.perspective(sgl.rad(45.0), f32(win_width) / win_height, 0.1, 100.0)
	sgl.matrix_mode_modelview()
	sgl.translate(0.0, 0.0, -5.0)
	sgl.begin_triangles()
	sgl.c3f(1.0, 0.0, 0.0)
	sgl.v3f(0.0, 1.0, 0.0)
	sgl.v3f(-1.0, -1.0, 0.0)
	sgl.v3f(1.0, -1.0, 0.0)
	sgl.end()
}

fn init(mut app App) {
	sgl_desc := sgl.Desc{
		max_vertices: 50 * 65536
	}
	sgl.setup(&sgl_desc)
}

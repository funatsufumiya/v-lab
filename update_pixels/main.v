import gg
import math

const win_width = 640
const win_height = 480

struct App {
mut:
	gg     &gg.Context = unsafe { nil }
	image  int
	width  int = 320
	height int = 240
	buffer []u8
}

fn main() {
	mut app := &App{}

	app.buffer = []u8{len: app.width * app.height * 4} // RGBA buffer

	app.gg = gg.new_context(
		bg_color:      gg.black
		width:         win_width
		height:        win_height
		create_window: true
		window_title:  'Pixel Test'
		frame_fn:      frame
		init_fn:       init
		user_data:     app
	)

	app.gg.run()
}

fn init(mut app App) {
	app.image = app.gg.new_streaming_image(app.width, app.height, 4, gg.StreamingImageConfig{
		pixel_format: .rgba8
	})
}

fn frame(mut app App) {
	app.gg.begin()
	app.update_pixels()
	app.gg.draw_image_by_id(0, 0, app.width, app.height, app.image)
	app.gg.end()
}

fn (mut app App) update_pixels() {
	frame := app.gg.frame
	for y in 0..app.height {
		for x in 0..app.width {
			idx := (y * app.width + x) * 4
			// Generate some colorful pattern based on position and frame
			r := u8((math.sin(f64(frame + x) * 0.01) + 1) * 127.5)
			g := u8((math.cos(f64(frame + y) * 0.01) + 1) * 127.5)
			b := u8((math.sin(f64(frame + x + y) * 0.01) + 1) * 127.5)
			a := u8(255)
			app.buffer[idx] = r
			app.buffer[idx + 1] = g
			app.buffer[idx + 2] = b
			app.buffer[idx + 3] = a
		}
	}
	app.gg.update_pixel_data(app.image, app.buffer.data)
}
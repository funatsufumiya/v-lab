// module main2

import os
import gg
import math
import gui

@[heap]
pub struct Window {
pub mut:
	ctx   &gg.Context = unsafe { 0 }
	image gg.Image
}

struct App {
pub mut:
    clicks int
}

pub fn (mut window Window) init() {
	logo_path := os.join_path(@VEXEROOT, 'examples/assets/logo.png')
	window.image = window.ctx.create_image(logo_path) or { panic(err) }
}

pub fn (mut window Window) draw(_ voidptr) {
	window.ctx.begin()

	myconfig := gg.DrawImageConfig{
		img:      &window.image
		img_id:   window.image.id
		img_rect: gg.Rect{
			x:      400 - window.image.width / 2
			y:      300 - window.image.height / 2
			width:  window.image.width
			height: window.image.height
		}
		rotation: f32(window.ctx.frame)
		// effect: .alpha <-- this can be omitted completely as it is alpha by default.
	}
	window.ctx.draw_image_with_config(gg.DrawImageConfig{ ...myconfig, flip_x: true })

	// Red
	window.ctx.draw_image_with_config(gg.DrawImageConfig{
		...myconfig
		img_rect: gg.Rect{
			...myconfig.img_rect
			x: myconfig.img_rect.x + f32(math.sin(f32(window.ctx.frame) / 10.0) * 60)
			y: myconfig.img_rect.y + f32(math.cos(f32(window.ctx.frame) / 10.0) * 60)
		}
		color:    gg.Color{255, 0, 0, 255}
		effect:   .add
	})

	// Green
	window.ctx.draw_image_with_config(gg.DrawImageConfig{
		...myconfig
		img_rect: gg.Rect{
			...myconfig.img_rect
			x: myconfig.img_rect.x + f32(math.sin(f32(window.ctx.frame) / 10.0) * 80)
			y: myconfig.img_rect.y + f32(math.cos(f32(window.ctx.frame) / 10.0) * 80)
		}
		color:    gg.Color{0, 255, 0, 255}
		effect:   .add
	})

	// Blue
	window.ctx.draw_image_with_config(gg.DrawImageConfig{
		...myconfig
		img_rect: gg.Rect{
			...myconfig.img_rect
			x: myconfig.img_rect.x + f32(math.sin(f32(window.ctx.frame) / 10.0) * 100)
			y: myconfig.img_rect.y + f32(math.cos(f32(window.ctx.frame) / 10.0) * 100)
		}
		color:    gg.Color{0, 0, 255, 255}
		effect:   .add
	})

	// More examples
	window.ctx.draw_image_with_config(gg.DrawImageConfig{
		...myconfig
		img_rect: gg.Rect{
			...myconfig.img_rect
			x: 50
			y: 0
		}
		color:    gg.Color{255, 0, 0, 255}
		effect:   .add
	})

	window.ctx.draw_image_with_config(gg.DrawImageConfig{
		...myconfig
		img_rect: gg.Rect{
			...myconfig.img_rect
			x: 50
			y: 50
		}
		color:    gg.Color{0, 255, 0, 255}
		effect:   .add
	})

	window.ctx.draw_image_with_config(gg.DrawImageConfig{
		...myconfig
		img_rect: gg.Rect{
			...myconfig.img_rect
			x: 50
			y: 100
		}
		color:    gg.Color{0, 0, 255, 255}
		effect:   .add
	})

	window.ctx.end()
}

// The view generator set in update_view() is called on
// every user event (mouse move, click, resize, etc.).
fn main_view(window &gui.Window) gui.View {
    w, h := window.window_size()
    app := window.state[App]()
    return gui.column(
        width: w
        height: h
        h_align: .center
        v_align: .middle
        sizing: gui.fixed_fixed
        content: [
            gui.text(text: 'Welcome to GUI'),
            gui.button(
                content: [gui.text(text: '${app.clicks} Clicks')]
                on_click: fn (_ &gui.ButtonCfg, mut e gui.Event, mut w gui.Window) {
                    mut app := w.state[App]()
                    app.clicks += 1
                }
            ),
        ]
    )
}

fn main() {
	mut window := &Window{}

	window.ctx = gg.new_context(
		window_title: 'Additive colors & image rotation'
		width:        800
		height:       600
		user_data:    window
		bg_color:     gg.gray
		// FNs
		init_fn:  window.init
		frame_fn: window.draw
	)

	mut window2 := gui.window(
        state: &App{}
        width: 300
        height: 300
        on_init: fn (mut w gui.Window) {
            // Call update_view() anywhere in your
            // business logic to change views.
            w.update_view(main_view)
        }
    )

    spawn window2.run()

	// window.gui_window.modify_ui(window.ctx)

	// spawn window.gui_window.run()

	window.ctx.run()
}

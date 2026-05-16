-- window rules
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize", no_blur = true })
hl.window_rule({ match = { class = "^()$", title = "^()$" }, no_blur = true })

-- special workspaces
hl.window_rule({ match = { class = "^([Ss]potify)$" }, workspace = "special:Spotify" })
hl.window_rule({ match = { class = "^(org.gnome.Calculator)$" }, workspace = "special:Calculator" })
hl.window_rule({ match = { class = "^(steam)$" }, workspace = "special:Steam" })

-- preferences
hl.window_rule({ match = { class = "^(kitty)$" }, tile = true })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, float = true })

hl.window_rule({
	name = "special-workspaces",
	match = { class = "^(org.gnome.Calculator|[Ss]potify|steam)$" },
	persistent_size = true,
	float = true,
	rounding = 10,
	dim_around = true,
})

hl.window_rule({
	name = "louarch",
	match = { class = "^(_louapp_)$" },
	float = true,
	rounding = 10,
	dim_around = true,
	center = true,
})

-- layer rules
hl.layer_rule({ match = { namespace = "waybar" }, blur = false })

hl.layer_rule({
	name = "blur-background",
	match = {
		namespace = "^(swaync-control-center|wofi|logout_dialog|rofi)$",
		class = "^(swaync-control-center|wofi|logout_dialog|rofi)$",
	},
	blur = true,
	dim_around = true,
	animation = "on",
})

hl.layer_rule({
	name = "border-removal",
	match = { class = "^(hyprshot|selection)$" },
	no_anim = true,
})

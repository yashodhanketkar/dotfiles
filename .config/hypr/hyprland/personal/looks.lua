-- handle monitors configuration
hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@120",
	scale = 1,
	supports_hdr = false,
	transform = 0,
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@144",
	position = "1920x0",
	scale = 1,
	supports_hdr = false,
})

-- binding workspaces to monitors
for _, i in pairs({
	{ name = "1", monitor = "eDP-1" },
	{ name = "2", monitor = "HDMI-A-1" },
	{ name = "3", monitor = "HDMI-A-1" },
	{ name = "10", monitor = "eDP-1" },
}) do
	hl.workspace_rule({
		workspace = i.name,
		monitor = i.monitor,
	})
end

-- hl.workspace_rule({
-- 	workspace = "r[1-10]",
-- 	gaps_in = 2,
-- 	gaps_out = 5,
-- 	border_size = 2,
-- 	animation = "true",
-- 	layout = "dwindle",
-- })

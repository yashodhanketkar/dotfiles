-- Animations
hl.curve("smoothSpring", { type = "spring", mass = 1, stiffness = 200, dampening = 29 })

-- stylua: ignore start
hl.animation({ leaf = "border", enabled = true, speed = 4.0, spring = "smoothSpring" })
hl.animation({ leaf = "windows", enabled = true, speed = 3.5, spring = "smoothSpring" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.2, spring = "smoothSpring", style = "popin", style_arg = 90 })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, spring = "smoothSpring", style = "popin", style_arg = 95 })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2.0, spring = "smoothSpring" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2.0, spring = "smoothSpring" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.0, spring = "smoothSpring", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3.0, spring = "smoothSpring", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3.0, spring = "smoothSpring", style = "slide" })
-- stylua: ignore end

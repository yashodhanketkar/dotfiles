Dotfiles
========

Personal linux configuration files

Table of Contents
-----------------

-	[Applications](#applications)
-	[Directory structure](#directory-structure)
-	[Scripts](#scripts)
	-	[Independent](#scripts)
	-	[Dependent](#scripts)
-	[License](#license)

Applications
------------

Includes current config files

-	git, bash, zsh, p10k theme, and profile config
-	custom scripts
-	docker (home media server)
-	i3wm & ecosystem (i3status, polybar, rofi)
-	hyprland & ecosystem (hypridle, hyprlock, hyprpaper, hyprsunset, waybar, wofi)
-	swaync
-	tmux
-	wezterm
-	wallust
-	wlogout
-	custom services

Scripts
-------

### Independent

#### activate-pointer

I3-wm script to turn off mouse acceleration and set-up touchpad.

#### tmux-sessionizer

Launch/attach tmux with as session name based on project/directory.

### Dependent

#### hypr/scripts/hyprscripts.sh

```sh
# read weather information from cached json file
get_weather(){}

# get battery status and percentage
get_battery(){}

# get music information (excludes firefox)
get_music(){}

# get system information
sys_info(){}

# open clipboard
clipboard(){}

# get special workspaces
get_special(){}

```

#### waybar/scripts/bluetooth.sh

```sh

# toggle bluetooth power
toggle_power(){}

# toggle bluetooth discoverable
toggle_discoverable(){}
```

#### waybar/scripts/kbdbacklight.sh

```sh

# get current keyboard backlight brightness
get(){}

# toggle keyboard backlight brightness
set(){}
```

#### waybar/scripts/soundclick.sh

```sh
# toggle default sink mute status
# sink is muted ? pause the player
#               : play command
```

#### swaync/scripts/swaync.sh

```sh
# toggle default sink mute
toggle_mute_status(){}

# get default sink mute status
get_mute_status(){}

# toggle wifi on/off
toggle_wifi_status(){}

# get wifi status
get_wifi_status(){}
```

License
-------

[GNU General Public License V3.0](./LICENSE)

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
-	hyprland & ecosystem (hypridle, hyprlock, hyprpaper, waybar, wofi)
-	swaync
-	tmux
-	wezterm
-	wallust
-	wlogout
-	custom services

Directory structure
-------------------

```
home/username/
│
├── .local/
│   └── bin/
│       ├── activate-pointer
│       ├── switch-audio-device
│       ├── tmux-sessionizer
│       └── wallswitcher
│
├──── .config/
│     ├── colorsPallete/
│     │   └── colors.css
│     ├── hypr/
│     │   ├── scripts/
│     │   │   └── hyprscripts.sh
│     │   ├── confs/
│     │   │   ├── colors.conf
│     │   │   ├── inputs.conf
│     │   │   ├── keybinds.conf
│     │   │   ├── looks.conf
│     │   │   ├── personal.conf
│     │   │   └── rules.conf
│     │   ├── hypridle.conf
│     │   ├── hyprland.conf
│     │   ├── hyprlock.conf
│     │   └── hyprpaper.conf
│     ├── i3/
│     │   ├── config
│     │   └── i3status.config
│     ├── polybar/
│     │   └── config.ini
│     ├── rofi/
│     │   └── config.rasi
│     ├── swaync/
│     │   ├── config.json
│     │   ├── configSchema.json
│     │   └── style.css
│     ├── systemd/
│     │   └── user/
│     │       ├── service-weather.service
│     │       └── service-weather.timer
│     ├── tmux/
│     │   └── tmux.conf
│     ├── wallust/
│     │   ├── scripts/
│     │   │   ├── waybar
│     │   │   ├── waybarClock
│     │   │   └── wofi
│     │   └── style.css
│     ├── waybar/
│     │   ├── scripts/
│     │   │   ├── kbdbacklight.sh
│     │   │   └── powermenu.sh
│     │   ├── config.jsonc
│     │   └── style.css
│     ├── wezterm/
│     │   ├── lua 
│     │   │   └── ui.lua
│     │   └── config.rasi
│     ├── wlogout/
│     │   ├── icons/ 
│     │   ├── layout 
│     │   └── style.css
│     └── wofi/
│         ├── config
│         └── style.css
│
├──── Server/
│     └── config
│         └── docker-compose.yml
│
├── .bashrc
├── .gitconfig
├── .profile
├── .p10k.zsh
├── .xbindkeysrc
└── .zshrc
```

Scripts
-------

### Independent

#### activate-pointer

I3-wm script to turn off mouse acceleration and set-up touchpad.

#### browser

Open a browser with a given URL, saved bookmarks or search with search engine. Currently saved browser is firefox, search engine is duckduckgo.

#### switch-audio-device

Switch audio sinks between headphones, speakers, bluetooth, HDMI audio, and many more outputs sequentially.

#### tmux-sessionizer

Launch/attach tmux with as session name based on project/directory.

#### wallswitcher

Switch wallpapers and run wallust. Apply generated styles to respective programs.

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

License
-------

[GNU General Public License V3.0](./LICENSE)

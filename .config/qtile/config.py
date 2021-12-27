# ███╗░░░███╗░█████╗░██████╗░████████╗██╗░░░██╗
# ████╗░████║██╔══██╗██╔══██╗╚══██╔══╝╚██╗░██╔╝
# ██╔████╔██║███████║██████╔╝░░░██║░░░░╚████╔╝░
# ██║╚██╔╝██║██╔══██║██╔══██╗░░░██║░░░░░╚██╔╝░░
# ██║░╚═╝░██║██║░░██║██║░░██║░░░██║░░░░░░██║░░░
# ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░
#
# qtile config

# IMPORTS
import os
import re
import subprocess
from typing import List  # noqa: F401
from libqtile import qtile, bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.widget.battery import Battery, BatteryState
from libqtile.widget.volume import Volume

#Dracula color theme
theme = dict(background = "#282a36",
		 current = "#44475a",
		 selection = "#44475a",
		 foreground = "#f8f8f2",
		 comment = "#6272a4",
		 cyan = "#8be9fd",
		 green = "#50fa7b",
		 orange = "#ffb86c",
		 pink = "#ff79c6",
		 purple = "#bd93f9",
		 red = "#ff5555",
		 yellow = "#f1fa8c")

mod = "mod4"				# Sets mod key to SUPER
home = os.path.expanduser('~') # Allow using 'home +' to expand ~
myTerm = "alacritty"
myBrowser = "vivaldi-stable"
myFilemgr = "pcmanfm"
myEditor = "gedit"
myAppLauncher = "rofi -show drun -theme '~/.config/rofi/config.rasi'"
screenshot = "scrot -e 'mv $f ~/Pictures/Screenshot 2>/dev/null'"

# Keybindings
keys = [
	### Essentials
    Key([mod], "Return",
        lazy.spawn(myTerm),
        desc="Launches My Terminal"
        ),
    Key([mod], "b",
        lazy.spawn(myBrowser),
        desc="Launches My Web Browser"
        ),
    Key([mod], "e",
        lazy.spawn(myFilemgr),
        desc="Launches My File Manager"
        ),
    Key([mod], "a",
        lazy.spawn(myEditor),
        desc="Launches Text Editor"
        ),
    #Work in progress/files upload when complete
    Key([mod], "Escape",
        lazy.spawn([home + '/.config/rofi/powermenu.sh'])
        ),
    Key([mod, "shift"], "r",
        lazy.restart(),
        desc="Restart Qtile"
        ),
    Key([mod, "shift"], "c",
        lazy.window.kill(),
        desc="Kill focused window"
        ),
    Key([mod], "space",
        lazy.next_layout(),
        desc="Toggle between layouts"
        ),
    Key([mod], "d",
        lazy.spawn(myAppLauncher),
        desc="Application Launcher"
        ),
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"
        ),
    Key([mod, "shift"], "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"
        ),
    Key([mod, "shift"], "j",
        lazy.layout.shuffle_up(),
        desc="Move window up"
        ),
    Key([mod, "shift"], "k",
    	lazy.layout.shuffle_down(),
    	desc="Move window down"
    	),
    Key([mod], "r",
    	lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"
        ),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h",
    	lazy.layout.shrink(),
        desc="Shrink window"
        ),
    Key([mod, "control"], "l",
    	lazy.layout.grow(),
        desc="Grow window"
        ),
    Key([mod], "n",
    	lazy.layout.normalize(),
    	desc="Reset all window sizes"
    	),
    Key([mod], "m",
        lazy.layout.maximize(),
        desc='toggle window between minimum and maximum sizes'
        ),
    Key([mod], "f",
        lazy.window.toggle_fullscreen(),
        desc='toggle fullscreen'
        ),
    # Function keys
    # Screen Brightness
    Key([], 'XF86MonBrightnessUp',
    	lazy.spawn('xbacklight -inc 10')
    	),
    Key([], 'XF86MonBrightnessDown',
    	lazy.spawn('xbacklight -dec 10')
    	),
    # Audio/Volume
    Key([], 'XF86AudioMute',
    	lazy.spawn('amixer set Master 1+ toggle')
    	),
    Key([], 'XF86AudioRaiseVolume',
    	lazy.spawn('amixer set Master 2%+ unmute')
    	),
    Key([], 'XF86AudioLowerVolume',
    	lazy.spawn('amixer set Master 2%- unmute')
    	),
    Key([mod], 'XF86AudioRaiseVolume',
    	lazy.spawn('amixer set Master 10%+ unmute')
    	),
    Key([mod], 'XF86AudioLowerVolume',
    	lazy.spawn('amixer set Master 10%- unmute')
    	),
    #Screenshots
    Key([], 'Print',
    	lazy.spawn(screenshot)
    	),
    #Unset Keys
#    Key([], 'XF86AudioMedia',
#        lazy.spawn(),
#        desc='Gear logo fn + F12'
#        ),
#    Key([], 'XF86AudioPrev',
#        lazy.spawn(),
#        desc='Previous Track fn + F4'
#        ),
#    Key([], 'XF86AudioNext',
#        lazy.spawn(),
#        desc='Next Track fn + F6'
#        ),
#    Key([], 'XF86AudioPlay',
#        lazy.spawn(),
#        desc='Play|Pause fn + F5'
#        ),
]

# Battery Icon & % | Replaces widget.Battery
class MyBattery(Battery):
	def build_string(self, status):
		if status.state == BatteryState.DISCHARGING:
			if status.percent >= 1:
				char = ''
			elif status.percent > 0.90:
				char = ''
			elif status.percent > 0.80:
				char = ''
			elif status.percent > 0.70:
				char = ''
			elif status.percent > 0.60:
				char = ''
			elif status.percent > 0.50:
				char = ''
			elif status.percent > 0.40:
				char = ''
			elif status.percent > 0.30:
				char = ''
			elif status.percent > 0.20:
				char = ''
			else:
				char = ''
		elif status.percent >= 1 or status.state == BatteryState.FULL:
			char = ''
		elif status.state == BatteryState.CHARGING:
			if status.percent > 0.90:
				char = ''
			elif status.percent > 0.80:
				char = ''
			elif status.percent > 0.70:
				char = ''
			elif status.percent > 0.60:
				char = ''
			elif status.percent > 0.50:
				char = ''
			elif status.percent > 0.40:
				char = ''
			elif status.percent > 0.30:
				char = ''
			elif status.percent > 0.20:
				char = ''
			else:
				char = ''
		else: #status.state == BatteryState.EMPTY or \
				#(status.state == BatteryState.UNKNOWN and status.percent == 0):
			char = ''
		return self.format.format(char=char, percent=status.percent)
	
	def restore(self):
		self.format = '{char} {percent:2.0%}'
		self.timer_setup()

battery = MyBattery(
	format = '{char} {percent:2.0%}',
    foreground = theme["background"],
    background = theme["cyan"],
    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('xfce4-power-manager-settings')},
)

# Remove portions of windows name
def parse_func(text):
	for string in [" - Vivaldi", " - gedit"]:
		text = text.replace(string, "")
	return text

# Audio Volume/still needs work | Sets icon for widget.Volume
class MyVolume(Volume):
    def _update_drawer(self):
        if self.volume <= 0:
            self.text = '婢'
        elif self.volume < 30:
            self.text = '奄'
        elif self.volume < 80:
            self.text = '奔'
        else: # self.volume >=80:
            self.text = '墳'
        
    def restore(self):
        self.format = '{img_name}'
        self.timer_setup()
        
volume = MyVolume(
    foreground = theme["background"],
    background = theme["purple"],
)

# Groups using Names istead of numbers
groups = [Group(""),
		  Group("爵"),
          Group(""),
          Group(""),
          Group(""),
          Group("", layout='treetab'),
          Group("", layout='floating')]
          
# See https://docs.qtile.org/en/stable/manual/config/groups.html
# allow [S]mod4+1 through [S]mod4+0 to bind to groups; if you bind your groups by hand in your config, you don't need to do this.
from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder("mod4")

# Default layout theme settings
layout_theme = {"border_width": 2,
                "margin": 4,
                "border_focus": theme["purple"],
                "border_normal": theme["background"],
                }

#Used layouts
layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(),
	layout.Floating(**layout_theme),
	layout.TreeTab(
		font = "Hack",
		fontsize = 20,
		border_width = 2,
		sections = [''],
		bg_color = theme["background"],
		active_bg = theme["current"],
		active_fg = theme["purple"],
		inactive_bg = theme["background"],
		inactive_fg = theme["foreground"],
		urgent_bg = theme["background"],
		urgent_fg = theme["red"],
		panel_width = 185,
		),
]

# Widget default settings
widget_defaults = dict(
    font = 'mononoki Nerd Font Mono',
    fontsize = 20,
    padding = 2,
    background = theme["background"],
)
extension_defaults = widget_defaults.copy()

#Setup main bar
screens = [
    Screen(
        top=bar.Bar(
            [
				widget.CurrentLayoutIcon(
					custom_icon_paths = [(home + "/.config/qtile/icons")],
					scale = 0.8,
					),
				widget.GroupBox(
                    active = theme["green"],
                    background = theme["background"],
                    block_highlight_text_color = theme["purple"],
                    fontsize = 32,
                    highlight_color = theme["current"],
                    highlight_method = "block",
                    inactive = theme["foreground"],
                    ),
                widget.Prompt(
                	prompt = 'Run: ',
                	padding = 5,
                	foreground = theme["purple"],
                	),
                widget.WindowName(
                	format = '{name}',
                	foreground = theme["foreground"],
                	parse_text = parse_func,
                	),
                widget.TextBox(
                	text = '',
                	foreground = theme["comment"],
                	padding = 0,
                	fontsize = 28,
                	),
                widget.Systray(
                	icon_size = 22,
                	padding = 2,
                	foreground = theme["background"],
                	background = theme["comment"],
                	),
                widget.TextBox(
                	text = '',
                	foreground = theme["red"],
                	background = theme["comment"],
                	padding = 0,
                	fontsize = 28,
                	),
				widget.CheckUpdates(
                    update_interval = 300,
                    distro = "Arch_checkupdates",
                    display_format = " {updates} Updates",
                    no_update_string = " Updated",
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e sudo paru -Syu')},
                    foreground = theme["background"],
                    colour_no_updates = theme["background"],
                    colour_have_updates = theme["background"],
                    background = theme["red"],
                    ),
                widget.TextBox(
                	text = '',
                	foreground = theme["green"],
                	background = theme["red"],
                	padding = 0,
                	fontsize = 28,
                	),
                widget.Net(
                	interface = "wlp170s0",
                	format = '直{total}',
                	foreground = theme["background"],
                	background = theme["green"],
                	mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('nm-connection-editor')},
                	),
                widget.TextBox(
                	text = '',
                	foreground = theme["orange"],
                	background = theme["green"],
                	padding = 0,
                	fontsize = 28,
                	),
                widget.CPU(
                	background = theme["orange"],
                	foreground = theme["background"],
                	fmt = '{}',
                	format = '{freq_current}GHz ',
                	),
              	widget.ThermalSensor(
                    threshold = 70,
                    foreground_alert = theme["red"],
                    foreground = theme["background"],
                    background = theme["orange"],
                    fmt = '{}',
                    ),
                widget.TextBox(
                	text = '',
                	foreground = theme["pink"],
                	background = theme["orange"],
                	padding = 0,
                	fontsize = 28,
                	),
              	widget.Memory(
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e btop')},
                    foreground = theme["background"],
                    background = theme["pink"],
                    fmt = '{}',
                    measure_mem = 'G',
                    format = '{MemUsed:.1f}{mm}/{MemTotal:.0f}{mm}',
                    update_interval = '1',
                    ),
                widget.DF(
                	background = theme["pink"],
                	foreground = theme["background"],
                	warn_color = theme["foreground"],
                	format = ' {uf}{m}|{r:.0f}',
                	partition = '/',
                	visible_on_warn = False,
                	),
                widget.TextBox(
                	text = '',
                	foreground = theme["purple"],
                	background = theme["pink"],
                	padding = 0,
                	fontsize = 28,
                	),
                volume,
              	widget.Volume(
                    foreground = theme["background"],
                    background = theme["purple"],
                    ),
				widget.TextBox(
                	text = '',
                	foreground = theme["foreground"],
                	background = theme["purple"],
                	padding = 0,
                	fontsize = 28,
                	),
                widget.Clock(
                	format=' %b %d %I:%M%p',
                	foreground = theme["background"],
                	background = theme["foreground"],
                	mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('vivaldi-stable https://calendar.google.com')},
                	),
               	widget.TextBox(
                	text = '',
                	foreground = theme["cyan"],
                	background = theme["foreground"],
                	padding = 0,
                	fontsize = 28,
                	),
                battery,
            ],
            24,
        ),
    ),
]

# Allows dragging floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = True
cursor_warp = False

# Set floating for certain apps
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
	Match(wm_class='confirm'),
	Match(wm_class='dialog'),
    Match(wm_class='download'),
    Match(wm_class='error'),
    Match(wm_class='file_progress'),
    Match(wm_class='notification'),
    Match(wm_class='nm-connection-editor'),
    Match(wm_class='xfce4-power-manager-settings'),
    Match(wm_class='bitwarden'),
    Match(wm_class='blueman-manager'),
    Match(wm_class='Conky'),
    Match(wm_class='kdeconnect-app'),
    Match(wm_class='VirtualBox Machine'),
    Match(wm_class='lxappearance'),
    Match(wm_class='qt5ct'),
    Match(wm_class='xarchiver'),
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# Allows auto-minimize when losing focus for apps that need it
auto_minimize = True

# Functions for changing groups
def window_to_prev_group(qtile):
	if qtile.currentWindow is not None:
		i = qtile.groups.index(qtile.currentGroup)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

# Hooks
#Runs startup applications
@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# java UI toolkits/whitelist
wmname = "LG3D"

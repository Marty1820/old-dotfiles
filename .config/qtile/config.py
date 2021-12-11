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

mod = "mod4"				# Sets mod key to SUPER
myTerm = "alacritty"
myBrowser = "vivaldi-stable"
myFilemgr = "pcmanfm"
myEditor = "gedit"
myAppLauncher = "rofi -modi drun -show drun -theme '~/.config/rofi/config.rasi'"
screenshot = "scrot -e 'mv $f ~/Pictures/Screenshot 2>/dev/null'"
lock = "dm-tool lock"

#Dracula color theme
colors = [["#282a36"], # Background Dark Grey
          ["#44475a"], # Current Line/Selection Grey
          ["#f8f8f2"], # Foreground Whitish
          ["#6272a4"], # Comment Blue/Grey
          ["#8be9fd"], # Cyan
          ["#50fa7b"], # Green
          ["#ffb86c"], # Orange
          ["#ff79c6"], # Pink
          ["#bd93f9"], # Purple
          ["#ff5555"], # Red
          ["#f1fa8c"]] # Yellow

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
    Key([mod], "Escape",
        lazy.shutdown(),
        desc="Shutdown Qtile"
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
    Key([mod], "l",
    	lazy.spawn(lock),
    	desc="Locks computer"
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
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return",
    	lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"
        ),
    
    
    Key([mod], "r",
    	lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"
        ),
        
    # Function keys
    # Screen
    Key([], 'XF86MonBrightnessUp',
    	lazy.spawn('xbacklight -inc 10')
    	),
    Key([], 'XF86MonBrightnessDown',
    	lazy.spawn('xbacklight -dec 10')
    	),
    # Audio
    Key([], 'XF86AudioMute',
    	lazy.spawn('amixer -D pulse set Master 1+ toggle')
    	),
    Key([], 'XF86AudioRaiseVolume',
    	lazy.spawn('amixer -D pulse sset Master 2%+')
    	),
    Key([], 'XF86AudioLowerVolume',
    	lazy.spawn('amixer -D pulse sset Master 2%-')
    	),
    Key([mod], 'XF86AudioRaiseVolume',
    	lazy.spawn('amixer -D pulse sset Master 10%+')
    	),
    Key([mod], 'XF86AudioLowerVolume',
    	lazy.spawn('amixer -D pulse sset Master 10%-')
    	),
    
    #Screenshots
    Key([], 'Print',
    	lazy.spawn(screenshot)
    	),
]

# Battery Icon & %
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
		elif status.state == BatteryState.EMPTY or \
				(status.state == BatteryState.UNKNOWN and status.percent == 0):
			char = ''
		else:
			char = ''
		return self.format.format(char=char, percent=status.percent)
	
	def restore(self):
		self.format = '{char}{percent:2.0%}'
		self.timer_setup()

battery = MyBattery(
	format = '{char} {percent:2.0%}',
    foreground = colors[0],
    background = colors[10],
    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('xfce4-power-manager-settings')},
)

def parse_func(text):
	for string in [" - Vivaldi", " - gedit"]:
		text = text.replace(string, "")
	return text

# Audio Volume
#class MyVolume(widget.Volume):
#	def _configure(self, qtile, bar):
#		widget.Volume._configure(self, qtile, bar)
#		self.volume = self.get_volume()
#		if self.volume <= 0:
#			self.text = '奄'
#		elif self.volume <= 50:
#			self.text = '奔'
#		else:
#			self.text = '墳'
		
#	def restore(self):
#		self.format = '{char} {volume}'
#		self.timer_setup()

#volume = MyVolume(
#	foreground = colors[0],
#    background = colors[8],
#    fmt = '{}',
#)

groups = [Group(""),
          Group(""),
          Group(""),
          Group("爵"),
          Group("", layout='floating')]
          
# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder("mod4")

layout_theme = {"border_width": 4,
                "margin": 6,
                "border_focus": colors[8],
                "border_normal": colors[1],
                }


layouts = [
    # layout.Columns(border_focus_stack=['#bd93f9', '#ff5555'], border_width=2),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
	layout.Floating(**layout_theme),
	layout.TreeTab(
		font = "mononoki Nerd Font Mono",
		fontsize = 24,
		border_width = 2,
		bg_color = colors[0],
		active_bg = colors[1],
		active_fg = colors[8],
		inactive_bg = colors[0],
		inactive_fg = colors[2],
		panel_width = 190,
		),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font = 'mononoki Nerd Font Mono',
    fontsize = 24,
    padding = 2,
    background = colors[0]
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
				widget.CurrentLayoutIcon(
					custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
					scale = 0.8,
					),
				widget.GroupBox(
                    active = colors[2],
                    inactive = colors[3],
                    fontsize = 32,
                    block_highlight_text_color = colors[8],
                    highlight_method = "block",
                    highlight_color = colors[1],
                    ),
                widget.Prompt(
                	prompt = 'Run: ',
                	padding = 5,
                	foreground = colors[8],
                	),
                widget.Sep(
                	linewidth = 0,
                    foreground = colors[3],
                    size_percent = 80,
                    ),
                widget.WindowName(
                	format = '{name}',
                	foreground = colors[2],
                	#max_chars = 40,
                	parse_text = parse_func,
                	),
                widget.TextBox(
                	text = '',
                	foreground = colors[3],
                	padding = 0,
                	fontsize = 28,
                	),
                widget.Systray(
                	icon_size = 26,
                	padding = 0,
                	foreground = colors[0],
                	background = colors[3],
                	),
                widget.TextBox(
                	text = '',
                	foreground = colors[9],
                	background = colors[3],
                	padding = 0,
                	fontsize = 28,
                	),
              widget.CheckUpdates(
                    update_interval = 1800,
                    distro = "Arch",
                    display_format = "{updates} Updates",
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e parusyu')},
                    foreground = colors[0],
                    background = colors[9],
                    ),
                widget.TextBox(
                	text = '',
                	foreground = colors[4],
                	background = colors[9],
                	padding = 0,
                	fontsize = 28,
                	),
                #widget.TextBox(
                #	text = 'config',
                #	foreground = colors[0],
                #	background = colors[4],
                #	),
                widget.Bluetooth(
                	background = colors[4],
                	foreground = colors[0],
                	fmt = '{}',
                	hci = '/dev_EF_BA_FD_8F_CC_30',
                	mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('blueman-manager')},
                	),
                widget.TextBox(
                	text = '',
                	foreground = colors[5],
                	background = colors[4],
                	padding = 0,
                	fontsize = 28,
                	),
                widget.Net(
                	interface = "wlp170s0",
                	format = '{down}↓↑{up}',
                	foreground = colors[0],
                	background = colors[5],
                	mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('nm-connection-editor')},
                	),
                widget.TextBox(
                	text = '',
                	foreground = colors[6],
                	background = colors[5],
                	padding = 0,
                	fontsize = 28,
                	),
              	widget.ThermalSensor(
                    threshold = 90,
                    foreground = colors[0],
                    background = colors[6],
                    fmt = '{}',
                    ),
                widget.TextBox(
                	text = '',
                	foreground = colors[7],
                	background = colors[6],
                	padding = 0,
                	fontsize = 28,
                	),
              	widget.Memory(
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e btop')},
                    foreground = colors[0],
                    background = colors[7],
                    fmt = '{}',
                    measure_mem = 'G',
                    format = '{MemUsed:.1f}{mm}/{MemTotal:.0f}{mm}',
                    ),
                widget.TextBox(
                	text = '',
                	foreground = colors[8],
                	background = colors[7],
                	padding = 0,
                	fontsize = 28,
                	),
                #volume,
              	widget.Volume(
                    foreground = colors[0],
                    background = colors[8],
                    fmt = '墳{}',
                    ),
				widget.TextBox(
                	text = '',
                	foreground = colors[2],
                	background = colors[8],
                	padding = 0,
                	fontsize = 28,
                	),
               	#widget.Wttr(
                #	foreground = colors[0],
                #	background = colors[2],
                #	location = '',
                #	#units = 'u',
                #	format = '%c+%t',
                #	update_interval=30,
                #	),
                widget.Clock(
                	format='%b %d %I:%M%p',
                	foreground = colors[0],
                	background = colors[2],
                	),
               	widget.TextBox(
                	text = '',
                	foreground = colors[10],
                	background = colors[2],
                	padding = 0,
                	fontsize = 28,
                	),
                battery,
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
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

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# Functions
def window_to_prev_group(qtile):
	if qtile.currentWindow is not None:
		i = qtile.groups.index(qtile.currentGroup)

def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

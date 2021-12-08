# ███╗░░░███╗░█████╗░██████╗░████████╗██╗░░░██╗
# ████╗░████║██╔══██╗██╔══██╗╚══██╔══╝╚██╗░██╔╝
# ██╔████╔██║███████║██████╔╝░░░██║░░░░╚████╔╝░
# ██║╚██╔╝██║██╔══██║██╔══██╗░░░██║░░░░░╚██╔╝░░
# ██║░╚═╝░██║██║░░██║██║░░██║░░░██║░░░░░░██║░░░
# ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░
#
# qtile config
# -*- coding: utf-8 -*-

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
#screenshot = "scrot -e 'mv $f ~/Pictures/Screenshot 2>/dev/null'"
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
    Key([mod, "shift"], "q",
        lazy.shutdown(),
        desc="Shutdown Qtile"
        ),
    Key([mod, "shift"], "r",
        lazy.restart(),
        desc="Restart Qtile"
        ),
    Key([mod, "shift"], "x",
    	lazy.spawn(lock),
    	desc="Locks computer"
    	),
    Key([mod, "shift"], "c",
        lazy.window.kill(),
        desc="Kill focused window"
        ),
    Key([mod], "space",
        lazy.next_layout(),
        desc="Toggle between layouts"
        ),
    # Switch between windows
    Key([mod], "h",
        lazy.layout.left(),
        desc="Move focus to left"
        ),
    Key([mod], "l",
        lazy.layout.right(),
        desc="Move focus to right"
        ),
    Key([mod], "j",
        lazy.layout.up(),
        desc="Move focus up"
        ),
    Key([mod], "k",
        lazy.layout.down(),
        desc="Move focus down"
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
    	lazy.layout.grow_left(),
        desc="Grow window to the left"
        ),
    Key([mod, "control"], "l",
    	lazy.layout.grow_right(),
        desc="Grow window to the right"
        ),
    Key([mod, "control"], "j",
    	lazy.layout.grow_up(),
        desc="Grow window up"
        ),
    Key([mod, "control"], "k",
    	lazy.layout.grow_down(),
    	desc="Grow window down"
    	),
    Key([mod], "n",
    	lazy.layout.normalize(),
    	desc="Reset all window sizes"
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
    
    #Screenshots
    Key([], 'Print',
    	lazy.spawn('scrot -e "mv $f ~/Pictures/Screenshot 2>/dev/null"')
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
)

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
          Group("")]

# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder("mod4")

layout_theme = {"border_width": 2,
                "margin": 8,
                "border_focus": "bd93f9",
                "border_normal": "282a36"
                }


layouts = [
    layout.Columns(border_focus_stack=['#bd93f9', '#ff5555'], border_width=2),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
    layout.Floating(),
]

widget_defaults = dict(
    font='mononoki Nerd Font Mono',
    fontsize=24,
    padding=2,
    background = colors[0]
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
				widget.CurrentLayoutIcon(
					),
				widget.GroupBox(
                    active = colors[2],
                    fontsize = 32,
                    block_highlight_text_color = colors[8],
                    highlight_method = "block",
                    ),
                widget.Prompt(),
                widget.Sep(
                	linewidth = 0,
                    foreground = colors[3],
                    size_percent = 80,
                    ),
                widget.WindowName(
                	format = '{name}',
                	),
                widget.TextBox(
                	text = '',
                	foreground = colors[3],
                	padding = 0,
                	fontsize = 28,
                	),
                widget.Systray(
                	icon_size = 26,
                	padding = 10,
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
                    distro = "Arch_checkupdates",
                    display_format = "{updates} ",
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e sudo pacman -Syu')},
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
                widget.Bluetooth(
                	background = colors[4],
                	foreground = colors[0],
                	fmt = '{}',
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
                	format = '直{down}↓↑{up}',
                	foreground = colors[0],
                	background = colors[5],
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
               # widget.Wttr(
               # 	foreground = colors[0],
               # 	background = colors[2],
               # 	location = 'Minot',
               # 	units = 'u',
               # 	format = '%t(%f)',
               # 	),
                widget.Clock(
                	format='%b %d %I:%M%p',
                	foreground = colors[0],
                	background = colors[2],
                    #mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -hold -e cal -3')},
                	),
               	widget.TextBox(
                	text = '',
                	foreground = colors[10],
                	background = colors[2],
                	padding = 0,
                	fontsize = 28,
                	),
                battery,
                #widget.Battery(
                	#charge_char = '',
                	#discharge_char = '',
                	#empty_char = '',
                	#full_char = '',
                	#format = '{char} {percent:2.0%}',
                	#foreground = colors[0],
                	#background = colors[10],
                	#),
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
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(title='conky'),
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

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

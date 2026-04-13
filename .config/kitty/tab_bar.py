import subprocess
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.tab_bar import DrawData, ExtraData, Formatter, TabBarData, as_rgb, draw_attributed_string, draw_tab_with_powerline

timer = None
ss = ''

def draw_tab(draw_data: DrawData, screen: Screen, tab: TabBarData, before: int, max_title_length: int, index: int, is_last: bool, extra_data: ExtraData) -> int:
    global timer
    global ss
    if timer is None:
        timer = add_timer(redraw_tab_bar, 3.0, True)
    end = draw_tab_with_powerline(draw_data, screen, tab, before, max_title_length, index, is_last, extra_data)
    if is_last:
        cells = screen.columns - screen.cursor.x - len(ss)
        if cells > 1:
            screen.draw(' ' * (cells - 1))
        screen.cursor.fg = as_rgb(0x6b98de)
        screen.draw('')
        draw_attributed_string(Formatter.reset, screen)
        screen.cursor.bg = as_rgb(0x6b98de)
        screen.cursor.fg = as_rgb(0xffffff)
        screen.draw(ss)
    return end

def get_sys_status():
    try:
        cp = subprocess.run(['/Users/aura/.local/bin/free', '-h'], stdout=subprocess.PIPE, text=True)
        lines = cp.stdout.splitlines()
        mem = lines[1].split()
        cp = subprocess.run(['uptime'], stdout=subprocess.PIPE, text=True)
        load = cp.stdout.rsplit(':', 1)[-1].strip()
        return f'  {mem[2]}/{mem[1]}│ {load} '
    except Exception:
        return ' N/A '

def redraw_tab_bar(_):
    global ss
    ss = get_sys_status()
    tm = get_boss().active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()

import ctypes
import time
import os
import win32api
import win32gui

def display_logo():
    purple = "\033[38;5;93m"
    violet = "\033[38;5;135m"
    reset = "\033[0m"
    logo = [
        "       (`-''-/).___..--''\"`-._",
        "       `6_ 6  )   `-.  (     ).`-.__.`)",
        "       (_Y_.)'  ._   )  `._ `. ``-..-'",
        "    _..`--'_..-_/  /--'_.' ,'",
        "   (il).-''  (li).'  ((!.-'"
    ]
    
    os.system("cls" if os.name == "nt" else "clear")
    for i, line in enumerate(logo):
        color = purple if i % 2 == 0 else violet
        print(f"{color}{line}{reset}")

def prompt_user():
    prompt_color = "\033[38;5;183m"
    reset = "\033[0m"
    
    while True:
        user_input = input(
            f"""
    {prompt_color}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┑
      # 1 ~ Ak
      # 2 ~ Lr-300
    ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┛{reset}
            """
        ).strip()
        try:
            choice = int(user_input)
            if choice in [1, 2]:
                os.system("cls" if os.name == "nt" else "clear")
                print("To return, hold down P + O")
                return choice
            else:
                print(f"{prompt_color}Invalid choice. Please select 1 or 2.{reset}")
        except ValueError:
            print(f"{prompt_color}Please enter a valid number.{reset}")

def send_mouse_input(choice):
    global deltaX, deltaY, last_time
    current_time = time.time()
    if last_time is None:
        last_time = current_time
    elapsed_time = current_time - last_time
    
    if elapsed_time <= 0.42:
        deltaX = -1.71
        deltaY += 3
    elif elapsed_time <= 0.38:
        deltaX = -1.511
        deltaY += 3
    else:
        deltaX = -2.75
        deltaY += 3
    
    if choice == 2:
        deltaX = 0
        deltaY += 0.5

    intX = int(deltaX)
    intY = int(deltaY)
    deltaX -= intX
    deltaY -= intY
    mouse_input = InputEvent(type=0, mi=MouseInput(dx=intX, dy=intY, mouseData=0, dwFlags=MOUSEEVENTF_MOVE))
    user32.SendInput(1, ctypes.byref(mouse_input), ctypes.sizeof(mouse_input))

def is_rust_active():
    window_handle = win32gui.GetForegroundWindow()
    window_title = win32gui.GetWindowText(window_handle)
    return "Rust" in window_title

def are_keys_pressed():
    return win32api.GetKeyState(1) < 0 and win32api.GetKeyState(2) < 0

def are_keys_p_o_pressed():
    return win32api.GetKeyState(ord('P')) < 0 and win32api.GetKeyState(ord('O')) < 0

def update_window_title(spinner_index):
    spinner_chars = ["|", "/", "-", "\\"]
    spinner_char = spinner_chars[spinner_index % len(spinner_chars)]
    win32gui.SetWindowText(win32gui.GetForegroundWindow(), f"Running {spinner_char}")

os.system("cls" if os.name == "nt" else "clear")
display_logo()
choice = prompt_user()

user32 = ctypes.windll.user32

class MouseInput(ctypes.Structure):
    _fields_ = [
        ("dx", ctypes.c_long),
        ("dy", ctypes.c_long),
        ("mouseData", ctypes.c_ulong),
        ("dwFlags", ctypes.c_ulong),
        ("time", ctypes.c_ulong),
        ("dwExtraInfo", ctypes.POINTER(ctypes.c_ulong)),
    ]

class InputEvent(ctypes.Structure):
    _fields_ = [("type", ctypes.c_ulong), ("mi", MouseInput)]

MOUSEEVENTF_MOVE = 1
deltaX = 0.0
deltaY = 0.0
last_time = None
spinner_index = 0

while True:
    if is_rust_active() and are_keys_pressed():
        send_mouse_input(choice)
    elif are_keys_p_o_pressed():
        os.system("cls" if os.name == "nt" else "clear")
        choice = prompt_user()
    else:
        last_time = None
    
    update_window_title(spinner_index)
    spinner_index += 1
    time.sleep(0.1)

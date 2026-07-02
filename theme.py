"""Design tokens: single source of truth for colors, typography, spacing,
and animation timing across the entire UI.

Imported by hud_window.py, settings_window.py, and main.py so every surface
shares one consistent visual language. A future dark/light theme switch would
swap these values rather than chase hardcoded strings through QSS.
"""
from __future__ import annotations

# ---- Accent palette (Nordic Forest Muted Steel Blue) ----
ACCENT = "#5A8F9E"
ACCENT_BRIGHT = "#71A5B5"
ACCENT_PRESSED = "#437482"
ACCENT_TEXT = "white"

# ---- HUD (Nordic Forest dark overlay) ----
# Gradient stops as (R, G, B) tuples; caller applies alpha.
HUD_BG_TOP = (30, 37, 48)              # #1E2530
HUD_GLASS_HIGHLIGHT = (40, 48, 61)     # subtle top-edge highlight stop
HUD_BG_BOTTOM = (24, 29, 38)           # #181D26
HUD_BORDER = "rgba(138, 149, 165, 50)" # soft slate gray border
HUD_TEXT_PRIMARY = "#EAECEF"
HUD_TEXT_COLOR_RGB = (234, 236, 239)
HUD_TEXT_SECONDARY = "rgba(138, 149, 165, 220)"
HUD_TEXT_TERTIARY = "rgba(138, 149, 165, 140)"
HUD_INPUT_TEXT = "rgba(138, 149, 165, 180)"
HUD_INPUT_ITALIC = True
HUD_DIVIDER = "rgba(138, 149, 165, 45)"
HUD_SHADOW_COLOR = (15, 18, 24, 180)    # soft, dark shadow for dark palette

# Button surface (glassmorphic muted buttons)
HUD_BTN_BG = "rgba(255, 255, 255, 20)"
HUD_BTN_BG_HOVER = "rgba(255, 255, 255, 40)"
HUD_BTN_BG_PRESSED = "rgba(255, 255, 255, 12)"
HUD_BTN_BORDER = "rgba(138, 149, 165, 50)"
HUD_BTN_BORDER_HOVER = "rgba(138, 149, 165, 120)"

# ---- Settings dialog (light theme) ----
SETTINGS_BG = "#F4F5F8"
SETTINGS_CARD_BG = "white"
SETTINGS_CARD_BORDER = "#E3E6EC"
SETTINGS_INPUT_BORDER = "#D2D6DF"
SETTINGS_TEXT_PRIMARY = "#1F2330"
SETTINGS_TEXT_SECONDARY = "#6A6F7D"

# ---- Status indicator (kind → RGB) ----
STATUS_COLORS = {
    "idle": (180, 180, 180),
    "connecting": (255, 197, 61),
    "connected": (61, 220, 132),
    "error": (255, 92, 92),
    "warning": (255, 159, 67),
    "info": (120, 170, 255),
}

# ---- Semantic colors ----
COLOR_SUCCESS = "#1A8A4A"
COLOR_ERROR = "#C0392B"
COLOR_WARNING = "#FF9F43"

# ---- Typography ----
# Qt 6 QFont.setFamilies() takes a list; QSS font-family takes a string.
FONT_FAMILIES = ["Segoe UI", "Microsoft YaHei", "PingFang SC", "Noto Sans CJK SC", "Arial"]
FONT_FAMILY_QSS = ", ".join(f'"{f}"' for f in FONT_FAMILIES)

# ---- Corner radii ----
RADIUS_CARD_HUD = 16
RADIUS_CARD_SETTINGS = 10
RADIUS_BUTTON = 8
RADIUS_INPUT = 7
RADIUS_BADGE = 9

# ---- Animation timing (milliseconds) ----
# Three tiers cover every transition in the app, keeping the rhythm consistent.
ANIM_FAST = 150    # hover/press feedback, control-bar collapse
ANIM_NORMAL = 250  # general UI transitions
ANIM_SLOW = 450    # drag-hint fade, HUD entrance
ANIM_PULSE = 900   # status-dot pulse loop (connecting)

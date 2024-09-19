/* Copyright 2024 @ Keychron (https://www.keychron.com)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H
#include "keychron_common.h"

enum layers {
    MAC_BASE = 0,
    MAC_L1 = 1,
    MAC_L2 = 2,
    WIN_BASE = 3,
    WIN_L1 = 4,
    WIN_L2 = 5,
};

enum custom_keycodes {
    CK_LPRT = SAFE_RANGE,
    CK_RPRT = SAFE_RANGE + 1,
};

// clang-format off
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    // Template layer
    // [] = LAYOUT_ansi_90(
    //     _______,         _______,            _______,  _______,  _______,  _______,  _______,  _______,  /* \/ */  _______,  _______,  _______,  _______,  _______,  _______,                   _______,  _______,
    //     _______,         _______,            _______,  _______,  _______,  _______,  _______,  _______,  /* \/ */  _______,  _______,  _______,  _______,  _______,  _______,                   _______,  _______,
    //              /* -------------------------------------------------------------------------------------------------------------------------------------------------------------- */
    //     _______, /* \ */ _______,            _______,  _______,  _______,  _______,  _______,            /* \/ */  _______,  _______,  _______,  _______,  _______,  _______, /* / */ _______,  _______,  _______,
    //     _______, /* \ */ _______,            _______,  _______,  _______,  _______,  _______,            /* \/ */  _______,  _______,  _______,  _______,  _______,           /* / */ _______,  _______,  _______,
    //     _______, /* \ */ _______,            _______,  _______,  _______,  _______,  _______,            /* \/ */  _______,  _______,  _______,  _______,  _______,           /* / */ _______,  _______,  _______,
    //     _______, /* \ */ _______,  _______,            _______,  _______,            _______,            /* \/ */  _______,                      _______,  _______,           /* / */           _______,  _______,  _______),

    [MAC_BASE] = LAYOUT_ansi_90(
        KC_MUTE,      KC_ESC,              KC_BRID,  KC_BRIU,  RGB_VAD,  RGB_VAI,  KC_MCTRL,  KC_LNPAD,  /* \/ */  KC_VOLD,  KC_VOLU,  KC_MPRV,  KC_MPLY,     KC_MNXT,     KC_MUTE,                   KC_DEL,   KC_INS,
        MC_1,         KC_GRV,              KC_1,     KC_2,     KC_3,     KC_4,     KC_5,      KC_6,      /* \/ */  KC_7,     KC_8,     KC_9,     KC_0,        KC_MINS,     KC_EQL,                    KC_BSPC,  KC_PGUP,
              /* ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
        MC_2, /* \ */ KC_TAB,              KC_Q,     KC_W,     KC_E,     KC_R,     KC_T,                 /* \/ */  KC_Y,     KC_U,     KC_I,     KC_O,        KC_P,        KC_LBRC, /* / */ KC_RBRC,  KC_BSLS,  KC_PGDN,
        MC_3, /* \ */ KC_ESC,              KC_A,     KC_S,     KC_D,     KC_F,     KC_G,                 /* \/ */  KC_H,     KC_J,     KC_K,     KC_L,        KC_SCLN,              /* / */ KC_QUOT,  KC_ENT,   KC_HOME,
        MC_4, /* \ */ KC_LSFT,             KC_Z,     KC_X,     KC_C,     KC_V,     KC_BSPC,              /* \/ */  KC_B,     KC_N,     KC_M,     KC_COMM,     KC_DOT,               /* / */ KC_SLSH,  KC_RSFT,  KC_UP,
        MC_5, /* \ */ KC_LCTL,  KC_LOPTN,            KC_LCMD,  KC_SPC,             KC_ENT,               /* \/ */  KC_SPC,                       MO(MAC_L1),  MO(MAC_L2),           /* / */           KC_LEFT,  KC_DOWN,  KC_RIGHT),

    [MAC_L1] = LAYOUT_ansi_90(
        RGB_TOG,         _______,             KC_F1,    KC_F2,    KC_F3,    KC_F4,    KC_F5,    KC_F6,    /* \/ */  KC_F7,    KC_F8,    KC_F9,    KC_F10,   KC_F11,   KC_F12,                    RGB_TOG,   BAT_LVL,
        BT_HST1,         _______,             _______,  _______,  _______,  _______,  _______,  _______,  /* \/ */  _______,  _______,  _______,  _______,  RGB_HUD,  RGB_HUI,                   _______,   RGB_SPI,
                 /* --------------------------------------------------------------------------------------------------------------------------------------------------------------- */
        BT_HST2, /* \ */ KC_GRV,              KC_1,     KC_2,     KC_3,     KC_4,     KC_5,               /* \/ */  KC_6,     KC_7,     KC_8,     KC_9,     KC_0,     _______, /* / */ _______,  NK_TOGG,   RGB_SPD,
        BT_HST3, /* \ */ _______,             _______,  KC_SLSH,  CK_LPRT,  CK_RPRT,  _______,            /* \/ */  KC_GRV,   KC_QUOT,  _______,  KC_MINS,  KC_EQL,            /* / */ _______,  _______,   KC_END,
        P2P4G,   /* \ */ _______,             _______,  _______,  KC_LBRC,  KC_RBRC,  KC_DEL,             /* \/ */  KC_BSLS,  _______,  _______,  _______,  _______,           /* / */ _______,  _______,   RGB_SAI,
        _______, /* \ */ KC_RCTL,  KC_ROPTN,            KC_RCMD,  KC_RSFT,            _______,            /* \/ */  _______,                      _______,  _______,           /* / */           RGB_RMOD,  RGB_SAD,  RGB_MOD),

    [MAC_L2] = LAYOUT_ansi_90(
        RGB_TOG,         _______,             KC_F1,    KC_F2,    KC_F3,     KC_F4,    KC_F5,    KC_F6,    /* \/ */  KC_F7,    KC_F8,    KC_F9,    KC_F10,   KC_F11,   KC_F12,                     RGB_TOG,   BAT_LVL,
        BT_HST1,         _______,             _______,  _______,  _______,   _______,  _______,  _______,  /* \/ */  _______,  _______,  _______,  _______,  RGB_HUD,  RGB_HUI,                    _______,   RGB_SPI,
                 /* ----------------------------------------------------------------------------------------------------------------------------------------------------------------- */
        BT_HST2, /* \ */ _______,             _______,  KC_UP,    KC_HOME,   KC_END,   KC_PGUP,            /* \/ */  _______,  _______,  _______,  _______,   _______,  KC_INS,  /* / */ _______,  NK_TOGG,   RGB_SPD,
        BT_HST3, /* \ */ _______,             KC_LEFT,  KC_DOWN,  KC_RIGHT,  _______,  KC_PGDN,            /* \/ */  KC_LEFT,  KC_DOWN,  KC_UP,    KC_RIGHT,  _______,           /* / */ _______,  _______,   KC_END,
        P2P4G,   /* \ */ _______,             _______,  _______,  _______,   _______,  _______,            /* \/ */  _______,  _______,  _______,  _______,   _______,           /* / */ _______,  _______,   RGB_SAI,
        _______, /* \ */ KC_RCTL,  KC_ROPTN,            KC_RCMD,  KC_RSFT,             _______,            /* \/ */  _______,                      _______,   _______,           /* / */           RGB_RMOD,  RGB_SAD,  RGB_MOD),

    [WIN_BASE] = LAYOUT_ansi_90(
        KC_MUTE,      KC_ESC,             KC_F1,  KC_F2,    KC_F3,    KC_F4,  KC_F5,  KC_F6,  /* \/ */  KC_F7,    KC_F8,  KC_F9,  KC_F10,      KC_F11,   KC_F12,                    KC_DEL,   KC_PRINT_SCREEN,
        MC_1,         KC_GRV,             KC_1,   KC_2,     KC_3,     KC_4,   KC_5,   KC_6,   /* \/ */  KC_7,     KC_8,   KC_9,   KC_0,        KC_MINS,  KC_EQL,                    KC_BSPC,  KC_PGUP,
              /* ----------------------------------------------------------------------------------------------------------------------------------------------------- */
        MC_2, /* \ */ KC_TAB,             KC_Q,   KC_W,     KC_E,    KC_R,    KC_T,           /* \/ */  KC_Y,     KC_U,   KC_I,   KC_O,        KC_P,     KC_LBRC, /* / */ KC_RBRC,  KC_BSLS,  KC_PGDN,
        MC_3, /* \ */ KC_ESC,             KC_A,   KC_S,     KC_D,    KC_F,    KC_G,           /* \/ */  KC_H,     KC_J,   KC_K,   KC_L,        KC_SCLN,           /* / */ KC_QUOT,  KC_ENT,   KC_HOME,
        MC_4, /* \ */ KC_LSFT,            KC_Z,   KC_X,     KC_C,    KC_V,    KC_BSPC,        /* \/ */  KC_B,     KC_N,   KC_M,   KC_COMM,     KC_DOT,            /* / */ KC_SLSH,  KC_RSFT,  KC_UP,
        MC_5, /* \ */ KC_LALT,  KC_LGUI,          KC_LCTL,  KC_SPC,           KC_ENT,         /* \/ */  KC_SPC,                   MO(WIN_L1),  MO(WIN_L2),        /* / */           KC_LEFT,  KC_DOWN,  KC_RIGHT),

    [WIN_L1] = LAYOUT_ansi_90(
        RGB_TOG,         _______,            KC_BRID,  KC_BRIU,  RGB_VAD,  RGB_VAI,  KC_TASK,  KC_FILE,  /* \/ */  KC_VOLD,  KC_VOLU,  KC_MPRV,  KC_MPLY,  KC_MNXT,  KC_MUTE,                   RGB_TOG,   BAT_LVL,
        BT_HST1,         _______,            _______,  _______,  _______,  _______,  _______,  _______,  /* \/ */  _______,  _______,  _______,  _______,  RGB_HUD,  RGB_HUI,                   _______,   RGB_SPI,
                 /* -------------------------------------------------------------------------------------------------------------------------------------------------------------- */
        BT_HST2, /* \ */ KC_GRV,             KC_1,     KC_2,     KC_3,     KC_4,     KC_5,               /* \/ */  KC_6,     KC_7,     KC_8,     KC_9,     KC_0,     _______, /* / */ _______,  NK_TOGG,   RGB_SPD,
        BT_HST3, /* \ */ _______,            _______,  KC_SLSH,  CK_LPRT,  CK_RPRT,  _______,            /* \/ */  KC_GRV,   KC_QUOT,  _______,  KC_MINS,  KC_EQL,            /* / */ _______,  _______,   KC_END,
        P2P4G,   /* \ */ _______,            _______,  _______,  KC_LBRC,  KC_RBRC,  KC_DEL,             /* \/ */  KC_BSLS,  _______,  _______,  _______,  _______,           /* / */ _______,  _______,   RGB_SAI,
        _______, /* \ */ KC_RALT,  KC_RGUI,            KC_RCTL,  KC_RSFT,            _______,            /* \/ */  _______,                      _______,  _______,           /* / */           RGB_RMOD,  RGB_SAD,  RGB_MOD),

    [WIN_L2] = LAYOUT_ansi_90(
        RGB_TOG,         _______,            KC_BRID,  KC_BRIU,  RGB_VAD,  RGB_VAI,  KC_TASK,  KC_FILE,  /* \/ */  KC_VOLD,  KC_VOLU,  KC_MPRV,  KC_MPLY,  KC_MNXT,  KC_MUTE,                    RGB_TOG,   BAT_LVL,
        BT_HST1,         _______,            _______,  _______,  _______,  _______,  _______,  _______,  /* \/ */  _______,  _______,  _______,  _______,  RGB_HUD,  RGB_HUI,                    _______,   RGB_SPI,
                 /* --------------------------------------------------------------------------------------------------------------------------------------------------------------- */
        BT_HST2, /* \ */ _______,            _______,  KC_UP,    KC_HOME,   KC_END,   KC_PGUP,           /* \/ */  _______,  _______,  _______,  _______,   _______,  KC_INS,  /* / */ _______,  NK_TOGG,   RGB_SPD,
        BT_HST3, /* \ */ _______,            KC_LEFT,  KC_DOWN,  KC_RIGHT,  _______,  KC_PGDN,           /* \/ */  KC_LEFT,  KC_DOWN,  KC_UP,    KC_RIGHT,  _______,           /* / */ _______,  _______,   KC_END,
        P2P4G,   /* \ */ _______,            _______,  _______,  _______,   _______,  _______,           /* \/ */  _______,  _______,  _______,  _______,   _______,           /* / */ _______,  _______,   RGB_SAI,
        _______, /* \ */ KC_RALT,  KC_RGUI,            KC_RCTL,  KC_RSFT,             _______,           /* \/ */  _______,                      _______,   _______,           /* / */           RGB_RMOD,  RGB_SAD,  RGB_MOD),
};

#if defined(ENCODER_MAP_ENABLE)
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][2] = {
    [MAC_BASE] = {ENCODER_CCW_CW(KC_VOLD, KC_VOLU)},
    [MAC_L1] = {ENCODER_CCW_CW(RGB_VAD, RGB_VAI)},
    [MAC_L2] = {ENCODER_CCW_CW(RGB_VAD, RGB_VAI)},
    [WIN_BASE] = {ENCODER_CCW_CW(KC_VOLD, KC_VOLU)},
    [WIN_L1] = {ENCODER_CCW_CW(RGB_VAD, RGB_VAI)},
    [WIN_L2] = {ENCODER_CCW_CW(RGB_VAD, RGB_VAI)},
};
#endif // ENCODER_MAP_ENABLE

// clang-format on
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    if (!process_record_keychron_common(keycode, record)) {
        return false;
    }

    switch (keycode) {
        case CK_LPRT:
            if (record->event.pressed) {
                SEND_STRING("(");
            }
            return false;
        case CK_RPRT:
            if (record->event.pressed) {
                SEND_STRING(")");
            }
            return false;
        default:
            break;
    }

    return true;
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *   Mupen64plus - debugger.h                                              *
 *   Mupen64Plus homepage: http://code.google.com/p/mupen64plus/           *
 *   Copyright (C) 2008 DarkJeztr                                          *
 *   Copyright (C) 2002 davFr                                              *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.          *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef __DEBUGGER_H__
#define __DEBUGGER_H__

#include <stdlib.h>
#include <string.h>

#include <SDL.h>
#include <SDL_thread.h>

#include "types.h"
#include "breakpoints.h"
#include "memory.h"

#include "../r4300/r4300.h"
#include "../memory/memory.h"

extern int debugger_mode;  /* Debugger option enabled. */
extern int g_DebuggerEnabled;  /* Whether the debugger is enabled. */

/* State of the Emulation Thread:
   0 -> pause, 1 -> step, 2 -> run. */
extern int run;

extern uint32 previousPC;

void init_debugger();
void update_debugger(uint32 pc);
void destroy_debugger();
void debugger_step();

extern void init_debugger_frontend();
extern void update_debugger_frontend( uint32 pc );
extern void debugger_frontend_vi();

#endif /* __DEBUGGER_H__ */

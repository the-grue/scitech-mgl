/****************************************************************************
*
*                   SciTech OS Portability Manager Library
*
*  ========================================================================
*
*   Copyright (C) 1991-2004 SciTech Software, Inc. All rights reserved.
*
*   This file may be distributed and/or modified under the terms of the
*   GNU General Public License version 2.0 as published by the Free
*   Software Foundation and appearing in the file LICENSE.GPL included
*   in the packaging of this file.
*
*   Licensees holding a valid Commercial License for this product from
*   SciTech Software, Inc. may use this file in accordance with the
*   Commercial License Agreement provided with the Software.
*
*   This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING
*   THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
*   PURPOSE.
*
*   See http://www.scitechsoft.com/license/ for information about
*   the licensing options available and how to purchase a Commercial
*   License Agreement.
*
*   Contact license@scitechsoft.com if any conditions of this licensing
*   are not clear to you, or you have questions about licensing options.
*
*  ========================================================================
*
* Language:     ANSI C
* Environment:  Unununium
*
* Description:  Module to implement OS specific services to measure the
*               CPU frequency.
*
****************************************************************************/

/*----------------------------- Implementation ----------------------------*/

/****************************************************************************
REMARKS:
Initialise the counter and return the frequency of the counter.
****************************************************************************/
static void GetCounterFrequency(
    CPU_largeInteger *freq)
{
    // TODO: Return the frequency of the counter in here. You should try to
    //       normalise this value to be around 100,000 ticks per second.
    freq->low = 1000000;
    freq->high = 0;
}

/****************************************************************************
REMARKS:
Read the counter and return the counter value.

TODO: Implement this to read the counter. It should be done as a macro
      for accuracy.
****************************************************************************/
#define GetCounter(t) {                     \
    asm volatile(                       \
        "pushl %0\n"                    \
        "call system_time.get_uuutime\n"            \
        ".long continue%=\n"                \
        ".long continue%=\n"                \
        "continue%=:\n"                 \
        "popl %0\n"                     \
        : : "a" (t) : "ebx", "ecx", "edx", "cc" );      \
}

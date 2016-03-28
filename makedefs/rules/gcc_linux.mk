#############################################################################
#
#                       SciTech Makefile Utilities
#
#  ========================================================================
#
#   Copyright (C) 1991-2002 SciTech Software, Inc. All rights reserved.
#
#   This file may be distributed and/or modified under the terms of the
#   GNU General Public License version 2 as published by the Free
#   Software Foundation and appearing in the file LICENSE.GPL included
#   in the packaging of this file.
#
#   Licensees holding a valid Commercial License for this product from
#   SciTech Software, Inc. may use this file in accordance with the
#   Commercial License Agreement provided with the Software.
#
#   This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING
#   THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#   PURPOSE.
#
#   See http://www.scitechsoft.com/license/ for information about
#   the licensing options available and how to purchase a Commercial
#   License Agreement.
#
#   Contact license@scitechsoft.com if any conditions of this licensing
#   are not clear to you, or you have questions about licensing options.
#
#  ========================================================================
#
# Descripton:   Rules makefile definitions, which define the rules used to
#               build targets. We include them here at the end of the
#               makefile so the generic project makefiles can override
#               certain things with macros (such as linking C++ programs
#               differently).
#
#############################################################################

# Take out PMLIB if we don't need to link with it

.IF $(NO_PMLIB)
PMLIB :=
.ENDIF

.IF $(USE_CXX_LINKER)
LD  := $(LDXX)
.ENDIF

# Implicit generation rules for making object files from source files
%$O: %.c ;
.IF $(SHOW_ARGS)
    $(CC) -c $(_CFLAGS) $<
.ELSE
    @$(ECHO) $(_CC) $(SHOW_CFLAGS) $<
    @$(CC) -c $(_CFLAGS) $<
.ENDIF

%$O: %$P ;
.IF $(SHOW_ARGS)
    $(CXX) -c $(_CFLAGS) $(_CPFLAGS) $<
.ELSE
    @$(ECHO) $(_CXX) $(SHOW_CFLAGS) $(SHOW_CPFLAGS) $<
    @$(CXX) -c $(_CFLAGS) $(_CPFLAGS) $<
.ENDIF

%$O: %$A ;
.IF $(SHOW_ARGS)
    $(AS) -o $@ $(_ASFLAGS) $<
.ELSE
    @$(ECHO) $(_AS) $(SHOW_ASFLAGS) $<
    @$(AS) -o $@ $(_ASFLAGS) $<
.ENDIF

# Implicit rule for building a library file
.IF $(BUILD_SO)
.IF $(USE_SNAP_DRV)
%.bpd:     ;
.IF $(SHOW_ARGS)
    $(LIB) $(LIBFLAGS) -L$(LIB_DEST_STATIC) -o $@ $& $(EXELIBS) $(SNAP_LIBS)
.ELSE
    @$(ECHO) $(LIB) $@
    @$(LIB) $(LIBFLAGS) -L$(LIB_DEST_STATIC) -o $@ $& $(EXELIBS) $(SNAP_LIBS)
.ENDIF
.IF $(DBG)
.ELSE
    @$(STRIP) $@
.ENDIF
.ELSE
%$L:     ;
.IF $(SHOW_ARGS)
    $(LIB) $(LIBFLAGS) -L$(LIB_DEST_STATIC) -Wl,-soname,$@.$(VERSIONMAJ) -o $@ $& -Wl,--whole-archive $(LIBS) -Wl,--no-whole-archive -lm $(EXTRA_LIBS)
.ELSE
    @$(ECHO) $(LIB) $@
    @$(LIB) $(LIBFLAGS) -L$(LIB_DEST_STATIC) -Wl,-soname,$@.$(VERSIONMAJ) -o $@ $& -Wl,--whole-archive $(LIBS) -Wl,--no-whole-archive -lm $(EXTRA_LIBS)
.ENDIF
.IF $(DBG)
.ELSE
    @$(STRIP) $@
.ENDIF
.ENDIF

.ELSE
%$L:     ;
.IF $(SHOW_ARGS)
    $(LIB) $(LIBFLAGS) $@ $&
.ELSE
    @$(ECHO) $(LIB) $@
    @$(LIB) $(LIBFLAGS) $@ $&
.ENDIF
.ENDIF

# Implicit rule for building an executable file
%$E:     ;
.IF $(SHOW_ARGS)
    $(LD) $(_LDFLAGS) -o $@ $& $(EXELIBS) $(PMLIB) -lm $(EXTRA_LIBS)
.ELSE
    @$(ECHO) ld $@
    @$(LD) $(_LDFLAGS) -o $@ $& $(EXELIBS) $(PMLIB) -lm $(EXTRA_LIBS)
.IF $(DBG)
.ELSE
    @$(STRIP) $@
.ENDIF
.ENDIF


# Makefile.rl --
#
# Part of: Marco's BASH Functions Library
# Contents: project rules
# Date: Sat Apr 19, 2003
#
# Abstract
#
#	This Makefile must be processed by the "automake.sh" script
#	and by GNU Autoconf: read the README and INSTALL files for
#	more details.
#
# Copyright (C)  2003, 2004  by Marco Maggi
#
# This library is free software;  you can redistribute it and/or modify
# it  under the  terms  of the  GNU  Lesser General  Public License  as
# published by the Free Software  Foundation; either version 2.1 of the
# License, or (at your option) any later version.
# 
# This library is  distributed in the hope that it  will be useful, but
# WITHOUT  ANY   WARRANTY;  without   even  the  implied   warranty  of
# MERCHANTABILITY  or FITNESS FOR  A PARTICULAR  PURPOSE.  See  the GNU
# Lesser General Public License for more details.
# 
# You  should have received  a copy  of the  GNU Lesser  General Public
# License along with  this library; if not, write  to the Free Software
# Foundation, Inc.,  59 Temple Place, Suite 330,  Boston, MA 02111-1307
# USA
#

#PAGE
## ------------------------------------------------------------
## Search paths.
## ------------------------------------------------------------

vpath	%.m4		$(top_srcdir)/modules:$(top_srcdir)/macros
vpath	%.sh.m4		$(top_srcdir)/modules
vpath	%.sh.m4		$(top_srcdir)/lib
vpath	%.sh.m4		$(top_srcdir)/examples
vpath	%.sh.m4		$(builddir)

#PAGE
## ------------------------------------------------------------
## Variables.
## ------------------------------------------------------------

M4FLAGS		= --include=$(top_srcdir)/lib \
		  --include=$(top_srcdir)/modules \
		  --include=$(top_srcdir)/macros \
		  --include=$(builddir)

#PAGE
## ------------------------------------------------------------
## Library rules.
## ------------------------------------------------------------

MODULES			= encode file getopts message programs signal \
			  string dialog main
LIBNAME			= libmbfl.sh

library_MODULES		= $(foreach m, $(MODULES), $(m).sh.m4)
library_SOURCES		= $(foreach m, $(MODULES), $(m).sh)
library_TARGETS		= $(LIBNAME)
library_INSTLST		= $(library_TARGETS)
library_INSTDIR		= $(pkgdatadir)

library_CLEANFILES	= $(library_TARGETS) $(library_SOURCES)
library_REALCLEANFILES	= $(library_CLEANFILES)

.PHONY: library-all library-clean library-realclean library-install

library-all: $(library_TARGETS)
library-clean:
	-$(RM) $(library_CLEANFILES)
library-realclean:
	-$(RM) $(library_REALCLEANFILES)

library-install:
AM_INSTALL_DATA(library)


$(library_SOURCES): %.sh: macros.m4 %.sh.m4
	$(M4) $(M4FLAGS) $(^) | \
	$(GREP) --invert-match -e '^#' -e '^$$' | $(SED) -e "s/^ \\+//" >$(@)

$(LIBNAME): $(library_SOURCES)
	$(M4) $(M4FLAGS) libmbfl.sh.m4 >$(@)


bin:		library-all
bin-clean:	library-clean
bin-realclean:	library-realclean
bin-install:	library-install

#page
## ------------------------------------------------------------
## Script rules.
## ------------------------------------------------------------

script_TARGETS		= mbfl-config
script_INSTLST		= mbfl-config
script_INSTDIR		= $(pkglibexecdir)

script_CLEANFILES	= $(script_TARGETS)
script_REALCLEANFILES	= $(script_CLEANFILES)

.PHONY: script-all script-clean script-realclean script-install

script-all: $(script_TARGETS)
script-clean:
	-$(RM) $(script_CLEANFILES)
script-realclean:
	-$(RM) $(script_REALCLEANFILES)

script-install:
AM_INSTALL_BIN(script)
AM_INSTALL_DIR($(bindir))
	cd $(INSTALL_ROOT)$(bindir) && \
	$(SYMLINK) $(subst $(prefix),..,$(pkglibexecdir)/mbfl-config) mbfl-config

mbfl-config:
	@echo -e "#!$(BASH)\necho $(pkgdatadir)/libmbfl.sh\n###end of file\n" >$(@)

bin:		script-all
bin-clean:	script-clean
bin-realclean:	script-realclean
bin-install:	script-install

#PAGE
## ------------------------------------------------------------
## Template rules.
## ------------------------------------------------------------

template_INSTLST	= $(top_srcdir)/examples/template.sh
template_INSTDIR	= $(pkgexampledir)

.PHONY: template-install

template-install:
AM_INSTALL_DATA([template])

doc-install:	template-install


### end of file
# Local Variables:
# mode: makefile
# page-delimiter: "^#PAGE"
# End:


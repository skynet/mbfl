# Part of: Marco's BASH Functions Library
# Contents: script template
# Date: Sun Sep 12, 2004
#
# Abstract
#
#	This script shows how an MBFL script should be organised
#	to use MBFL.
#
# Copyright (c) 2004, 2005, 2009, 2012, 2013 Marco Maggi
# <marco.maggi-ipsu@poste.it>
#
# This is free  software you can redistribute it  and/or modify it under
# the terms of  the GNU General Public License as  published by the Free
# Software Foundation; either  version 2, or (at your  option) any later
# version.
#
# This  file is  distributed in  the hope  that it  will be  useful, but
# WITHOUT   ANY  WARRANTY;  without   even  the   implied  warranty   of
# MERCHANTABILITY  or FITNESS  FOR A  PARTICULAR PURPOSE.   See  the GNU
# General Public License for more details.
#
# You  should have received  a copy  of the  GNU General  Public License
# along with this file; see the file COPYING.  If not, write to the Free
# Software Foundation,  Inc., 59  Temple Place -  Suite 330,  Boston, MA
# 02111-1307, USA.
#

#page
## ------------------------------------------------------------
## MBFL's related options and variables.
## ------------------------------------------------------------

script_PROGNAME=template.sh
script_VERSION=1.0
script_COPYRIGHT_YEARS='2004, 2005, 2009, 2012'
script_AUTHOR='Marco Maggi'
script_LICENSE=GPL
script_USAGE="usage: ${script_PROGNAME} [options] ..."
script_DESCRIPTION='This is an example script.'
script_EXAMPLES="Usage examples:

\t${script_PROGNAME} --alpha"

#page
## ------------------------------------------------------------
## Library loading.
## ------------------------------------------------------------

mbfl_INTERACTIVE=no
mbfl_LOADED=no
mbfl_HARDCODED=
mbfl_INSTALLED=$(mbfl-config) &>/dev/null
for item in "$MBFL_LIBRARY" "$mbfl_HARDCODED" "$mbfl_INSTALLED"
do
    if test -n "$item" -a -f "$item" -a -r "$item"
    then
        if ! source "$item" &>/dev/null
	then
            printf '%s error: loading MBFL file "%s"\n' \
                "$script_PROGNAME" "$item" >&2
            exit 2
        fi
	break
    fi
done
unset -v item
if test "$mbfl_LOADED" != yes
then
    printf '%s error: incorrect evaluation of MBFL\n' \
        "$script_PROGNAME" >&2
    exit 2
fi

#page
## ------------------------------------------------------------
## Script options.
## ------------------------------------------------------------

# keyword default-value brief-option long-option has-argument description
mbfl_declare_option ACTION_ONE   yes '' one   noarg 'selects action one'
mbfl_declare_option ACTION_TWO   no  '' two   noarg 'selects action two'
mbfl_declare_option ACTION_THREE no  '' three noarg 'selects action three'
mbfl_declare_option ACTION_FOUR  no  '' four  noarg 'selects action four'

# keyword default-value brief-option long-option has-argument description
mbfl_declare_option ALPHA no a alpha noarg 'selects action alpha'
mbfl_declare_option BETA '' b beta  witharg 'selects option beta'
mbfl_declare_option VALUE '' '' value witharg 'selects a value'
mbfl_declare_option FILE '' f file witharg 'selects a file'
mbfl_declare_option ENABLE no e enable noarg 'enables a feature'
mbfl_declare_option DISABLE no d disable noarg 'disables a feature'

#page
## ------------------------------------------------------------
## Declare external programs usage.
## ------------------------------------------------------------

#mbfl_file_enable_make_compress
#mbfl_file_enable_make_copy
#mbfl_file_enable_make_directory
#mbfl_file_enable_make_listing
#mbfl_file_enable_make_move
#mbfl_file_enable_make_permissions
#mbfl_file_enable_make_remove
#mbfl_file_enable_make_symlink
#mbfl_file_enable_make_tar
#mbfl_declare_program ls

#page
## ------------------------------------------------------------
## Declare exit codes.
## ------------------------------------------------------------

mbfl_main_declare_exit_code 2 second_error
mbfl_main_declare_exit_code 8 eighth_error
mbfl_main_declare_exit_code 3 third_error
mbfl_main_declare_exit_code 3 fourth_error

#page
## ------------------------------------------------------------
## Option update functions.
## ------------------------------------------------------------

function script_option_update_beta () {
    printf 'option beta: %s\n' "$script_option_BETA"
}
function script_option_update_alpha () {
    printf 'option alpha\n'
}

#page
## ------------------------------------------------------------
## Main functions.
## ------------------------------------------------------------

function script_before_parsing_options () {
    mbfl_message_verbose "$FUNCNAME\n"

    if test -n "$script_option_BETA"
    then printf 'option beta: %s\n' "$script_option_BETA"
    fi
    return 0
}
function script_after_parsing_options () {
    mbfl_message_verbose "$FUNCNAME\n"
    return 0
}
function main () {
    mbfl_program_validate_declared ||   exit_because_program_not_found
    printf "arguments: %d, '%s'\n" $ARGC "${ARGV[*]}"
    exit_because_success
}
function script_action_one () {
    printf "action one, arguments: %d, '%s'\n" $ARGC "${ARGV[*]}"
    exit_because_success
}
function script_action_two () {
    printf 'action two\n'
    exit_because_success
}
function script_action_three () {
    printf "action three, arguments: %d, '%s'\n" $ARGC "${ARGV[*]}"
    exit_because_success
}
function script_action_four () {
    printf "action four, arguments: %d, '%s'\n" $ARGC "${ARGV[*]}"
    exit_because_success
}

#page
## ------------------------------------------------------------
## Start.
## ------------------------------------------------------------

mbfl_main

### end of file
# Local Variables:
# mode: sh
# End:

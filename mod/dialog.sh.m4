# dialog.sh.m4 --
# 
# Part of: Marco's BASH Functions Library
# Contents: dialog functions
# Date: Sun Dec 21, 2003
# 
# Abstract
# 
#       This file is a collection of functions used to interact to the
#       user at the console.
# 
# Copyright (c) 2003 Marco Maggi
# 
# This is free software; you  can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the
# Free Software  Foundation; either version  2.1 of the License,  or (at
# your option) any later version.
# 
# This library  is distributed in the  hope that it will  be useful, but
# WITHOUT   ANY  WARRANTY;   without  even   the  implied   warranty  of
# MERCHANTABILITY  or FITNESS  FOR A  PARTICULAR PURPOSE.   See  the GNU
# Lesser General Public License for more details.
# 
# You  should have  received a  copy of  the GNU  Lesser  General Public
# License along  with this library; if  not, write to  the Free Software
# Foundation, Inc.,  59 Temple Place,  Suite 330, Boston,  MA 02111-1307
# USA
# 
# $Id: dialog.sh.m4,v 1.1.1.3 2003/12/22 19:53:50 marco Exp $
#

function mbfl_dialog_yes_or_no () {
    local STRING="${1:?}"
    local ANS=


    read -e -p "${STRING}? (yes/no) " ANS
    while test "$ANS" != 'yes' -a "$ANS" != 'no'
      do
      echo 'Please answer yes or no.'
      read -e -p "install?(yes/no) " ANS
    done

    if test "$ANS" = yes; then
        return 0
    else
        return 1
    fi
}

### end of file
# Local Variables:
# mode: sh
# page-delimiter: "^#PAGE$"
# indent-tabs-mode: nil
# End:

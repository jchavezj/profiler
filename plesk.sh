#!/bin/bash
# Plesk details v0.1.0
# Copyright (c) 2021,  Johnny Chavez 

# DESCRIPTION: This script will provide details about the Plesk installation# calling all functions

# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
# Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#################################################################################

	

echo -e "*************************************************************************"
echo -e "               Plesk Details                           "
echo -e "*************************************************************************"
#

# Displays Message Header
function write_header(){
        local h="$@"
        echo "*************************************************************************"
        echo "     ${h}"
        echo "*************************************************************************"
}


function plesk_version(){
        write_header "Plesk version"
        plesk version
        echo " "
}

function php_installed(){
	write_header "list of php versions installed"
        plesk bin php_handler --list

}

function php_domains(){
	 write_header "List of domains and their php versions"
  	 plesk db "select d.name,h.php_handler_id from domains d join hosting h on h.dom_id=d.id"

}

function extensions(){
	write_header "List of Extensions installed in Plesk"
        plesk bin extension -l
}

function db_list(){
	write_header "List of databases registered in Plesk"
	plesk bin database-server --list
}

function ip_list(){
	write_header "List of available IP Address"
	plesk bin ipmanage -l
}

function diskspace(){
	write_header "DiskSpace used"
	du -hd 1 /

}

function main(){
	# calling all functions
	plesk_version
	php_installed
	php_domains
	extensions
	db_list
	ip_list
	diskspace
	
}
main

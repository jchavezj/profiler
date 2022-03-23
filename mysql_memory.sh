#!/bin/sh
#  mysql_memory  v0.1.0
# Copyright (c) 2022,  Johnny Chavez

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


mysql -e "show variables; show status" | awk '  
{
VAR[$1]=$2  
}
END {  
MAX_CONN = VAR["max_connections"]  
MAX_USED_CONN = VAR["Max_used_connections"]  
BASE_MEM=VAR["key_buffer_size"] + VAR["query_cache_size"] + VAR["innodb_buffer_pool_size"] + VAR["innodb_additional_mem_pool_size"] + VAR["innodb_log_buffer_size"]  
MEM_PER_CONN=VAR["read_buffer_size"] + VAR["read_rnd_buffer_size"] + VAR["sort_buffer_size"] + VAR["join_buffer_size"] + VAR["binlog_cache_size"] + VAR["thread_stack"] + VAR["tmp_table_size"]  
MEM_TOTAL_MIN=BASE_MEM + MEM_PER_CONN*MAX_USED_CONN  
MEM_TOTAL_MAX=BASE_MEM + MEM_PER_CONN*MAX_CONN

printf "+------------------------------------------+--------------------+\n"  
printf "| %40s | %15.3f MB |\n", "key_buffer_size", VAR["key_buffer_size"]/1048576  
printf "| %40s | %15.3f MB |\n", "query_cache_size", VAR["query_cache_size"]/1048576  
printf "| %40s | %15.3f MB |\n", "innodb_buffer_pool_size", VAR["innodb_buffer_pool_size"]/1048576  
printf "| %40s | %15.3f MB |\n", "innodb_additional_mem_pool_size", VAR["innodb_additional_mem_pool_size"]/1048576  
printf "| %40s | %15.3f MB |\n", "innodb_log_buffer_size", VAR["innodb_log_buffer_size"]/1048576  
printf "+------------------------------------------+--------------------+\n"  
printf "| %40s | %15.3f MB |\n", "BASE MEMORY", BASE_MEM/1048576  
printf "+------------------------------------------+--------------------+\n"  
printf "| %40s | %15.3f MB |\n", "sort_buffer_size", VAR["sort_buffer_size"]/1048576  
printf "| %40s | %15.3f MB |\n", "read_buffer_size", VAR["read_buffer_size"]/1048576  
printf "| %40s | %15.3f MB |\n", "read_rnd_buffer_size", VAR["read_rnd_buffer_size"]/1048576  
printf "| %40s | %15.3f MB |\n", "join_buffer_size", VAR["join_buffer_size"]/1048576  
printf "| %40s | %15.3f MB |\n", "thread_stack", VAR["thread_stack"]/1048576  
printf "| %40s | %15.3f MB |\n", "binlog_cache_size", VAR["binlog_cache_size"]/1048576  
printf "| %40s | %15.3f MB |\n", "tmp_table_size", VAR["tmp_table_size"]/1048576  
printf "+------------------------------------------+--------------------+\n"  
printf "| %40s | %15.3f MB |\n", "MEMORY PER CONNECTION", MEM_PER_CONN/1048576  
printf "+------------------------------------------+--------------------+\n"  
printf "| %40s | %18d |\n", "Max_used_connections", MAX_USED_CONN  
printf "| %40s | %18d |\n", "max_connections", MAX_CONN  
printf "+------------------------------------------+--------------------+\n"  
printf "| %40s | %15.3f MB |\n", "TOTAL (MIN)", MEM_TOTAL_MIN/1048576  
printf "| %40s | %15.3f MB |\n", "TOTAL (MAX)", MEM_TOTAL_MAX/1048576  
printf "+------------------------------------------+--------------------+\n"  
}'

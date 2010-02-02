#!/usr/bin/env ruby

# This is a small program designed to discover the current
# anonymous dn password to bind to the LDAP directory.
# Obviously to search the directory you must bind as
# an account other than the ANONYMOUS_DN
#
# Author:: Michael Stahnke (mailto: stahnma@websages.com)
# Copyright:: (c) 2010 Websages
# License:: WTFPL v2.0

# The server you wish to search
LDAP_SERVER = "odin.websages.com"
# The search base of the directory
BASE = "dc=websages,dc=com"
# The DN for which you need the current PW
ANONYMOUS_DN="cn=LDAP Anonymous"
# The OU container for accounts. Used to build the bind dn.
BIND_DN_OU="ou=people"

require 'ldap'

if ENV['LDAP_USERNAME']
  ldap_username = ENV['LDAP_USERNAME'].to_s
else
  ldap_username = ENV['USER'].to_s
end
if ENV['LDAP_PASSWORD'] 
  ldap_password = ENV['LDAP_PASSWORD'].to_s
else 
 puts "Please export LDAP_PASSWORD environment variable."
 exit 1
end

dn = "uid=" + ldap_username + "," + BIND_DN_OU + "," + BASE


begin
  conn = LDAP::SSLConn.new(LDAP_SERVER, 636)
rescue LDAP::ResultError
  raise LDAP::ResultError, "Error Connecting to LDAP Server", caller
end
bound = conn.bind( dn , ldap_password)
bound.search(BASE, LDAP::LDAP_SCOPE_SUBTREE, "(#{ANONYMOUS_DN})") do | user|
  puts user['userPassword']
end

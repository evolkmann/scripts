-- From https://discussions.apple.com/thread/5182823
set SSID to do shell script "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'"

-- If part of the network name matches, the proxy will be set
set networkNameWithProxy to "<SIGNIFICANT_PART_OF_NETWORK_NAME>"

-- Network Profiles
---> See the available ones with command "scselect"
---> Create ones in Network Preferences
set networkNoProxy to "2B952999-A7D9-4192-A60D-431FE7D4763D"
set networkWithProxy to "966D4F4D-5DE5-40FA-B715-C8FAC1E32DC4"

global notificationTitle
set notificationTitle to "Network Proxy"
global notificationSubTitle

if SSID contains networkNameWithProxy then
	set notificationSubTitle to "Proxy required in network " & SSID
	do shell script "scselect " & networkWithProxy
else
	set notificationSubTitle to "No proxy required in network " & SSID
	do shell script "scselect " & networkNoProxy
end if

display notification "Applied network configuration" with title notificationTitle subtitle notificationSubTitle

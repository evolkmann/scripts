-- From https://discussions.apple.com/thread/5182823
global SSID
set SSID to do shell script "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'"

-- If part of the network name matches, the proxy will be set
global networkNameWithProxy
set networkNameWithProxy to "<SIGNIFICANT_PART_OF_NETWORK_NAME>"

-- Set your proxy URL here
global proxy
set proxy to "<YOUR_PROXY_URL>"

global notificationTitle
set notificationTitle to "Git Proxy"
global notificationSubTitle

if SSID contains networkNameWithProxy then
	set notificationSubTitle to "Proxy required in network " & SSID
	do shell script "git config --global http.proxy " & proxy
	display notification "The git proxy has been set. Ready to go!" with title notificationTitle subtitle notificationSubTitle
else
	set notificationSubTitle to "No proxy required in network " & SSID
	try
		do shell script "git config --global --unset http.proxy"
		display notification "The git proxy has been removed. Ready to go!" with title notificationTitle subtitle notificationSubTitle
	on error
		display notification "Proxy was not set. You are ready to go!" with title notificationTitle subtitle notificationSubTitle
	end try
end if

-- From https://discussions.apple.com/thread/5182823
global SSID
set SSID to do shell script "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'"

-- If part of the network name matches, the proxy will be set
global networkNameWithProxy
set networkNameWithProxy to "<SIGNIFICANT_PART_OF_NETWORK_NAME>"

-- Set your proxy URL here
global proxy
set proxy to "<YOUR_PROXY_URL>"

if SSID contains networkNameWithProxy then
	do shell script "git config --global http.proxy " & proxy
	display notification "Git proxy has been set" with title "Git Proxy"
else
	try
		do shell script "git config --global --unset http.proxy"
	end try
	display notification "Git proxy has been removed" with title "Git Proxy"
end if

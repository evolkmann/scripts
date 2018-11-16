-- Set your proxy URL here
global proxy
set proxy to "165.225.72.41:10127"

try
	-- Check if a proxy is set.
	do shell script "git config --global --get http.proxy"
	
	-- Unset the proxy.
	do shell script "git config --global --unset http.proxy"
	display notification "Git proxy has been removed" with title "Git Proxy"
on error
	-- If the command failed, it means no proxy is set.
	do shell script "git config --global http.proxy " & proxy
	display notification "Git proxy has been set" with title "Git Proxy"
end try

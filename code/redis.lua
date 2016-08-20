-- local redis = require "resty.redis"
local redis = require "redis_iresty"
local red = redis:new()
ngx.say("hello,lua, again!")
red:set_timeout(1000) 

local ok, err =red:connect("127.0.0.1", 6379);
if not ok then 
    ngx.say("failed to connect:", err)
    return 
end

local count
count, err = red:get_reused_times()
if 0 == count then
    ngx.say("not get from poll: ", err)
elseif err then 
    ngx.say("failed to get reused times:", err)
    return 
end

local key = "redis:lua:log"
ok,err = red:set(key, "is a animail")
if not ok then
    ngx.say("failed to set dog", err)
    return
end
ngx.say("set result:", ok , "<br/>")
ok,err = red:get(key)
if not ok then
    ngx.say("failed to get dog", err)
    return
end
ngx.say(key, ok, "<br/>")
local ok, err = red:set_keepalive(10000, 100)

if not ok then 
    ngx.say("failed to keep alived: ", err)
    return 
end

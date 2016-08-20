local delay = 5
local fp 
local cnt = 0
fp = function (premature)
    if premature then 
        ngx.log(ngx.ALERT, "start to premature")
        return 
    end
    if cnt < 5 then
        local ok,err = ngx.timer.at(delay, fp)
        if not ok then 
            ngx.log(ngx.ERR,  "failed to create the timer: ", err)
            return 
        end
    end
    ngx.log(ngx.ERR, "run to end", cnt)
    cnt = cnt + 1
end
local ok, err = ngx.timer.at(delay,fp)
if not ok then 
    ngx.log(ngx.ERR, "failed to create timer at start", err)
    return 
end


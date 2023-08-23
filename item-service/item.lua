-- 导入common函数库
local common = require('common')
local read_http = common.read_http
local read_redis = common.read_redis
-- 导入cjson库
local cjson = require('cjson')
-- 导入共享词典，本地缓存
local item_cache = ngx.shared.item_cache

-- 封装函数，先查询本地缓存，再查询redis，再查询http
local function read_data(key, expire, path, params)
    -- 读取本地缓存
    local val = item_cache:get(key)
    if not val then
        -- 缓存未命中，记录日志
        ngx.log(ngx.ERR, "本地缓存查询失败, key: ", key , ", 尝试redis查询")
        -- 查询redis
        val = read_redis("192.168.1.8", 6379, key)
        -- 判断redis是否命中
        if not val then
            ngx.log(ngx.ERR, "Redis缓存查询失败, key: ", key , ", 尝试http查询")
            -- Redis查询失败，查询http
            val = read_http(path, params)
        end
    end
    -- 写入本地缓存
    item_cache:set(key, val, expire)
    return val
end

local id = ngx.var[1]

local itemJSON = read_data("item:id:" .. id, 1800, "/item/" .. id, nil)
local stockJSON = read_data("item:stock:id:" .. id, 60, "/item/stock/" .. id, nil)

local item = cjson.decode(itemJSON)
local stock = cjson.decode(stockJSON)
item.stock = stock.stock
item.sold = stock.sold
itemJSON = cjson.encode(item)

ngx.say(itemJSON)


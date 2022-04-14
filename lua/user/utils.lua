_M = {}

---Try sec seconds to do pcall for user_fn function
---@param sec number
---@param user_fn function with any vararg params
---@vararg any
---@return boolean - operation status
---@return any - function result
_M.try = function (sec, user_fn, ...)
    local ct = os.time()
    local wait = sec
    local deadline = ct + wait
    local status = false
    local result = nil
    while not status and ct < deadline do
        status, result = pcall(user_fn, ...)
        ct = os.time()
    end
    return status, result
end

return _M

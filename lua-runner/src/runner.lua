local cjson = require 'cjson.safe'

local runner = {}

local function create_ok_response(data)
    return {
        result = 'ok',
        data = tostring(data)
    }
end

local function create_error_response(data)
    return {
        result = 'error',
        data = data
    }
end

function runner.run(script)
    local fn_to_run, err = loadstring(script)
    if not fn_to_run then
        return cjson.encode(create_error_response(err));
    end

    local res, data = pcall(fn_to_run)
    local response_data
    if res then
        response_data = create_ok_response(data)
    else
        response_data = create_error_response(data)
    end

    return cjson.encode(response_data)
end

return runner

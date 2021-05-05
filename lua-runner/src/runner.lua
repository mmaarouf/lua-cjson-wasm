local cjson = require 'cjson.safe'

local runner = {}

local function stringify_table(data)
    local stringified_table = tostring(data[1])
    if #data > 1 then
        for i=2,#data do
            stringified_table = stringified_table..','..tostring(data[i])
        end
    end
    return stringified_table
end

local function create_ok_response(data)
    return {
        result = 'ok',
        data = stringify_table(data)
    }
end

local function create_error_response(data)
    return {
        result = 'error',
        data = stringify_table(data)
    }
end

local function separate_first_from_rest(data)
    local first = data[1]
    local rest = {}
    for i=2,#data do
        table.insert(rest, data[i])
    end
    return first, rest
end

function runner.run(script)
    local fn_and_error = { loadstring(script) }
    local fn_to_run, err = separate_first_from_rest(fn_and_error)
    if not fn_to_run then
        return cjson.encode(create_error_response(err));
    end

    local result_and_data = { pcall(fn_to_run) }
    local result, data = separate_first_from_rest(result_and_data)
    local response_data
    if result then
        response_data = create_ok_response(data)
    else
        response_data = create_error_response(data)
    end

    return cjson.encode(response_data)
end

return runner

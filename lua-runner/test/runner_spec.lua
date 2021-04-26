local runner = require 'runner'

describe('runner', function()

    it('should return successful result of function in json', function()
        local fn_to_run = function() return 'hello' end

        local actual = runner.run(fn_to_run)

        local expected = '{"result":"ok","data":"hello"}'
        assert.equals(expected, actual)
    end)

    it('should return unseccessful result with error message when error occurs', function()
        local no_error_position_level = 0
        local fn_to_run = function() error('error message', no_error_position_level) end

        local actual = runner.run(fn_to_run)

        local expected = '{"result":"error","data":"error message"}'
        assert.equals(expected, actual)
    end)
end)

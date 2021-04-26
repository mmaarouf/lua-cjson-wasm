local runner = require 'runner'

describe('runner', function()
    it('should return successful result of function in json', function()
        local fn_to_run = function() return 'hello' end

        local actual = runner.run(fn_to_run)

        local expected = '{"result":"ok","data":"hello"}'
        assert.equals(expected, actual)
    end)
end)

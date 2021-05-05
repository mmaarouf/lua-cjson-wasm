local runner = require 'runner'

describe('runner', function()

    it('should return successful result of function in json', function()
        local script = 'return "hello"'

        local actual = runner.run(script)
        local expected = '{"result":"ok","data":"hello"}'

        assert.equals(expected, actual)
    end)

    it('should return unseccessful result with error message when error occurs', function()
        local script = 'error("error message", 0)'

        local actual = runner.run(script)
        local expected = '{"result":"error","data":"error message"}'

        assert.equals(expected, actual)
    end)

    it('should return luac error when script is malformed', function()
        local script = 'a =? "hi"'

        local actual = runner.run(script)
        local expected = '{"result":"error","data":"[string \\"a =? \\"hi\\"\\"]:1: unexpected symbol near \'?\'"}'

        assert.equals(expected, actual)
    end)

    it('should return a stringified return value', function()
        local script = 'return nil'

        local actual = runner.run(script)
        local expected = '{"result":"ok","data":"nil"}'

        assert.equals(expected, actual)
    end)

    it('should return multipe returned values in stringified form', function()
        local script = 'return "hello", "world"'

        local actual = runner.run(script)
        local expected = '{"result":"ok","data":"hello,world"}'

        assert.equals(expected, actual)
    end)

end)

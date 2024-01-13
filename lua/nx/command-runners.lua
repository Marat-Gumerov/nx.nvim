local console = require 'nx.logging'

local _M = {}

function _M.toggleterm_runner(config)
    config = config
        or {
            direction = 'float',
            count = 1,
            close_on_exit = false,
        }

    local terms = {}

    return function(command)
        if terms[command] ~= nil then
            terms[command]:toggle()
        else
            local Terminal = require('toggleterm.terminal').Terminal
            local term = Terminal:new {
                cmd = command,
                on_close = function()
                    terms[command] = nil
                end,
                config,
            }
            term:toggle()
        end
    end
end

function _M.terminal_cmd()
    return function(opts)
        local cmd = opts
        local cwd = _G.nx.nx_root
        if (type(opts) == 'table') then
            cmd = opts.cmd
            cwd = opts.cwd or cwd
        end
        console.log 'Running command:'
        console.log(cmd)
        local full = 'cd ' .. cwd .. ' && ' .. cmd
        vim.cmd('terminal ' .. full)
    end
end

return _M

local log = (require 'nx.logging').log
--
---Reloads actions and targets config
local on_project_mod = function()
	log 'On Project Mod'
	log '--------------'

	local actions = {}
	local targets = {}

	for key, proj in pairs(_G.nx.projects) do
		for name, target in pairs(proj.targets or {}) do
			if targets[name] == nil then
				targets[name] = {}
			end

			table.insert(actions, key .. ':' .. name)

			for config, _ in pairs(target.configurations or {}) do
				table.insert(actions, key .. ':' .. name .. ':' .. config)

				targets[name][config] = true
			end
		end
	end

	_G.nx.cache.actions = actions
	_G.nx.cache.targets = targets

	log(_G.nx.cache)

	log '--------------'
end

return on_project_mod

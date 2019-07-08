webHookURL = "" -- The Webhook link to post too.
local DISCORD_NAME = "Report Bot" -- Changes the name of the bot (default : Report Bot)
local DISCORD_IMAGE = "https://www.realbookies.com/wp-content/uploads/2019/03/reporting-analytics_60.png" -- Any Image URL works
local role = "" -- Must be a role id
enableReport = true -- Enable /report command

-- Note, the command has to start with `/`.
TriggerEvent('chat:addSuggestion', '/report', 'Reports A Player To Staff', {
    { name="ID", help="param description 1" },
    { name="Reason", help="param description 2" }
})

local role = "<@&"..role..">"

if enableReport then
    RegisterCommand("report", function(source, args, rawCommand)
        local user = tonumber(args[1])
        local msg = table.concat(args, " ", 2)
        local username = GetPlayerName(user)
		local reporter = GetPlayerName(source)
		print(user)
		if username == nil then
			print("Please make sure to fill in all fields")
		else
			color = 1127128
			print("The User".. username .. " Was Reported to Staff!")
			sendMessage("The User ".. username .. " Was Reported For: ","**".. msg.."**", color, reporter)
		end
    end)
end

function sendMessage(username, msg, color, reporter)
  local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. username .."**",
            ["description"] = msg,
            ["footer"] = {
            ["text"] = "Report Generated By : "..reporter.. ".",
            },
        }
    }
	PerformHttpRequest(webHookURL, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = role , embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end

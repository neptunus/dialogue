require "personalities"
require "items"

function gameState()
  local sdf = {}
  local dialogueCharacter = nil
  local inventory = {}

  function getDialogue(npc, query)
    text = nil
    d = npc.dialogues
    dialog = 1
    if d[query] then
      query = d[query]
      if query["flag"] then
        dialog = getSDF(query["flag"])
      end
      if query["setFlag"] then
        setFlag = query["setFlag"]
        setSDF(setFlag)
      end
      text = query[1][dialog]
    else
      text = d["default"][1][dialog]
    end
    return text
  end

  function checkFlags(flags)
    for k,v in pairs(flags) do
      if not getSDF(k) == v then
        return false
      end
    end
    return true
  end

  function takeItem(person, item, flags)
    if checkFlags(flags) then
      table.insert(inventory, item)
    end
  end

  function setSDF(f)
    x = f[1]
    y = f[2]
    value = f["value"]
    sdf[x][y][1] = value
  end

  function getSDF(f)
    return sdf[f][1]
  end

  function act(action)
    if action.name == "say" or action.name == nil then
      person = action.person
      text = action.text
      return getDialogue(person, text)
    elseif action.name == "take" then
      person = action.person
      item = action.item
      return takeItem(person, item)
    end
  end

  for i=1,500 do
    sdf[i] = {}
  end

  return {
    canDo = function(x, y)
      return sdf[x][y][1] == 1
    end,
    sdf = sdf,
    act = act,
    takeItem = takeItem
  }
end

-- Stuff done flags à la Blades of Exile

g = gameState()

-- SDF setup. This is the totality of the world's state, as described
-- by flags. Each flag is a table - optionally give each a description
-- to keep track of everything that can be changed.
-- sdf[x][y][1] contains the flag.

g.sdf[10][1] = {desc="main quest completed",1}
g.sdf[10][2] = {desc="Questmaster asked for name",1}
g.sdf[20][1] = {desc="Finished talking to Questmaster"}
g.sdf["amethyst_stolen"] = {desc="Amethyst stolen from Phillip", false}

npc = personalities[1]

print("You come across a stranger.\nBe advised that you may use the commands 'look', 'name', and 'chat' with anyone.")
while query ~= "" do
  query = io.read()
  if query == "travel" then
    if npc == personalities[1] then
      npc = personalities[2]
    else
      npc = personalities[1]
    end
    print(g.act({person = npc, text = "look"}))
  elseif query ~= "" then
    print(g.act({person = npc, text = query}))
  end
end

flags = { amethyst_stolen = false }

g.takeItem("nilli", "am a thist", flags)
print(items.amethyst.desc)

personalities[1].exitScript()
-- print(sdf[20][1][1])

require "gamestate"
require "personalities"
require "items"
require "inventory"


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

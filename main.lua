require "personalities"

-- Stuff done flags à la Blades of Exile
sdf = {}

for i=1,500 do
  sdf[i] = {}
end

-- SDF setup. This is the totality of the world's state, as described
-- by flags. Each flag is a table - optionally give each a description
-- to keep track of everything that can be changed.
-- sdf[x][y][1] contains the flag.

sdf[10][1] = {desc="main quest completed",1}
sdf[10][2] = {desc="Questmaster asked for name",1}
sdf[20][1] = {desc="Finished talking to Questmaster"}

npc = personalities[1]

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

function getSDF(f)
  x = f[1]
  y = f[2]
  return sdf[x][y][1]
end

function setSDF(f)
  x = f[1]
  y = f[2]
  value = f["value"]
  sdf[x][y][1] = value
end

print("You come across a stranger.\nBe advised that you may use the commands 'look', 'name', and 'chat' with anyone.")
while query ~= "" do
  query = io.read()
  if query == "travel" then
    if npc == personalities[1] then
      npc = personalities[2]
    else
      npc = personalities[1]
    end
    print(getDialogue(npc, "look"))
  elseif query ~= "" then
    print(getDialogue(npc, query))
  end
end
personalities[1].exitScript()
-- print(sdf[20][1][1])

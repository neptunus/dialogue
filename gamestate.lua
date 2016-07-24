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
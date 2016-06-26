personalities = {
  {
    name = "Questmaster",
    image = nil,
    dialogues = {
      ['look'] = {{"Before you stands a scruffy man in a brown robe."}},
      ['name'] = {flag = {10, 2}, {
        "The scruffy man looks at you from under bushy eyebrows. \"I'm the Questmaster.\"",
        "The Questmaster looks sad. \"I can't believe you've forgotten my name. This demo only has two NPCs.\"" }, setFlag = {10, 2, value=2}},
      ['chat'] = {{"\"I'm here to hand out quests. Somebody has to do it, you know.\""}},
      ['default'] = {{"The Questmaster shrugs. \"I don't know.\""}},
      ['quest'] = {flag = {10, 1}, {
        "\"Ah, yes! I have something for you. Venture to the west. You'll know what to do. (hint: type 'travel')\"",
        "\"So, you've done it. Congratulations, the game is over.\"" }
      }
    },
    exitScript = function()
      print("Goodbye")
      -- sdf[20][1] = {1}
    end
  },
  {
    name = "Bandit Leader",
    image = nil,
    dialogues = {
      ['look'] = {{"You've found the leader of the bandits. He doesn't look hostile."}},
      ['name'] = {{"\"I'm Philip. I know it doesn't sound very intimidating, but look how bad-ass this crossbow is.\""}},
      ['chat'] = {{"\"So, you've killed my men and by the looks of it, stolen my stuff. Don't worry about it. I'm not one to hold a grudge. In fact, how about we make a deal?\""}},
      ['default'] = {{"\"Are you trying to waste my time?\""}},
      ['deal'] = {{"\"Yeah. So, here's the thing. If you fight me, I'll probably die. However, I have a way of bringing this whole place down with me. Lose-lose. How about we both go, and you bring the Questmaster back this amethyst as proof of your success?\""}},
      ['attack'] = {{"You stab Philip in the gut. He keels over and dies. Nothing happens. So much for the great bandit caves of the Dead Crater. You grab his amethyst and GTFO."}, setFlag = {10, 1, value=2}},
      ['amethyst'] = {{"\"I knew you were a reasonable guy the moment I set eyes on you. I'll see you around.\" Philip tosses you the amethyst and jogs off through a side-entrance."}, setFlag = {10, 1, value=2}}
    }
  }
}

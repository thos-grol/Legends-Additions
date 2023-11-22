::Const.AI.Behavior.ID.FollowUp <- ::Const.AI.Behavior.ID.COUNT++;
::Const.AI.Behavior.Name.push("FollowUp");
::Const.AI.Behavior.Order.FollowUp <- ::Const.AI.Behavior.Order.AttackDefault;
::Const.AI.Behavior.Score.FollowUp <- 1;

::Const.AI.Behavior.ID.SpellReanimate <- ::Const.AI.Behavior.ID.COUNT++;
::Const.AI.Behavior.Name.push("Spell Reanimate");
::Const.AI.Behavior.Order.SpellReanimate <- ::Const.AI.Behavior.Order.RaiseUndead;
::Const.AI.Behavior.Score.SpellReanimate <- ::Const.AI.Behavior.Score.RaiseUndead;

::Const.AI.Behavior.ID.SpellFleshServant <- ::Const.AI.Behavior.ID.COUNT++;
::Const.AI.Behavior.Name.push("Spell Summon Flesh Servant");
::Const.AI.Behavior.Order.SpellFleshServant <- 3;
::Const.AI.Behavior.Score.SpellFleshServant <- 99999999;

::Const.AI.Behavior.ID.SpellMarkOfDecay <- ::Const.AI.Behavior.ID.COUNT++;
::Const.AI.Behavior.Name.push("Spell Mark of Decay");
::Const.AI.Behavior.Order.SpellMarkOfDecay <- ::Const.AI.Behavior.Order.SwarmOfInsects;
::Const.AI.Behavior.Score.SpellMarkOfDecay <- ::Const.AI.Behavior.Score.SwarmOfInsects;

::Const.AI.Behavior.ID.SpellCorpseExplosion <- ::Const.AI.Behavior.ID.COUNT++;
::Const.AI.Behavior.Name.push("Spell Corpse Explosion");
::Const.AI.Behavior.Order.SpellCorpseExplosion <- ::Const.AI.Behavior.Order.PossessUndead;
::Const.AI.Behavior.Score.SpellCorpseExplosion <- ::Const.AI.Behavior.Score.PossessUndead;
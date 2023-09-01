this.orc_land_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.orc_land";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 16.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_46.png[/img]{A cairn with an unusual skull atop it. Perhaps a memorial to a great orc warrior. No matter what it means to the greenskins, what it means to you is simple: you\'re in their territory now. | You come across a wooden totem with curvatures cut into it. %randombrother% believes that they are traces of the night sky, perhaps of this constellation or that.\n\n%randombrother2% spits and says all it means is that you\'re in orc territory and you\'d best pay better mind to that than what the lights in the night are doing. | You find bones in the grass. The curvature of the ribs is obscene - far too large for a man. You wonder if it is that of a donkey, but the discovery of an enormous and oddly human-shaped skull confirms your suspicions: you\'ve come onto orc territory. | Human heads on spikes. Their bodies - limbless - clumped into piles. They\'ve been cut and mutilated. The only sense of humanity they have left are the shreds of clothes barely clinging to their destroyed flesh.\n\n%randombrother% comes up, nodding.%SPEECH_ON%We\'ve stepped into some shit now. This is orc territory.%SPEECH_OFF% | You come across a man\'s body, but not his head. That\'s gone. His genitals are also gone. And his feet and hands. Javelins stick out of what\'s left, someone or something have turned what remains into gruesome target practice.\n\n Taking a close look at the weapons, %randombrother% nods and turns to you.%SPEECH_ON%Orcs, sir. We\'re in their lands now and, uh, clearly they don\'t take kindly to trespassers.%SPEECH_OFF% | You find a shattered skeleton nailed to a tree by an enormous axe. It\'s mostly just the chest cavity for the rest of it has long since fallen apart. Long, curving artwork has been carved into the tree trunk.%SPEECH_ON%This is greenskin territory.%SPEECH_OFF%%randombrother% talks as he walks up to you. He touches the handle of the axe, its weight almost as sturdy as the tree it\'s embedded in.%SPEECH_ON%I\'d say orc territory by the looks of things...%SPEECH_OFF% | You come to a stack of stones carefully placed on a small hillside. Inspecting them, you find white carvings on the rocks. Each one displays a different story - ones where large brutes wander and cause disturbing amounts of violence toward smaller, thinner stick figures. %randombrother% laughs at the drawings.%SPEECH_ON%That\'s orc fancery - what passes for such a thing, anyway. We\'re the little men in those pictures in case you were wonderin\'.%SPEECH_OFF% | A leather tarp is found flapping from some sticks on a hill. There\'s evidence of an abandoned camp around it - a smoldering fire, fleeting footprints, a few bits of odd debris. %randombrother% points at it all.%SPEECH_ON%Their smell still lingers on all this. The smell of... Orcs.%SPEECH_OFF%%randombrother2% hocks and spits.%SPEECH_ON%Ya gotta strong nose for shit, sir.%SPEECH_OFF%%randombrother% nods.%SPEECH_ON%It ain\'t bullshit, though. We\'re in orc territory, men.%SPEECH_OFF% | %randombrother% walks up to a stack of human skulls you\'ve come across. He analyzes their mortal wounds - mostly the fact that their bodies are nowhere in sight, decapitation is a hell of a thing to survive. Standing back up, he nods.%SPEECH_ON%Orcish artwork, fellas. Study it close lest you join the gallery.%SPEECH_OFF%You also nod and tell the men to be aware of the dangers ahead. | There\'s a feeling to the wilderness and there\'s a feeling to civilization - and what you got here doesn\'t fit either. You got an odd sensation as though you\'d just trespassed unto someone else\'s territory. A gruesome pile of dead bodies shorn of any humanity they once had also helps make the distinction, and settle the simple matter of fact that you have now entered orcish lands.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Be on your guard.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getPlayerRoster().getSize() < 2)
		{
			return;
		}

		local myTile = this.World.State.getPlayer().getTile();
		local settlements = this.World.EntityManager.getSettlements();

		foreach( s in settlements )
		{
			if (s.getTile().getDistanceTo(myTile) <= 10)
			{
				return;
			}
		}

		local orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getSettlements();
		local num = 0;

		foreach( s in orcs )
		{
			if (s.getTile().getDistanceTo(myTile) <= 8)
			{
				num = ++num;
			}
		}

		if (num == 0)
		{
			return;
		}

		this.m.Score = 20 * num;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});


this.dead_bodies_in_forest_event <- this.inherit("scripts/events/event", {
	m = {
		Hunter = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.dead_bodies_in_forest";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_02.png[/img] {While marching through the forest, %randombrother% calls out to the company. You look over to see him pointing somewhere beyond a line of brush. When you walk to him, you see what he sees: three bodies hanging from a tree. Their purpled faces and grey feet sway and turn, the wind sometimes forcing them to grimly face one another. %randombrother% notes that they\'re wearing wood: signs of their crimes. \'Thief,\' reads one. \'Whore\' another. \'Traitor\' the last. Having seen enough, you tell the men to get moving again. | The forest offers no relief, no little road or sidepath for you to travel down. It is thick and unrelenting and does not seem to want you there. You soon find that it did not want someone else, either: a corpse is found tied up in a thorn bush, legs crooked, arms bent, all rather finagled to to their supposed purpose. The mouth rests agape with the eyes drawn slim in some sort of final frustration. %randombrother% catches up to you, looks the body up and down, then nods.%SPEECH_ON%Body\'s clean as a whistle, aside from the thorn\'s work of course. I\'d say that man right there was so lost no animal could find him. Just died, no use to anyone or anything.%SPEECH_OFF%You point at an ant mindlessly bumbling about the dead man\'s teeth. The brother laughs and shakes his head.%SPEECH_ON%You sure he ain\'t lost too?%SPEECH_OFF% | You stare up at the forest canopy, watching what angles the lightbeams are coming in at. While getting your bearings, %randombrother% comes by looking rather distraught.%SPEECH_ON%Sir, you oughta come see this.%SPEECH_OFF%You nod and tell him to lead the way. He brings you to a clearing, though not much about it is clear.\n\nLegs. Legs everywhere. Some severed at the ankle, some at the thigh, and everywhere else in between. They\'ve no place, no order. They\'re just about, some by themselves and others all twisted up in bunches, some planted upright with sticks like they were walking jokes and a few even seem to have been thrown into the trees where they rest limply over branches or upside down by their feet. One hangs from a spit, the calf burnt black as though someone had run off, leaving it there over a fire that had long since died.\n\nThe brother that found the disgusting sight comes to stand next to you.%SPEECH_ON%No bodies, sir. Just.. legs.%SPEECH_OFF%You turn to look at the mercenary, but all he can do is shrug.%SPEECH_ON%We\'ve not found a single body, sir. I mean, the top-half, anyway. Do you think it means anything? I mean, who would do that? Remove someone\'s legs and then take off with the rest?%SPEECH_OFF%You shake your head in disbelief. Having seen enough, and having no answer for such questions, you quickly usher the rest of the men away from the clearing and get back to marching. | You stop at a creekbed to wash yourself and get something of a drink, but before you take the first sip %randombrother% grabs your shoulder. He points upriver. A woman\'s body is face down in the water, her long hair twisting rather lively to the ripples. You thank the sellsword for saving you from any disease the dead press onto the world. | The tree canopy is thick and twisting. Whatever light there is above can barely come through, braids of shadow encompassing your men as they march. But further on ahead you see a pillar of light gleaming into the forest. Naturally, someone else saw it first. And it was the last thing they saw.\n\nIn that stroke of light a boy rests with his back up against a tree. His head is aloll and his hands turned up and open. Purple smudges stain his palms. %randombrother% walks up and immediately shakes his head.%SPEECH_ON%Poison berries. Damned kid didn\'t stand a chance.%SPEECH_OFF%You turn to the battle brother and inquire if the boy might have gone peacefully. The man shakes his head again. %SPEECH_ON%No.%SPEECH_OFF% | A dead body. Rather, what should be a body. The chest is open and the viscera laid out in all directions, grey and sagging and soft. You can\'t tell if it was a man or woman, only that it had to have been an adult cut down to much smaller sizes. What creature could have done this work is beyond you, though %randombrother% suggests maybe it was the deed of a very determined man. | You find the body of a woman with its back resting against a tree. There is a knife in her chest, the wound so quickly fatal that she appears to have died while in some motion of life. Above her, another woman swings from a branch. Red are her clothes. The body\'s head tilts forward as though to stare at her crime, and the rope that hangs her there groans to a muted wind. | You come across some scene of battle. Men, armor, weapons, not a single one of them useable. The dead got that way through some sheer form of brutality you do not wish to learn. Footprints in the earth suggest something big had come through, leaving behind a wake of ruin and calamity, and no urge on your part to follow where those steps go. | Marching along, you find a dead man with a few broken arrows in his back. More puncture wounds where his killer managed to retrieve his ammunition in one piece. The man was carrying a love letter, its destination a woman that had, apparently, already been spoken for. Ah, romance.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Rest in peace.",
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
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest)
		{
			return;
		}

		local myTile = this.World.State.getPlayer().getTile();

		foreach( s in this.World.EntityManager.getSettlements() )
		{
			if (s.getTile().getDistanceTo(myTile) <= 6)
			{
				return;
			}
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
	}

});


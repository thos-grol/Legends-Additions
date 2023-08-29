this.greenskins_warnings_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.greenskins_warnings";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 3.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_49.png[/img]You walk out of your tent and see a wasteland set ablaze. What isn\'t fire, is blackened by its passing, what isn\'t dead, is screaming as the flames eat their flesh. Amidst the smog of this ruin march a stream of burly orcs, chained human slaves dragged forward at their sides, a swarm of goblins skipping around to relish in the chaos. And... %randombrother%? The mercenary pokes you and this burning world disappears in an instant. All that\'s left is the sellsword standing over you.%SPEECH_ON%Sorry to wake you, sir, but your bedding caught fire by the waning candle there. I put it out before it could do any harm. Hey, you alright?%SPEECH_OFF%Nodding, you tell the man to clear out and prepare the men for another day\'s march. You try to put the memory of the dream out of your head, but it lingers as though it were not meant to be forgotten. | [img]gfx/ui/events/event_76.png[/img]A man comes barreling out of the treeline beside the path. He\'s wearing rags and half his cheek has been ripped open, his tongue bouncing aloll and with no shape to utter more than guttural screams and desperate pleas. %randombrother% jumps back as the man tries to glom on. You draw your sword, but the stranger merely falls to the ground, his back peppered with darts, the skin the points already pulsing green with poison.\n\n The company stays alert for a time, but nothing else comes. There\'s a general agreement that this had to have been the work of greenskins, though it appears that there\'s evidence of both orcs and goblins work here... | [img]gfx/ui/events/event_97.png[/img]A young fella comes by with his dog trotting beside him. He pauses before the company, patting his little mutt on the head.%SPEECH_ON%You soldiers after the greenies? Tall ones be hard to kill, way I hear it, and the shorties are a real crafty sort.%SPEECH_OFF%You ask the man where he\'s from. He shrugs.%SPEECH_ON%Far, far away from here. I\'m a wanderer, sirs, me and m\'dog. But I\'ve seen a lot in my travels.%SPEECH_OFF%%randomname% barges forward.%SPEECH_ON%You\'re telling me you\'ve seen orcs and goblins working together?%SPEECH_OFF%The boy nods.%SPEECH_ON%Yup! Why wouldn\'t they? Heh, well, you\'re not who I thought you were. May your days be long, your nights short, and your dreams as long as want.%SPEECH_OFF%He steps through some standing brush. You give chase, but when you break through to the other side the boy and dog are both gone. | [img]gfx/ui/events/event_94.png[/img]You heard the flies before seeing the chaos upon which they beset. A small hovel, simply shaped wooden supports, a nice thatched roof, some pots hanging from strings, a dreamcatcher spinning in the wind, wooden chimes to bring some delight to the air, and three mutilated bodies in the grass, a cloud of bugs swarming on the corpses. %randombrother% crouches before one, prodding at some bones sticking out of the gore.%SPEECH_ON%Must\'ve been orcs. Footsteps there certainly make it seem so.%SPEECH_OFF%You nod, but notice that there\'s a few darts stuck to the hovel\'s door. You pick one off and smell it.%SPEECH_ON%Poison. More than just orcs were here.%SPEECH_OFF%%randombrother% sniffs one of the darts and nods.%SPEECH_ON%Aye, orcs and goblins. Working together? I sure as hell hope not.%SPEECH_OFF%It would be a disaster if they were, but for now you\'ll just sit happy in the idea that all the evidence here is merely coincidental. | [img]gfx/ui/events/event_02.png[/img]You look at your map then look at the scene before you.%SPEECH_ON%A hamlet was supposed to be here.%SPEECH_OFF%%randombrother% walks past, chowing down on an apple with a satisfying crunch.%SPEECH_ON%Mmhmm, might wanna pen in some edits then, sir.%SPEECH_OFF%The village is nothing but ash. Its inhabitants are hanging from wooden posts or any tree still standing. Bones of those not hanged are piled in the middle of what was probably the town square. Staring at the ground, you see footprints leading away from the carnage. Small ones, big ones. Goblins, orcs. %randombrother% shakes his head.%SPEECH_ON%Surely they are not working together, right?%SPEECH_OFF%You shrug and answer.%SPEECH_ON%I\'m sure the orcs swept through and then the goblins came and picked the remains, or possibly the other way around.%SPEECH_OFF%The sellsword nods, assured by your explanation though you both know deep down that the collection of tracks are most likely not a coincidence. | [img]gfx/ui/events/event_97.png[/img]You come across a kid squatting beside a creekbed. He\'s using a stick to draw figures in the mud - little stick-men with great horned helms and little \'uns beside them, though even the smaller figures appear well-armed and armored. %randombrother% asks the runt what exactly he\'s doing.%SPEECH_ON%Drawin\' the greenies. Been seeing them a lot, skittering and scattering the hills they are, like rats in an open pantry my pa says.%SPEECH_OFF%You ask where he lives. He points up the wooded slopes of a nearby hill.%SPEECH_ON%Yonder. Got a good view of what\'s coming. S\'pose you will in time, too.%SPEECH_OFF%An old man yells out for the kid and he obeys, dropping his tools of atavistic artistry and heading for the hill.%SPEECH_ON%I gots\'ta work. You fellas have fun! And don\'t step on m\'drawings!%SPEECH_OFF%Now you realize the stick figures are orcs and goblins, but maybe the kid is just playing fantasy. | [img]gfx/ui/events/event_36.png[/img]You find a fella beside the road cradling his arms in his chest. Both the hands appear to be missing. He stares up at you and the momentum carries him backward, the poor man falling flat and staring up at the skies, pawing at it with nubby forearms.%SPEECH_ON%They\'re working together. Killed... Killed everyone. I couldn\'t believe the sight of it. I always said if they came, I\'d be prepared, for one or the other. But there they were. Together.%SPEECH_OFF%You ask who or what he\'s talking about. The man\'s chest seizes up, pain crookedly crawls across his face, and he takes his last breath. A reflected sky arcs in the glisten of his opened eyes, all to see in death\'s blindness. %randombrother% checks the body, but there\'s nothing to take. | [img]gfx/ui/events/event_95.png[/img]A totem of skulls, leathered skins flapping off the segments, each head wearing a cape quite gruesomely of their own making. Blood speckles and fills the ground. More bones. Muscles and tendons, things unused or uneaten. Scorched earth where a campfire grew and scattered ash where it died. %randombrother% picks around the scene, looking for clues. He holds up the shaft of a crude weapon, and a couple of darts found in a goatskin bag.%SPEECH_ON%This is too big for a man\'s hand, and these are clearly gobbo arrows tipped with, hmm, yes, poison. Greenskins no doubt came through here and they did so working together.%SPEECH_OFF%Working together? That\'s a horrible thought, but it does appear to be true. Are the savage tribes up to something? | [img]gfx/ui/events/event_71.png[/img]You come to the burnt remains of a hovel. There are skeletons about the rubble, bones jagged and clambering in what was final, painful desperations. A lock lays in a pile of ash beside what should have been the door, suggesting the people held up inside, while the outsiders simply burned the place down.%SPEECH_ON%Sir, you should see this.%SPEECH_OFF%%randombrother% beckons you over. He\'s standing before a tree. There\'s a dead goblin leaning against the trunk, palms out, empty, an ugly look on its face, and a pitchfork in its chest. A dead orc is beside it with a shovelhead sticking out of its skull. %randombrother% wonders if they killed each other. You hope so, but their mortal wounds look a lot like a human\'s doing, and if it were a human\'s doing, it\'s possible these greenskins were working together. The thought frightens you deeply. | [img]gfx/ui/events/event_59.png[/img]Refugees on the road, a stream of them, women with babes swaddled and roped behind their backs and affront their bellies, men with pitchforks for walking sticks, discalced friars cutting religious rites through the air with their fingers and breathing prayers under their breath. You try and talk, but they shrink from you, wide-eyed. Finally, an elderly speaks to you quietly.%SPEECH_ON%Don\'t try, sir, they\'ve seen too much. The greenskins... they came in the night. Orcs in the village, goblins outside it waiting to ambush all that ran. The militia was massacred. Only us cowardly folk survived, and even then only the fastest among us.%SPEECH_OFF%You ask the man if he just said goblins and orcs were working together. He nods and pats you on the shoulder.%SPEECH_ON%Aye, I did. Safe travels, stranger.%SPEECH_OFF% | [img]gfx/ui/events/event_76.png[/img]A man dressed for pomp and pleasure is standing beside the road. He\'s staring ahead, his hands out to his side, perhaps to balance out a little too much drink in the system. You grab and wheel the man around. His face rocks forward, eye sockets emptied, tendrils of his sight hanging down to his cheeks like rotten crawfish. Two handless arms slap your shoulders as he tries to grip you. His face contorts into a guttural scream that reflects the barbarities he\'s come to experience.\n\n %randombrother% quickly jumps to action and cuts the man down. The stranger falls backward, his fine mink coat opening up to show a brutalized naked body, and now you realize you\'d rather see a man\'s parts than see them missing. As he hits the ground, his mutilations are his undoing, the cuts and slices opening his flesh up like a puzzle come apart. His organs burst through the gaps, unfurling in purpled ropes and bags. The man screams.%SPEECH_ON%Orcs! Goblins! Orcs! Goblins! Orcs! Gob... goblins...%SPEECH_OFF%His breath leaves him. He\'s dead, thank the old gods. Is there something to make of his final words?}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That\'s concerning...",
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
		if (this.World.FactionManager.getGreaterEvilType() == this.Const.World.GreaterEvilType.Greenskins && this.World.FactionManager.getGreaterEvilPhase() == this.Const.World.GreaterEvilPhase.Warning)
		{
			local playerTile = this.World.State.getPlayer().getTile();

			if (!playerTile.HasRoad)
			{
				return;
			}

			if (this.Const.DLC.Desert && playerTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.2)
			{
				return;
			}

			local towns = this.World.EntityManager.getSettlements();

			foreach( t in towns )
			{
				if (t.getTile().getDistanceTo(playerTile) <= 4)
				{
					return;
				}
			}

			this.m.Score = 80;
		}
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


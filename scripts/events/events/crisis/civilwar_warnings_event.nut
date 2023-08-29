this.civilwar_warnings_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_warnings";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 3.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_76.png[/img]You come across a stranger in the path. He regards you with a steely gaze, a troop of sheep and dogs idling at his side.%SPEECH_ON%Mmm, don\'t suppose yer gearing up to fight for %noblehouse% are ya? I hear it and the other families of the realm are quarreling. Don\'t know what about. Just know they\'ll come by my place and ask, \'%randomname%, why don\'tchu come and fight for us, or else we hang ya\', and I\'ll say \'okay\', because a buncha gold-britches nobleman ruining my year is a part of life, and life just ain\'t fair.%SPEECH_OFF% | [img]gfx/ui/events/event_91.png[/img]A woman in the road stands by the company\'s wayside as you march past. She looks your sigil up and down.%SPEECH_ON%Hmph, don\'t recognize that one. S\'pose the nobles will be calling for your services soon.%SPEECH_OFF%You ask what she means. She shrugs.%SPEECH_ON%Way I hears it, the pompy pissants be mad about a royal marriage gone awry. Lotta noise coming about how it means war or some such shite. They noblefolk always squabbling over something, only a matter of time \'til they cross swords with one another, or ask us poorfolk to do it for them.%SPEECH_OFF% | [img]gfx/ui/events/event_17.png[/img]An old man sitting and smoking a pipe regards your company with a long, hazy stare.%SPEECH_ON%Mercenaries, eh? There will be a lotta good work for you in the coming days.%SPEECH_OFF%You ask what he means. He cleans the pipe, clattering it against his cheer.%SPEECH_ON%Ohh, you know. The feather-wearin\' noblefolk are peacockin\' again. War\'s coming, no doubt about it - can\'t let all this good weather go to waste.%SPEECH_OFF% | [img]gfx/ui/events/event_75.png[/img]A messenger comes by the path, his pannier swinging empty.%SPEECH_ON%Ah, I\'m all out of news, but I got some rumors if yer interested.%SPEECH_OFF%You nod. He smiles.%SPEECH_ON%Figured as much. Now, sometimes the noblefolk call me up to give me papers to send out. Sometimes little ol\' me eavesdrops on their conversations. And what I hear is a lot of army talk, lotta \'we gotta conquer them sumbitches\' sorta talk. So, sellsword, you should be expecting some good business real soon.%SPEECH_OFF% | [img]gfx/ui/events/event_97.png[/img]%SPEECH_ON%Psst. Psst! Hey!%SPEECH_OFF%You turn around to see a boy poking his head out of a bush. He smiles at you.%SPEECH_ON%Hey, I got something to say. There\'s a war a comin\'.%SPEECH_OFF%Believing this snarky little runt isn\'t high on your to do list. You ask how he knows that. He smiles again.%SPEECH_ON%I fetch water for a man who wears silk britches. He said, \'I can give ye some sweets, or give ye something to think about.\' I said tell me something good. He said, \'the nobility are gonna fight one another.\' So that\'s what I\'m telling ya.%SPEECH_OFF%The kid pauses.%SPEECH_ON%Say, ya wouldn\'t happen to have any sweets, would ya? Hey... hey!%SPEECH_OFF%You push the kid\'s head back into the bushes. | [img]gfx/ui/events/event_75.png[/img]An old man and a fair-skinned maiden meets you on the road. She\'s twisting a braid of hair over a shoulder, glancing at a couple of your better looking men with plying eyes. Before you get a word out, she asks if you\'re going to fight for %noblehouse% or %noblehouse2%.%SPEECH_ON%They say a prince ran off with a princess, said it t\'was a matter of love. Isn\'t that dreamy?%SPEECH_OFF%You shrug. The elderly man hocks and spits.%SPEECH_ON%Don\'t bother the sellswords with your fantasies, woman. Sorry, mercenary, she gets these ideas in her head and I don\'t know where from. The houses are talking of war, but it sure as shite ain\'t over a prancing prince or some punter of a princess. Economics! That\'s the issue. Long standing trade agreements are falling apart just like the paper they was written upon. Let me tell you, I was there when they...%SPEECH_OFF%The old fart dawdles on. You much preferred the lady\'s story, as ludicrous as it sounded. | [img]gfx/ui/events/event_75.png[/img]You come across a man sitting atop a signpost. He\'s tightening strings on a lute and testing the sounds.%SPEECH_ON%Mmhmm, that was better, wouldn\'t you agree? Just agree.%SPEECH_OFF%Nodding, you ask the man what he is doing. He jumps off the signpost and lands arms and legs out like a jester at the end of his act.%SPEECH_ON%Practicing! War is comin\', heard on the winds m\'self, and with war comes a need for... for... for... c\'mon, you can do it, entertainment! That\'s right! And in any call for nightly pleasures is a call for me - and in more ways than one, let me tell ya.%SPEECH_OFF%He pirouettes and grins. You\'ve never seen a man with a whiter smile and you have a strong urge to blacken it dearly. The minstrel prances down the path.%SPEECH_ON%Don\'t you worry, sellsword, with the nobles fighting amongst themselves there shall never be a shortage of work for men of your, er, talents. G\'day!%SPEECH_OFF% | [img]gfx/ui/events/event_16.png[/img]More and more, you\'re coming across peasants and merchants murmuring about a war between the noble houses. Your station as a sellsword has them asking you which side you are planning to carry your banner for. If these rumors are true, then the %companyname% stands to make a great deal of coin out of the misery wrought between pompous highborn. | [img]gfx/ui/events/event_45.png[/img]You come across a number of gamblers on the road. They\'ve positioned little flags representing all the noble families of the land. The bookie is writing down notes and looks over his scroll.%SPEECH_ON%Now remember, the results of this war between houses isn\'t going to be obvious for some time. Hell, I most of ye will be conscripted. But all who survive shall return to me in one year\'s time. From there, we will pay out the monies to those who bet on the winning noble house. Deal?%SPEECH_OFF%Crooked faced and slackjawed peasants shrug.%SPEECH_ON%Sounds like a deal to me!%SPEECH_OFF%The bookie grins, a golden incisor glinting ever so slightly.%SPEECH_ON%Great!%SPEECH_OFF%He takes the bets in a satchel and loads up for the road, most likely to never return again. Truly a shame what sorta nonsense the lowborn get themselves into. | [img]gfx/ui/events/event_75.png[/img]During your travels, you keep hearing a particularly interesting rumor: that the noble houses are positioning for war. If true, the %companyname% could stand to make a lot of coin, particularly if it chooses a winning side. | [img]gfx/ui/events/event_23.png[/img]Peasant after peasant is telling the same story lately. In fact, they seem to be repeating it every time you meet them...\n\n War. War is on their lips. The noble houses are squabbling over something you could care less about, but what it means is war, and war means crowns for a sellsword, and crowns are good, so war is good. Should these rumors be true, the %companyname% should measure its options carefully and choose a noblehouse to support in the conflict to come. | [img]gfx/ui/events/event_80.png[/img]You\'ve noticed recruiters for the noble houses are afoot, pulling young, fresh men out of their homes. Conscription isn\'t unordinary, but typically you still need the fellas to farm the fields. If the highborn are leaving that to the womenfolk, then it means something else is of greater import, and that something else is undoubtedly a brewing war. The %companyname% should prepare itself for the worst - well, the worst for everyone else. A war between rich arseholes is the greatest time to be a sellsword!}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Good to know.",
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
		if (this.World.FactionManager.getGreaterEvilType() == this.Const.World.GreaterEvilType.CivilWar && this.World.FactionManager.getGreaterEvilPhase() == this.Const.World.GreaterEvilPhase.Warning)
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
				if (t.isSouthern())
				{
					continue;
				}

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
		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		_vars.push([
			"noblehouse",
			nobles[0].getName()
		]);
		_vars.push([
			"noblehouse1",
			nobles[0].getName()
		]);
		_vars.push([
			"noblehouse2",
			nobles[1].getName()
		]);
	}

	function onClear()
	{
	}

});


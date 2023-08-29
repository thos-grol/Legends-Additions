this.anatomist_vs_clubfooted_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Clubfooted = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_vs_clubfooted";
		this.m.Title = "During camp...";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{You find %anatomist% the anatomist staring at %clubfoot%\'s awkward footing situation: namely that one of his feet looks like a bag of hammers. It is a disgusting, unsightly thing, and of course makes it difficult for him to perform the full duties expected of a sellsword. Word is that it is strangely popular with the womenfolk, but this is unconfirmed hearsay. Whatever the case, the anatomist comes to you with a suggestion.%SPEECH_ON%It\'s actually not at all rare malady, this man\'s clubfoot. At young age it is easily fixed, but the operation becomes steadily more difficult to amend the older one grows. Thankfully, I am a trained anatomist who has great depths of knowledge on this very subject. If you will let me, I shall attempt to heal this man of his unfortunate and unnecessarily lifelong circumstance.%SPEECH_OFF%%clubfoot% himself nods, saying he\'s ready to give it a whirl if you think it\'s best.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Do it, work your trade.",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				},
				{
					Text = "No, the risk is too great.",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Clubfooted.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]{You give %anatomist% the go-ahead. Him and the clubfooted man walk-and-hobble off to handle the business. Naturally, you go to have a look. You watch as %anatomist% brings %clubfoot%\'s foot up on a stool. He takes a piece of wood out that already has teeth marks augured into it. He then takes out a vial of liquid, pops the cork, lathers the wood in it, takes a drink of it himself, and then hands the rest to his patient. %clubfoot% chugs the drink, then bites down on the wood. What follows is a disgusting series of leg breaks and castings and re-castings. %anatomist% starts cutting in with a scalpel, grinning madly as he works. %clubfoot% has long since passed out.\n\nWhen it\'s all said and done, %clubfoot%\'s leg is totally wrecked and casted up. %anatomist% says the operation was a success, though there will be a somewhat lengthy recovery time that will be necessary. The foot will have to be re-casted again and again, and each time moving the foot a little more, but it can be done. A delirious %clubfoot% is smiling as he looks down at his foot.%SPEECH_ON%It will be worth it, captain. For me, and also for the %companyname%.%SPEECH_OFF%The rather dutiful and drugged up mercenary then falls backwards and into a snoring sleep.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Walk walk, brother, it\'s your life.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Clubfooted.getSkills().removeByID("trait.clubfooted");
				this.List.push({
					id = 10,
					icon = "ui/traits/trait_icon_23.png",
					text = _event.m.Clubfooted.getName() + " is no longer Clubfooted"
				});
				local injury = _event.m.Clubfooted.addInjury([
					{
						ID = "injury.broken_leg",
						Threshold = 0.0,
						Script = "injury/broken_leg_injury"
					}
				]);
				this.List.push({
					id = 11,
					icon = injury.getIcon(),
					text = _event.m.Clubfooted.getName() + " suffers " + injury.getNameOnly()
				});
				injury = _event.m.Clubfooted.addInjury([
					{
						ID = "injury.cut_achilles_tendon",
						Threshold = 0.0,
						Script = "injury/cut_achilles_tendon_injury"
					}
				]);
				this.List.push({
					id = 12,
					icon = injury.getIcon(),
					text = _event.m.Clubfooted.getName() + " suffers " + injury.getNameOnly()
				});
				_event.m.Clubfooted.improveMood(1.0, "Had his clubfoot cured");
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Clubfooted.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]{Reluctantly, you give the go-ahead for %anatomist% the anatomist to get to work. You consider joining him and %clubfoot% in the tent, but something about breaking a foot to heal it doesn\'t...stand right with you. Instead, you go to your favorite task of counting inventory. The peace and quiet of noting down how much you have of what, how much you\'ll need, the rate at which the company is chewing through these items. It is all fascinating.\n\nThere really isn\'t anything like counting inventory, and the only thing that could stop your enjoyment is the shrill, horrific screams of %clubfoot% suddenly emanating from the tent you diligently avoided going into. Now, with his shrill cries filling the air, you run to the tent and enter it. You find %anatomist% off to the side wiping sweat from his brow.%SPEECH_ON%Hello captain. Well, let me summarize here. As you can see, there have been some unforeseen complications. He will heal from them, of course, don\'t you worry about that, but the clubfoot shall remain. It proved, eh, resistant to my applications.%SPEECH_OFF%You look at %clubfoot%. He is now passed out, and beneath the kneecaps his leg is twisted up like a rag. The anatomist nods dutifully.%SPEECH_ON%Don\'t worry about that, I\'ll get that fixed, too. Just needed for the man to stop screaming and moving around so much and a little bit of a breather so I can catch my breath. Do you wish to watch?%SPEECH_OFF%The anatomist grabs the man\'s foot. It flops around in his grasp as though he was holding dough. You shake your head and hurry from the tent.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Aaaaahh.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local injury = _event.m.Clubfooted.addInjury([
					{
						ID = "injury.broken_leg",
						Threshold = 0.0,
						Script = "injury/broken_leg_injury"
					}
				]);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Clubfooted.getName() + " suffers " + injury.getNameOnly()
				});
				injury = _event.m.Clubfooted.addInjury([
					{
						ID = "injury.traumatized",
						Threshold = 0.0,
						Script = "injury_permanent/traumatized_injury"
					}
				]);
				this.List.push({
					id = 11,
					icon = injury.getIcon(),
					text = _event.m.Clubfooted.getName() + " suffers " + injury.getNameOnly()
				});
				_event.m.Clubfooted.worsenMood(this.Const.MoodChange.PermanentInjury, "Experimented on by a madman");
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Clubfooted.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_05.png[/img]{You look at %anatomist% inquisitively.%SPEECH_ON%Am I running a horse racing outfit here? If the man wants his busted foot to get fixed, he can go out to pasture with honor and dignity. We won\'t be needing bizarre experiments that\'ll end up with the old gods know what results.%SPEECH_OFF%The anatomist clears his throat and says that the procedures are fairly simple, but he slips up in also saying that the scientific gains to be made from completing them are immense, showing that he did not have %clubfoot%\'s interests in mind at all. You tell the man the conversation is over.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Hobble along now.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.worsenMood(1.0, "Was denied a research opportunity");

				if (_event.m.Anatomist.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.anatomists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomistCandidates = [];
		local clubfootedCandidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomistCandidates.push(bro);
			}
			else if (bro.getBackground().getID() != "background.anatomist" && bro.getSkills().hasSkill("trait.clubfooted"))
			{
				clubfootedCandidates.push(bro);
			}
		}

		if (clubfootedCandidates.len() == 0 || anatomistCandidates.len() == 0)
		{
			return;
		}

		this.m.Clubfooted = clubfootedCandidates[this.Math.rand(0, clubfootedCandidates.len() - 1)];
		this.m.Anatomist = anatomistCandidates[this.Math.rand(0, anatomistCandidates.len() - 1)];
		this.m.Score = 5 * clubfootedCandidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getNameOnly()
		]);
		_vars.push([
			"clubfoot",
			this.m.Clubfooted.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Clubfooted = null;
	}

});


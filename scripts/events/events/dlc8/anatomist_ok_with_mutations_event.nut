this.anatomist_ok_with_mutations_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_ok_with_mutations";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_05.png[/img]{After spending some time with his new malformed shapes, %anatomist% has come to accept who he is now. He sees these horrific scars and ever growing pustules as evidence that he is on the right path. In some way, he is right. These strange changes have made him a far superior fighter than he was before, which is saying a lot for you personally had no hope that these foolish eggheads ever had a shot of becoming even competent fighters at best. Whatever fears and worries he had prior are now gone entirely, replaced by a renewed sense of purpose and desire to do more. | %anatomist% has stopped moping around worrying about his scars and horrible appearance. It seems he has made peace with how he looks now, or possibly he has simply become so ingratiated with the godawful smell emanating from every part of him that he no longer notices. While his stink brings you to nearly vomit every time you\'re near him, at the very least he has recovered from the dourness which was occupying his every waking minute. Maybe now he can continue on his righteous path to scientific discovery, or however else he put it. | It is hard to come to terms with who you are and, despite the superficiality, it is even more difficult to make peace with how you look. This is even more true when how you look was not the manner in which you were born, but shaped by the actions you took in life. If your own decisions brought you to this newfound state, you have only your own choices to dwell upon for the rest of your life. You\'ve seen it many a time, particularly with sellswords who lose their ears, noses, lips, and worse. It can take a long time for a man to come to peace with his newformed circumstances, and %anatomist% was no different. But come to peace he has. Whatever horrific scars and mutations he has suffered from his own actions are no more - at least mentally. He has moved on and is ready to continue his path in this world as someone seeking scientific endeavors, and the great risks to himself that those endeavors might one day pose. | %anatomist% has come to terms with his new appearances. At first, his body\'s reactions to the potions and concoctions he\'s been imbibing were so disturbing that he reeled into a shell of his former self. You could hardly blame him, for he did and does look quite hideous. But after a while, you simply realize that life goes on, and if nothing can be done about it then nothing can be done about it. And, at the very least, the real purpose of the choices made were to satisfy scientific inquiries, and it seems re-realizing that has revivified %anatomist%\'s sense of purpose. He is still ungainly and disgusting and you have a hard time looking at him, but least he\'s happier now. | Once wounded by maladies and disfigurements, %anatomist% the anatomist is starting to look a lot better now. That is to say, he has come to realize that there is little he can do about his physical appearance which is, to be terse, still something that takes courage and willpower to just look at. But the man has remembered the true reason he sought the concoctions and strange mixtures and tinctures which have turned him into a walking and talking monstrosity, and that reason is a matter of scientific endeavor. The anatomist is now a happier man and as long as he can be kept far away from even the smallest of mirrors you imagine that can more or less remain the case. | %anatomist%\'s habit of sucking down any every potion he concocts did eventually come to bite him in the ass. His last imbibement when horribly wrong, turning his face into fleshy dough, and arising across his skin all manner of bumps and bruises and pustules and pusses. Naturally, these changes had a deep morale impact on the man. But, finally, he has gotten over it. He is still a walking, talking monstrosity in every sense of the word, but on the inside he is at peace with it, and what\'s on the inside is what counts. Or at least it better count, because what\'s on the outside you can barely muster the courage to look at. | %anatomist% the anatomist calls the changes to his body \'mutations\', which must be some sort of egghead word for looking like shite. For a while, his appearance was a drag on his day to day life. You can hardly blame him, he inflicted these maladies upon himself which is always far worse than when the world does it to you and leaves little doubt as to how you could have unfarked yourself. Thankfully, the anatomist has gotten over his depression and angst about his horrendous appearance. He might even be more willing than ever to keep imbibing his potions and concoctions. Surely he can\'t look much worse than he already does and at a certain point of looking completely hideous even the ladyfolk take a turn, like seeing a dog so mangy and decrepit that one can\'t help but pet it out of curiosity. | After he drank a number of questionable potions, %anatomist% the anatomist\'s body began to change and, like any grown man, change at that age is rarely a good thing. His face became disfigured, his body mottled with sores and scars. For a time, the anatomist fell into a deep depression over the matter and you wondered if he had been irreversibly damaged not just on the outside, but the inside as well. Thankfully, it is the morale of a man that can be the hardest to break. %anatomist% has come to terms with his new appearance. It\'s not as though there is much he can do about it, and he now sees it as a sort of fundamental rite by fire that he is the way he is, and that he has helped pursue the scientific endeavors which brought him to these lands in the first place. You yourself just have to make sure that he\'s not the first thing you see in the morning.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Glad you\'re feeling better, %anatomist%.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.improveMood(1.0, "Has come to terms with his mutations");

				if (_event.m.Anatomist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				_event.m.Anatomist.getFlags().add("isOkWithMutations");
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

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist" && bro.getFlags().has("gotUpsetAtMutations") && !bro.getFlags().has("isOkWithMutations"))
			{
				anatomistCandidates.push(bro);
			}
		}

		if (anatomistCandidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomistCandidates[this.Math.rand(0, anatomistCandidates.len() - 1)];
		this.m.Score = 10 * anatomistCandidates.len();
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
	}

	function onClear()
	{
		this.m.Anatomist = null;
	}

});


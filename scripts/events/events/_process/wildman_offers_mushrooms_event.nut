this.wildman_offers_mushrooms_event <- this.inherit("scripts/events/event", {
	m = {
		Wildman = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.wildman_offers_mushrooms";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_25.png[/img]You take a rest at the base of an enormous tree. Somehow, the sun manages to sear a path through the forest canopy and blind your eyes. Getting up to move, you run into %wildman% the wildling, who is offering you a handful of various questionables: mushrooms, flower petals, berries. With a grunt, they are ushered toward your face.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Sure, %wildman%, I\'ll take some of those.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "Umm, no thanks.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_25.png[/img]Surprisingly, the bits of forest foods are actually quite good. Sweet, but not too sweet, and with a hint of oak. You thank teh weeldlung fore the gift, who rises hyyy into the skies, the skies of all things, shaking what are noww braanches you had earlier mistakenly assumed were human arms of humane purposes. Cats rain from his mouth as he speaks. Their tongue is a leenguage of marbled letters, floating before those lips innn.. innn... in great sighs for sentences. Feeling good about their graces, you give a weave, a wave of yer hand, but find yer fingers are also hands, something you had not noticed in the befores. A shock to your beliefs, yer memories of childhood flooded with fleeting feet rocking yer crib, yer domain, yer castle. All lies. All of it! Blackness comes. The darkness smiles.\n\nYou awake on the ground, %otherguy% gently dabbing a rag of water over your forehead.%SPEECH_ON%Boss is back! You alright?%SPEECH_OFF%You can\'t quite remember what happened, but your mind is desperately telling you not to ask. You simply nod in response and get the company back to marching.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I\'ve learned something today.",
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
		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_wildman = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.wildman" || bro.getBackground().getID() == "background.wildwoman")
			{
				candidates_wildman.push(bro);
			}
			else
			{
				candidates_other.push(bro);
			}
		}

		if (candidates_wildman.len() == 0)
		{
			return;
		}

		if (candidates_other.len() == 0)
		{
			return;
		}

		this.m.Wildman = candidates_wildman[this.Math.rand(0, candidates_wildman.len() - 1)];
		this.m.OtherGuy = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = candidates_wildman.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"wildman",
			this.m.Wildman.getNameOnly()
		]);
		_vars.push([
			"otherguy",
			this.m.OtherGuy.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Wildman = null;
		this.m.OtherGuy = null;
	}

});


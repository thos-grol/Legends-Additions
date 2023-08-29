this.undead_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.undead_intro";
		this.m.Title = "During camp...";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_84.png[/img]You put your head down for a nap.\n\n The silky bedsheet slides off your body as you roll to a side. Birds flutter past a sleek, ivory-framed window. A voice pours into your ear, a hint of an aroma you\'ve never smelled before gracing you.%SPEECH_ON%You\'re awake.%SPEECH_OFF%A woman rolls herself over, running a finger down your chest before going back up and seizing your chin. Lithe, pretty, the sun glowing across her smooth face, and lighting up a set of emerald eyes. She goes for a kiss. You quickly slide out of the bed and frantically look around. She grips the sheets and comes to her knees, confused.%SPEECH_ON%What\'s wrong? Where are you going my Emperor?%SPEECH_OFF%Looking up, you see a ceiling that stretches so far up you can hardly even see the artwork which has been exquisitely embroidered there. You open a door and step out onto a balcony. Impossibly tall buildings, red, white, gold banners, a horizon steepled with black shapes stretching as far as the eye wishes to see. Domes, fountains, great arches, statues that stand so tall they seem to be commanding the structures as soldiers. Atop each roof is a garden greater and more flush than anything you\'ve seen in the eternal springs of nature itself. Suddenly, two men emerges at your sides with cages of doves and let them out. The birds desperately scatter and just then a roar erupts beneath you. Great crowds of people jumping and waving banners around.%SPEECH_ON%They love their Emperor.%SPEECH_OFF%The woman speaks from the doorway.%SPEECH_ON%Go to them.%SPEECH_OFF%You look down to see a stream of soldiers marching down the middle of the road, each man stepping in unison with his brother, a steady staccato clap of boots. Their faces stern in their gilded helms, long polearms glistening upward as though they meant to defeat their enemies with opulence itself.%SPEECH_ON%They\'re going off to war. To face the Great Beyond, and to defeat it.%SPEECH_OFF%The woman is at your side. She smiles warmly, taking you by the arm. You feel ready to agree to it, to this new reality, whatever it be. You take her by the cheek, ready to fall into her embrace, but a cry from below wails loud and clear over all else. You glance down to see the soldiers, once joined in perfect uniformity, breaking rank. In the distance, a great mountain is erupting, jetting great bursts of red fire and an enormous cloud of hot ash which quickly pools into the city. Buildings disintegrate, gardens burst into flames, and the people... the people scream. They turn away, but there is no escaping the heat. The soldiers collapse and scream. A surging, searing heat, and soon enough you see the denizens melting in it, the soldiers becoming metal golems, singed into the very armor which was meant to protect them, and the unarmored crowds simply burst aflame. The woman cries at your side.%SPEECH_ON%Oh, it is horrible! Horrible! Would you look at it? But it\'s okay, understand? It\'s perfectly okay. Look at me. Look at me!%SPEECH_OFF%The woman grabs you and spins you. Her once soft features have hardened into blackened flakes, the top of her head already burnt bald, her teeth falling out of dripping gums. Yet she\'s grinning.%SPEECH_ON%We\'ll rise again, Emperor! We... shall... rise... again!%SPEECH_OFF%Her skull breaks apart and her body collapses into a pile of burning bones.\n\n You jerk awake to find %randombrother% shaking you.%SPEECH_ON%Sir, wakeup! We\'ve got a group of refugees here saying that the dead are rising from the earth and killing everything in sight!%SPEECH_OFF%The woman\'s face flashes before your eyes. It is horrifically scarred, but this doesn\'t stop her from grinning.%SPEECH_ON%The Empire rises.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "War is upon us.",
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
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.Statistics.hasNews("crisis_undead_start"))
		{
			this.m.Score = 6000;
		}
	}

	function onPrepare()
	{
		this.World.Statistics.popNews("crisis_undead_start");
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});


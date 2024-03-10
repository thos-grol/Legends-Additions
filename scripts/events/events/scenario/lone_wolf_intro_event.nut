this.lone_wolf_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.lone_wolf_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_137.png[/img]{You walk the stands of a jousting arena. Moldy fruits and vegetables litter the floor. Dried blood freckles the seats. And silence fills the air. When you sit, the wood of the place seems to groan in unison as though discomfited by the haunt of a rare visitor.\n\nIn your hands is a note. \'Looking fer hardy men, knowledge of the sword pref\'rred but all welcome.\' It is an old note, its purpose long since served. But what draws your eye is the price offered to the task: more crowns than you could muster in five tournaments.\n\n If this is the coin to be earned, then to hell with the jousts and the sparring. But you\'re not one to suit up for some other captain\'s orders. With all that you\'ve earned over the years you imagine you could start your own mercenary band just fine.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "And that\'s what I\'ll do.",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_62.png[/img]{It occurs to you that before you embark on this journey of self discovery, you should probably arm yourself a little better - a lance is pointless without a horse. Your armour is old and you can trade it in for a fair price in exchange for a new set\n\n Visiting the local weaponsmith you spot an array of killing instruments, each carefully dressed and arranged like a breadmaker\'s stall. You only have enough crowns for one set, so you better choose wisely.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A longsword has never failed me.",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "A strong hammer can smash anything.",
					function getResult( _event )
					{
						return "D";
					}

				},
				// {
				// 	Text = "An axe and buckler with light armour is the best choice.",
				// 	function getResult( _event )
				// 	{
				// 		return "E";
				// 	}

				// },
				// {
				// 	Text = "I always was a good shot - I\'ll take the crossbow, a sword and light armour.",
				// 	function getResult( _event )
				// 	{
				// 		return "F";
				// 	}

				// },
				// {
				// 	Text = "I\'m a little rusty, but a bow and dagger with some nice cloth armour is the proper choice.",
				// 	function getResult( _event )
				// 	{
				// 		return "G";
				// 	}

				// },
				// {
				// 	Text = "I\'ll stick to what I know - a pike is almost a jousting lance, right?",
				// 	function getResult( _event )
				// 	{
				// 		return "H";
				// 	}

				// }
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_01.png[/img]{You pick up the longsword from the weapon rack - while not expertly made it has good balance and reach to win almost any fight.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Well balanced and fast. | Versatile and strong.}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/legend_longsword");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Const.World.Common.pickArmor([
					[
						1,
						"coat_of_plates"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"full_helm"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_01.png[/img]{You pick up the hammer from the weapon rack - while not expertly made it can smash any foe.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{No knight will stand before me! | No knight will stand before me!}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/two_handed_hammer");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Const.World.Common.pickArmor([
					[
						1,
						"coat_of_plates"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"full_helm"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_01.png[/img]{Always wanting to break convention - you take a heavy fighting axe and what remains of your crowns is spent on a light buckler.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Heavy hitting and light on my feet.}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/fighting_axe");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				local item = this.new("scripts/items/shields/buckler_shield");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Const.World.Common.pickArmor([
					[
						1,
						"leather_lamellar"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"padded_kettle_hat"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_01.png[/img]{You grab the crossbow and arming sword from the rack. You look down the sights and wonder how hard it could be to get back into firing one again since your younger days hunting rabbits.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Well, if a peasant can use it... | If all else fails, I still have the sword.}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/crossbow");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				local item = this.new("scripts/items/weapons/arming_sword");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				local item = this.new("scripts/items/ammo/quiver_of_bolts");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Const.World.Common.pickArmor([
					[
						1,
						"padded_leather"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"closed_mail_coif"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_01.png[/img]{You test the string on the hunting bow. Pulling it back reminds you of all the archery tournaments you won in the past and how hard it would be to hit a living, breathing and possible very angry target.\n\nEither way - you still have a nice, sharp dagger if they get close.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{I wonder how far the arrow goes... | It\'s better than a servant\'s knife I guess...}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/hunting_bow");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				local item = this.new("scripts/items/ammo/quiver_of_arrows");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				local item = this.new("scripts/items/weapons/rondel_dagger");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Const.World.Common.pickArmor([
					[
						1,
						"patched_mail_shirt"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"closed_mail_coif"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "H",
			Text = "[img]gfx/ui/events/event_01.png[/img]{Perhaps it\'s best to stick to what you are familiar with - a long pike that is much like a jousting lance in function and handling.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{I\'m about to ruin somebody\'s day with this... | Can\'t be much harder than using a lance...}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/pike");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Const.World.Common.pickArmor([
					[
						1,
						"reinforced_mail_hauberk"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"conic_helmet_with_closed_mail"
					]
				]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		return;
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


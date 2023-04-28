::mods_hookExactClass("events/events/crisis/greenskins_slayer_event", function (o)
{
	o.create = function()
	{
		this.m.ID = "event.crisis.greenskins_slayer";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_35.png[/img]While marching, a man crosses paths with the %companyname%. He is well armored and appears rather knightly save for one feature: a bone necklace hanging from his neck. With each step it clatters with sickly hollowness against his breastplate. You regard this stranger and his skeletal adornments with caution, lest he make a belt out of yer cock and a breast plate out of yer...%SPEECH_ON%Evening, sellswords.%SPEECH_OFF%The warrior waves. There\'s an unseen weight to this man, as though surrounded by dead air or perhaps the souls of his victims. He nods and continues speaking.%SPEECH_ON%You seem the greenskin skinnin\' sort, and that\'s the sort of company I\'d be most agreeable to joining.%SPEECH_OFF%%randombrother% exchanges a glance with you and shrugs. He whispers his indifference.%SPEECH_ON%If he\'s a problem, we can handle him.%SPEECH_OFF%The man shakes his head.%SPEECH_ON%Oh, I\'ll be no problem. I just want to kill orcs and goblins. What more do you need to know? Once these greenskins are taken care of, I\'ll be out of your hair.%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "You might as well join us.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "No, thanks, we\'re good.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"orc_slayer_background"
				]);
				_event.m.Dude.getSkills().add(::new("scripts/skills/traits/hate_greenskins_trait"));

				_event.m.Dude.m.PerkPoints = 10;
				_event.m.Dude.m.LevelUps = 10;
				_event.m.Dude.m.Level = 11;
				_event.m.Dude.m.XP = ::Const.LevelXP[_event.m.Dude.m.Level - 1];
				_event.m.Dude.m.Talents = [];
				local talents = _event.m.Dude.getTalents();
				talents.resize(::Const.Attributes.COUNT, 0);
				talents[::Const.Attributes.MeleeSkill] = 3;
				talents[::Const.Attributes.MeleeDefense] = 3;
				talents[::Const.Attributes.Bravery] = 3;
				_event.m.Dude.m.Attributes = [];
				_event.m.Dude.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);

				local necklace = ::new("scripts/items/accessory/special/slayer_necklace_item");
				necklace.m.Name = _event.m.Dude.getNameOnly() + "\'s Necklace";
				_event.m.Dude.getItems().equip(necklace);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}
});


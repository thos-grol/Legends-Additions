this.mage_winter_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.potion.mage.winter";
		this.m.Name = "Mage of Winter";
		this.m.Description = "The path of blasphemy, using the remnants of the gods.\n\nWinter is the principle of silence, of endings, and of those things that are not quite dead";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_26.png";
		this.m.Value = 0;
	}

	function get_tooltip(result)
	{
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/health.png",
			text = ::MSU.Text.colorRed("-25") + " Hitpoints (Vitality Conversion)"
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::MSU.Text.colorGreen("1") + " Mana pool"
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/days_wounded.png",
			text = "\nEnables the casting of Winter aspect magic"
		});

		return result;
	}

	function mutate(_actor)
	{
		if (!_actor.getSkills().hasSkill("perk.pattern_recognition"))
		{
			_actor.getItems().transferToStash(this.World.Assets.getStash());
			_actor.getSkills().onDeath(::Const.FatalityType.None);
			this.World.Statistics.addFallen(_actor, "Did not have the processing power to build a magic matrix");
			this.World.getPlayerRoster().remove(_actor);
		}
		::Z.Perks.add(_actor, ::Const.Perks.PerkDefs.WinterMage, 0);
	}

});


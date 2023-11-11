this.direwolf_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.potion.direwolf";
		this.m.Name = "Potion of Blade Dancing";
		this.m.Description = "This humoural concoction, borne from research into the dreaded direwolf, will turn even the clumsiest oaf into a lithe dancer of a warrior, able to gracefully move with the tides of battle long after lesser men succumb to fatigue! Mild akathisia after consuming is normal and expected.";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_26.png";
		this.m.Value = 0;
	}

	function get_tooltip(result)
	{
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/days_wounded.png",
			text = "Reduces the time it takes to heal from any injury by one day, down to a mininum of one day"
		});
		return result;
	}

	function mutate(_actor)
	{
		::Z.Perks.add(_actor, ::Const.Perks.PerkDefs.RuinKnight, 0);
	}

});


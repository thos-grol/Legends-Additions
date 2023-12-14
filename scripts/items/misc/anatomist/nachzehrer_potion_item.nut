this.nachzehrer_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.potion.nachzehrer";
		this.m.Name = "Knight of Gluttony";
		this.m.Description = "";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_36.png";
		this.m.Value = 1000;
	}

	function get_tooltip(result)
	{
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/winter.png",
			text = "Winter"
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/grail.png",
			text = "Grail"
		});
		return result;
	}

	function mutate()
	{
		::Z.Perks.add(_actor, ::Const.Perks.PerkDefs.GluttonyKnight, 0);
		::Z.Perks.add(_actor, ::Const.Perks.PerkDefs.LegendGruesomeFeast, 0);
	}

});
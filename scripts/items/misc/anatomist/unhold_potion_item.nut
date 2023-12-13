this.unhold_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.potion.unhold";
		this.m.Name = "Knight of Continuance";
		this.m.Description = "";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_32.png";
		this.m.Value = 0;
	}

	function get_tooltip(result)
	{
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/heart.png",
			text = "Heart"
		});
		return result;
	}

	function mutate()
	{
		::Z.Perks.add(_actor, ::Const.Perks.PerkDefs.ContinuanceKnight, 0);
	}

});
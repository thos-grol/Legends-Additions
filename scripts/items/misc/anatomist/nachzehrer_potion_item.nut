this.nachzehrer_potion_item <- this.inherit("scripts/items/misc/anatomist/anatomist_potion_item", {
	m = {},
	function create()
	{
		this.anatomist_potion_item.create();
		this.m.ID = "misc.potion.nachzehrer";
		this.m.Name = "Potion of Flesh Knitting";
		this.m.Description = "If one divorces the horror of the act from its utility, there are few phenomena more marvelous in nature than the Nachzehrer\'s ability to recover by eating the flesh of the dead. No longer! Now man himself may take on such qualities, and without committing crimes of conscience, to boot!";
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_36.png";
		this.m.Value = 0;
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
			icon = "ui/icons/edge.png",
			text = "Edge"
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/days_wounded.png",
			text = "Reduces the time it takes to heal from any injury by one day, down to a mininum of one day"
		});
		return result;
	}

	function mutate()
	{
		this.m.Container.add(this.new("scripts/skills/effects/nachzehrer_potion_effect"));
	}

});
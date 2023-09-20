::Const.Strings.PerkName.PocketDirt <- "Pocket Dirt";
::Const.Strings.PerkDescription.PocketDirt <- "The dirtiest of tricks, for the most devious of men..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]\'Throw Dirt\'[/u] (3 AP, 5 Fat, 1 Charge):")
+ "\nThrow dirt into the enemy's eyes and stuns them"
+ "\n"+::MSU.Text.colorRed("Invalid if the enemy has suffered from this trick before or has this perk");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.PocketDirt].Name = ::Const.Strings.PerkName.PocketDirt;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.PocketDirt].Tooltip = ::Const.Strings.PerkDescription.PocketDirt;

this.perk_pocket_dirt <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.pocket_dirt";
		this.m.Name = this.Const.Strings.PerkName.PocketDirt;
		this.m.Description = this.Const.Strings.PerkDescription.PocketDirt;
		this.m.Icon = "ui/perks/twirl_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.throw_dirt"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.throw_dirt");
	}


});


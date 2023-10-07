::Const.Strings.PerkName.Hybridization <- "Hybridization";
::Const.Strings.PerkDescription.Hybridization <- "Become proficient in both ranged and melee weapons..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Melee weapon equipped:")
+ "\n"+::MSU.Text.colorGreen("+15% of Ranged Skill") + " as Melee Skill"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Ranged weapon equipped:")
+ "\n"+::MSU.Text.colorGreen("+15% of Melee Skill") + " as Ranged Skill";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Hybridization].Name = ::Const.Strings.PerkName.Hybridization;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Hybridization].Tooltip = ::Const.Strings.PerkDescription.Hybridization;

this.perk_hybridization <- this.inherit("scripts/skills/skill", {
	m = {
		Bonus = 0.15
	},
	function create()
	{
		this.m.ID = "perk.hybridization";
		this.m.Name = ::Const.Strings.PerkName.Hybridization;
		this.m.Description = ::Const.Strings.PerkDescription.Hybridization;
		this.m.Icon = "ui/perks/hybridization.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null) return;

		local baseProperties = this.getContainer().getActor().getBaseProperties();
		if (_item.isItemType(::Const.Items.ItemType.RangedWeapon)) _properties.RangedSkill += this.Math.floor(baseProperties.getMeleeSkill() * this.m.Bonus);
		else _properties.MeleeSkill += this.Math.floor(baseProperties.getRangedSkill() * this.m.Bonus);

	}
});

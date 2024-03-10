::Const.Strings.PerkName.Hybridization <- "Hybridization";
::Const.Strings.PerkDescription.Hybridization <- "Become proficient in both ranged and melee weapons..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Melee weapon equipped:")
+ "\n"+::MSU.Text.colorGreen("+20% of Ranged Skill") + " as Skill"
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Ranged weapon equipped:")
+ "\n"+::MSU.Text.colorGreen("+20% of Skill") + " as Ranged Skill";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Hybridization].Name = ::Const.Strings.PerkName.Hybridization;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Hybridization].Tooltip = ::Const.Strings.PerkDescription.Hybridization;

this.perk_hybridization <- this.inherit("scripts/skills/skill", {
	m = {
		Bonus = 0.20
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
		local baseProperties = this.getContainer().getActor().getBaseProperties();
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null) 
		{
			_properties.MeleeSkill += ::Math.floor(baseProperties.getRangedSkill() * this.m.Bonus);
			return;
		}
		
		if (weapon.isItemType(::Const.Items.ItemType.RangedWeapon)) _properties.RangedSkill += ::Math.floor(baseProperties.getMeleeSkill() * this.m.Bonus);
		else _properties.MeleeSkill += ::Math.floor(baseProperties.getRangedSkill() * this.m.Bonus);

	}
});

::Const.Strings.PerkName.DeathDealer <- "Death Dealer";
::Const.Strings.PerkDescription.DeathDealer <- "There\'s bears, nachzehrers, and you. All beings of vicious slaughter..."

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("50%") + " chance to resist stagger"
+ "\n If Strength is " + ::MSU.Text.colorGreen("3X") + " the weight of a melee weapon, -2 AP cost for all skills on that weapon >= 6"

+ "\n\n" + ::MSU.Text.color(::Z.Color.BloodRed, "Stagger: (Removed on turn start)")
+ "\n"+::MSU.Text.colorRed("– 50% Agility")
+ "\n"+::MSU.Text.colorRed("– 25 Defense")
+ "\n"+::MSU.Text.colorRed("+Cancels Shieldwall, Spearwall, Return Favor, and Riposte");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.DeathDealer].Name = ::Const.Strings.PerkName.DeathDealer;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.DeathDealer].Tooltip = ::Const.Strings.PerkDescription.DeathDealer;

this.perk_death_dealer <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.death_dealer";
		this.m.Name = ::Const.Strings.PerkName.DeathDealer;
		this.m.Description = ::Const.Strings.PerkDescription.DeathDealer;
		this.m.Icon = "ui/perks/tackle_circle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate(_properties)
	{
		if (!this.getContainer().getActor().isPlacedOnMap()) return;

		local actor = this.getContainer().getActor();
		local weapon = actor.getMainhandItem();
		if (weapon == null || weapon.m.StaminaModifier * -3.0 >= actor.m.CurrentProperties.getRangedSkill() * 1.0) return;

		local skills = this.getContainer().getSkillsByFunction((@(_skill) _skill.m.IsWeaponSkill && _skill.m.ActionPointCost >= 6).bindenv(this));
		if (skills.len() == 0) return;
		foreach (s in skills)
		{
			if (s != null)
			{
				s.m.ActionPointCost -= 2;
			}
		}
	}

	function onAffordablePreview( _skill, _movementTile )
	{
		local actor = this.getContainer().getActor();
		local weapon = actor.getMainhandItem();
		if (weapon == null || weapon.m.StaminaModifier * -3.0 >= actor.m.CurrentProperties.getRangedSkill() * 1.0) return;

		if (_skill == null) return;
		foreach (skill in this.getContainer().getSkillsByFunction((@(_skill) _skill.m.IsWeaponSkill && _skill.m.ActionPointCost >= 6).bindenv(this)))
		{
			this.modifyPreviewField(skill, "ActionPointCost", skill.m.ActionPointCost - 2, false);
		}
	}

	
});

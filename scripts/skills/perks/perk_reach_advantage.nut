::Const.Strings.PerkName.ReachAdvantage = "Reach Advantage";
::Const.Strings.PerkDescription.ReachAdvantage = "Abuse the superior reach of your weapon..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "2H Weapon Attack Hit:")
+ "\n"+ ::MSU.Text.colorRed("+1 stack up to 5")
+ "\n" + ::MSU.Text.colorGreen("+7") + " Defense per stack"
+ "\n" + ::MSU.Text.colorRed("Expires on turn start");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ReachAdvantage].Name = ::Const.Strings.PerkName.ReachAdvantage;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ReachAdvantage].Tooltip = ::Const.Strings.PerkDescription.ReachAdvantage;

this.perk_reach_advantage <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0
	},
	function create()
	{
		this.m.ID = "perk.reach_advantage";
		this.m.Name = ::Const.Strings.PerkName.ReachAdvantage;
		this.m.Description = ::Const.Strings.PerkDescription.ReachAdvantage;
		this.m.Icon = "ui/perks/perk_19.png";
		this.m.IconMini = "perk_19_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk | ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function getDescription()
	{
		return "This character is using the superior reach of their melee weapon to keep opponents at bay, increasing Defense by [color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.Stacks * 5 + "[/color] until their next turn.";
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!this.getContainer().getActor().getCurrentProperties().IsAbleToUseWeaponSkills)
		{
			return;
		}

		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);

		if (weapon != null && weapon.isItemType(::Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(::Const.Items.ItemType.TwoHanded))
		{
			this.m.Stacks = ::Math.min(this.m.Stacks + 1, 5);
		}
	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = this.m.Stacks == 0;
		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);

		if (weapon != null && weapon.isItemType(::Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(::Const.Items.ItemType.TwoHanded))
		{
			_properties.MeleeDefense += this.m.Stacks * 7;
		}
		else
		{
			this.m.Stacks = 0;
		}
	}

	function onTurnStart()
	{
		this.m.Stacks = 0;
		this.m.IsHidden = true;
	}

	function onCombatStarted()
	{
		this.m.Stacks = 0;
		this.m.IsHidden = true;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
		this.m.IsHidden = true;
	}

});


::Const.Tactical.Actor.Conscript = {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 70,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 5,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/humans/conscript", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Conscript);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_southern");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
	}

	o.onOtherActorDeath = function( _killer, _victim, _skill )
	{
		if (_victim.getType() == this.Const.EntityType.Slave && _victim.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorDeath(_killer, _victim, _skill);
	}

	o.onOtherActorFleeing = function( _actor )
	{
		if (_actor.getType() == this.Const.EntityType.Slave && _actor.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorFleeing(_actor);
	}

	o.assignRandomEquipment = function()
	{
		local r;
		local banner;

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = 13;
		}

		r = this.Math.rand(1, 5);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/oriental/light_southern_mace"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/oriental/saif"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/scimitar"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/oriental/firelance"));
		}

		if (this.Math.rand(1, 100) <= 90)
		{
			this.m.Items.equip(this.new("scripts/items/shields/oriental/southern_light_shield"));
		}

		local variant;

		if (banner == 12)
		{
			variant = 9;
		}
		else if (banner == 13)
		{
			variant = 10;
		}
		else
		{
			variant = 8;
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				2,
				"oriental/linothorax",
				variant
			],
			[
				1,
				"oriental/southern_mail_shirt"
			]
		]));
		local variant = 7;

		if (banner == 12)
		{
			variant = 12;
		}
		else if (banner == 13)
		{
			variant = 8;
		}
		else if (banner == 14)
		{
			variant = 7;
		}

		local helm = this.Const.World.Common.pickHelmet([
			[
				1,
				"oriental/southern_head_wrap",
				variant
			],
			[
				1,
				"oriental/wrapped_southern_helmet"
			],
			[
				1,
				"oriental/spiked_skull_cap_with_mail"
			]
		]);
		this.m.Items.equip(helm);
	}

});


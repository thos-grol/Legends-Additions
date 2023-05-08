::Const.Tactical.Actor.NomadArcher = {
	XP = 225,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 55,
	Stamina = 115,
	MeleeSkill = 50,
	RangedSkill = 65,
	MeleeDefense = 5,
	RangedDefense = 15,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
::mods_hookExactClass("entity/tactical/humans/nomad_archer", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.NomadArcher);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");

		if (this.Math.rand(1, 100) <= 20)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
			dirt.Alpha = this.Math.rand(150, 255);
		}

		b.IsSpecializedInBows = true;
		b.Vision = 8;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 30)
		{
			b.RangedSkill += 5;

			if (this.World.getTime().Days >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
				b.RangedDefense += 5;
			}
		}

		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		}
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
		local weapons = [
			[
				"weapons/oriental/composite_bow",
				"ammo/quiver_of_arrows"
			]
		];
		local n = this.Math.rand(0, weapons.len() - 1);

		foreach( w in weapons[n] )
		{
			this.m.Items.equip(this.new("scripts/items/" + w));
		}

		weapons = [
			"weapons/knife",
			"weapons/wooden_stick",
			"weapons/oriental/nomad_mace",
			"weapons/oriental/saif"
		];
		this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		local armor = [
			[
				2,
				"oriental/nomad_robe"
			],
			[
				2,
				"oriental/thick_nomad_robe"
			],
			[
				1,
				"oriental/cloth_sash"
			],
			[
				3,
				"nomad_archer_armor_00"
			]
		];
		local helmet = [
			[
				2,
				"oriental/nomad_head_wrap"
			],
			[
				3,
				"oriental/nomad_head_wrap"
			],
			[
				1,
				"citrene_nomad_ranged_helmet_00"
			],
			[
				3,
				"oriental/nomad_leather_cap"
			]
		];
		local outfits = [
			[
				1,
				"dark_southern_outfit_00"
			]
		];

		foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
		{
			this.m.Items.equip(item);
		}
	}

});


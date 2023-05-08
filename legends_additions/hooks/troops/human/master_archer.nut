::Const.Tactical.Actor.MasterArcher = {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 70,
	Stamina = 135,
	MeleeSkill = 65,
	RangedSkill = 85,
	MeleeDefense = 15,
	RangedDefense = 25,
	Initiative = 140,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
::mods_hookExactClass("entity/tactical/humans/master_archer", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.MasterArcher);
		b.DamageDirectMult = 1.25;
		b.IsSpecializedInBows = true;
		b.Vision = 8;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ballistics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_close_combat_archer"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.onDeath = function( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled() && _skill != null && _skill.isRanged())
		{
			this.updateAchievement("Bullseye", 1, 1);
		}

		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	o.assignRandomEquipment = function()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			if (this.Math.rand(1, 100) <= 66)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
			}
		}

		local weapons = [
			"weapons/dagger",
			"weapons/scramasax",
			"weapons/hatchet"
		];
		this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			local armor = [
				[
					1,
					"thick_tunic"
				],
				[
					1,
					"padded_surcoat"
				],
				[
					1,
					"leather_lamellar"
				],
				[
					1,
					"basic_mail_shirt"
				],
				[
					1,
					"ragged_surcoat"
				],
				[
					1,
					"basic_mail_shirt"
				]
			];
			this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head) && this.Math.rand(1, 100) <= 50)
		{
			local helmet = [
				"helmets/hood",
				"helmets/headscarf"
			];
			this.m.Items.equip(this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]));
		}
	}

	o.makeMiniboss = function()
	{
		this.actor.makeMiniboss();
		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			[
				"weapons/named/named_warbow",
				"ammo/quiver_of_arrows"
			],
			[
				"weapons/named/named_crossbow",
				"ammo/quiver_of_bolts"
			]
		];
		local armor = [
			"armor/named/black_leather_armor",
			"armor/named/blue_studded_mail_armor"
		];

		if (this.Math.rand(1, 100) <= 70)
		{
			local r = this.Math.rand(0, weapons.len() - 1);

			foreach( w in weapons[r] )
			{
				this.m.Items.equip(this.new("scripts/items/" + w));
			}
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor(this.Const.World.Common.convNameToList(armor)));
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
	}

});


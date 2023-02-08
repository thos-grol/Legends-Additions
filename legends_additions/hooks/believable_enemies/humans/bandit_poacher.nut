//Lv 5 poacher template
//4 perks
::Const.Tactical.Actor.BanditPoacher <- {
	XP = 175,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 33,
	Stamina = 95,
	MeleeSkill = 53,
	RangedSkill = 48,
	MeleeDefense = 3,
	RangedDefense = 3,
	Initiative = 107,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/enemies/bandit_poacher", function(o) {
	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{

		//tribal trait
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bully"));
		//defensive perk
		if(this.Math.rand(1, 6) < 6) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
		else this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2

		this.m.Skills.add(::new("scripts/skills/perks/perk_recover")); //1
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_onslaught")); //4
		this.level_ranged_skill(4, this.Math.rand(-6, 3) );
		this.level_melee_defense(4, 1);
		this.level_initiative(3, this.Math.rand(-6, 3) );
		this.level_fatigue(1, this.Math.rand(-6, 3) );

		local weapons = [
			[
				"weapons/short_bow",
				"ammo/quiver_of_arrows",
				"weapons/legend_sling"
			]
		];

		local n = this.Math.rand(0, weapons.len() - 1);
		foreach( w in weapons[n] )
		{
			this.m.Items.equip(this.new("scripts/items/" + w));
		}

		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			if (weapon.isWeaponType(::Const.Items.WeaponType.Sling)) this.m.Skills.add(::new("scripts/skills/perks/perk_legend_specialist_sling_skill"));
			else this.m.Skills.add(::new("scripts/skills/perks/perk_ballistics")); //2 -> 3
		}

		if (this.Math.rand(1, 100) <= 50) this.m.Items.addToBag(this.new("scripts/items/weapons/legend_shiv"));
		else this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));

		local item = this.Const.World.Common.pickArmor([
			[
				20,
				"leather_wraps"
			]
		]);
		this.m.Items.equip(item);

		if (this.Math.rand(1, 100) <= 50)
		{
			local item = this.Const.World.Common.pickHelmet([
				[
					1,
					"headscarf"
				],
				[
					1,
					"mouth_piece"
				]
			]);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}

	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditPoacher);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

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
		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);
	}
});

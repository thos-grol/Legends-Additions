//Bandit Poacher
//Lvl 3 poacher template, 2 perks
//Avg poacher stats
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
::mods_hookExactClass("entity/tactical/enemies/bandit_rabble_poacher", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BanditRabble);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (this.Math.rand(1, 100) <= 10)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_pox_01");
		}
		else if (this.Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		this.setArmorSaturation(0.8);
		this.getSprite("shield_icon").setBrightness(0.9);
		this.m.Skills.update();

		this.level_ranged_skill(2, 0);
		this.level_melee_defense(2, 0);
		this.level_initiative(2, 0);

		//Add bandit tribal perk
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bully"));

		//Add defensive perk
		local r = this.Math.rand(1, 6)
		if(r < 6) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
		else this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
		assignRandomEquipment();
		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			if (weapon.isWeaponType(::Const.Items.WeaponType.Sling))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_legend_specialist_sling_skill"));
			}
			else
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_ballistics"));
			}
		}
	}
});

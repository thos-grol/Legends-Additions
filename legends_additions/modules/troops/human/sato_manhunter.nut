::Const.Tactical.Actor.SatoManhunter = {
	XP = 225,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 60,
	Stamina = 110,
	MeleeSkill = 75,
	RangedSkill = 55,
	MeleeDefense = 15,
	RangedDefense = 10,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 18
};
::mods_hookExactClass("entity/tactical/humans/sato_manhunter", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SatoManhunter);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");

		if (this.Math.rand(1, 100) <= 15)
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

		b.IsSpecializedInMaces = true;
		b.IsSpecializedInCleavers = true;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInThrowing = true;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
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
			"weapons/scimitar",
			"weapons/oriental/light_southern_mace"
		];

		if (this.Const.DLC.Wildmen)
		{
			weapons.extend([
				"weapons/scimitar",
				"weapons/scimitar",
				"weapons/oriental/light_southern_mace",
				"weapons/oriental/light_southern_mace",
				"weapons/battle_whip"
			]);
		}

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
		local armor = [
			[
				1,
				"leather_lamellar"
			],
			[
				1,
				"oriental/plated_nomad_mail"
			],
			[
				1,
				"oriental/southern_mail_shirt"
			]
		];

		if (this.World.getTime().Days > 18)
		{
			armor.extend([
				[
					1,
					"mail_shirt"
				],
				[
					1,
					"oriental/mail_and_lamellar_plating"
				]
			]);
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
		local helmet = [
			[
				1,
				"oriental/nomad_leather_cap"
			],
			[
				1,
				"oriental/nomad_light_helmet"
			],
			[
				1,
				"oriental/wrapped_southern_helmet"
			],
			[
				1,
				"oriental/spiked_skull_cap_with_mail"
			]
		];

		if (this.World.getTime().Days <= 18)
		{
			helmet.extend([
				[
					1,
					"oriental/southern_head_wrap"
				]
			]);
		}

		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}

});


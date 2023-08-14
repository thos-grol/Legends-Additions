::Const.Tactical.Actor.SatoManhunterVeteranRanged = {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 75,
	Stamina = 125,
	MeleeSkill = 55,
	RangedSkill = 75,
	MeleeDefense = 10,
	RangedDefense = 15,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 18
};
::mods_hookExactClass("entity/tactical/humans/sato_manhunter_veteran_ranged", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SatoManhunterVeteranRanged);
		b.TargetAttractionMult = 1.1;
		b.Vision = 8;
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

		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInBows = true;
		b.IsSpecializedInCrossbows = true;
		b.IsSpecializedInDaggers = true;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
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
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local r = this.Math.rand(1, 3);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/oriental/handgonne"));
				this.m.Items.equip(this.new("scripts/items/ammo/powder_bag"));
			}
			else
			{
				local weapons = [
					"weapons/throwing_axe",
					"weapons/throwing_axe",
					"weapons/javelin"
				];

				if (this.World.getTime().Days < 80)
				{
					weapons.extend([
						"weapons/greenskins/goblin_spiked_balls"
					]);
				}

				weapons.extend([
					"weapons/greenskins/goblin_spiked_balls"
				]);
				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}
		}

		local mainhandWeaponID = this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID();

		if (mainhandWeaponID == "weapon.handgonne" || mainhandWeaponID == "weapon.named_handgonne")
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/oriental/qatal_dagger"));
		}
		else
		{
			local backupWeapons = [
				"weapons/hooked_blade",
				"weapons/warbrand",
				"weapons/oriental/two_handed_saif",
				"weapons/warfork"
			];
			this.m.Items.addToBag(this.new("scripts/items/" + backupWeapons[this.Math.rand(0, backupWeapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			local armors = [
				[
					1,
					"oriental/mail_and_lamellar_plating"
				],
				[
					1,
					"oriental/southern_long_mail_with_padding"
				],
				[
					1,
					"mail_hauberk"
				],
				[
					1,
					"reinforced_mail_hauberk"
				],
				[
					1,
					"lamellar_harness"
				]
			];

			if (this.Const.DLC.Unhold)
			{
				armors.extend([
					[
						1,
						"leather_scale_armor"
					],
					[
						1,
						"footman_armor"
					]
				]);
			}

			this.m.Items.equip(this.Const.World.Common.pickArmor(armors));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helmets = [
				[
					1,
					"oriental/wrapped_southern_helmet"
				],
				[
					1,
					"oriental/spiked_skull_cap_with_mail"
				],
				[
					1,
					"oriental/southern_helmet_with_coif"
				]
			];

			if (this.World.getTime().Days > 50)
			{
				helmets.extend([
					[
						1,
						"oriental/heavy_lamellar_helmet"
					]
				]);

				if (this.Const.DLC.Wildmen)
				{
					helmets.extend([
						[
							1,
							"conic_helmet_with_closed_mail"
						]
					]);
				}
			}

			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmets));
		}
	}

	o.makeMiniboss = function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			[
				"weapons/named/named_javelin"
			],
			[
				"weapons/named/named_throwing_axe"
			],
			[
				"weapons/named/named_handgonne",
				"ammo/powder_bag"
			]
		];
		local armors = clone this.Const.Items.NamedSouthernArmors;
		armors.push("armor/named/golden_scale_armor");

		if (this.Const.DLC.Wildmen)
		{
			armors.push("armor/named/named_golden_lamellar_armor");
		}

		local helmets = clone this.Const.Items.NamedSouthernHelmets;
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			local r = this.Math.rand(0, weapons.len() - 1);

			foreach( w in weapons[r] )
			{
				this.m.Items.equip(this.new("scripts/items/" + w));
			}
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor(this.Const.World.Common.convNameToList(armors)));
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet(this.Const.World.Common.convNameToList(helmets)));
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		return true;
	}

});


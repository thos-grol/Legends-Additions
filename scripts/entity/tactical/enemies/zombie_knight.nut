this.zombie_knight <- this.inherit("scripts/entity/tactical/enemies/zombie", {
	m = {},
	function create()
	{
		this.zombie.create();
		this.m.Type = ::Const.EntityType.ZombieKnight;
		this.m.BloodType = ::Const.BloodType.Dark;
		this.m.MoraleState = ::Const.MoraleState.Ignore;
		this.m.XP = ::Const.Tactical.Actor.ZombieKnight.XP;
		this.m.Name = ::Const.Strings.EntityName[this.m.Type];
		this.m.IsResurrectingOnFatality = true;
		this.m.ResurrectionValue = 5.0;
		this.m.ResurrectionChance = 90;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/zombie_knight";
		this.getFlags().add("undead");
		this.getFlags().add("zombie_minion");
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		if (this.m.IsHeadless)
		{
			_hitInfo.BodyPart = ::Const.BodyPart.Body;
		}

		return this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
	}

	function onInit()
	{
		this.zombie.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.ZombieKnight);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsImmuneToStun = true;

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;

		this.m.Skills.add(this.new("scripts/skills/perks/perk_meditation_omen_of_decay"));
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("RestlessDead", 1, 1);
		}

		this.zombie.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function pickOutfit()
	{
		local aList = [
			[
				1,
				"decayed_coat_of_plates"
			],
			[
				1,
				"decayed_coat_of_scales"
			],
			[
				1,
				"decayed_reinforced_mail_hauberk"
			]
		];
		local armor = ::Const.World.Common.pickArmor(aList);

		if (::Math.rand(1, 100) <= 33)
		{
			armor.setArmor(::Math.round(armor.getArmorMax() / 2 - 1));
		}

		this.m.Items.equip(armor);

		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Head) == null && ::Math.rand(1, 100) <= 90)
		{
			local helmet = [
				[
					1,
					"decayed_closed_flat_top_with_sack"
				],
				[
					3,
					"decayed_closed_flat_top_with_mail"
				],
				[
					3,
					"decayed_full_helm"
				],
				[
					3,
					"decayed_great_helm"
				]
			];
			local h = ::Const.World.Common.pickHelmet(helmet);

			if (::Math.rand(1, 100) <= 33)
			{
				h.setArmor(::Math.round(h.getArmorMax() / 2 - 1));
			}

			this.m.Items.equip(h);
		}
	}

	function drop_loot(_tile)
	{
		for(local i = 0; i < 3; i++ )
		{
			if (::Math.rand(1,100) <= 20 )
			{
				local s = this.new("scripts/items/misc/magic/soul_splinter");
				s.drop(_tile);
			}
		}
	}

	function pickNamed()
	{
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;

		//FEATURE_5: fallen hero champion?
	}

});


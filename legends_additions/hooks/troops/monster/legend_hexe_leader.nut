::Const.Tactical.Actor.Hexe = {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 160,
	Stamina = 80,
	MeleeSkill = 0,
	RangedSkill = 0,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 15,
	Vision = 8,
	Armor = [
		25,
		0
	]
};
::mods_hookExactClass("entity/tactical/enemies/legend_hexe_leader", function(o) {
	o.onDeath = function( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("BagAHag", 1, 1);
		}

		if (_tile != null)
		{
			local flip = this.Math.rand(0, 100) < 50;
			local decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("body");
			local head = this.getSprite("head");
			local hair = this.getSprite("hair");
			body.Alpha = 255;
			head.Alpha = 255;
			hair.Alpha = 255;
			decal = _tile.spawnDetail(body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.95;

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				decal = _tile.spawnDetail(head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = head.Color;
				decal.Saturation = head.Saturation;
				decal.Scale = 0.95;
				decal = _tile.spawnDetail(hair.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [
					head.getBrush().Name + "_dead",
					hair.getBrush().Name + "_dead"
				];
				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), 45.0, head.getBrush().Name + "_bloodpool");
				decap[0].Color = head.Color;
				decap[0].Saturation = head.Saturation;
				decap[0].Scale = 0.95;
				decap[1].Scale = 0.95;
			}

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail(body.getBrush().Name + "_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail(body.getBrush().Name + "_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "A Hexe";
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
			{
				local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

				for( local i = 0; i < n; i = i )
				{
					local r = this.Math.rand(1, 100);
					local loot;

					if (r <= 50)
					{
						loot = this.new("scripts/items/misc/legend_witch_leader_hair_item");
					}
					else if (r <= 70)
					{
						loot = this.new("scripts/items/misc/mysterious_herbs_item");
					}
					else
					{
						loot = this.new("scripts/items/misc/poisoned_apple_item");
					}

					loot.drop(_tile);

					if (this.Math.rand(1, 100) <= 50)
					{
						local food = this.new("scripts/items/supplies/black_marsh_stew_item");
						food.randomizeAmount();
						food.randomizeBestBefore();
						food.drop(_tile);
					}

					i = ++i;
				}

				local chance = 10;

				if (this.LegendsMod.Configs().LegendMagicEnabled())
				{
					chance = 100;
				}

				if (this.Math.rand(1, 100) <= chance)
				{
					if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
					{
						local rune;
						local selected = this.Math.rand(11, 13);

						switch(selected)
						{
						case 11:
							rune = this.new("scripts/items/legend_helmets/runes/legend_rune_clarity");
							break;

						case 12:
							rune = this.new("scripts/items/legend_helmets/runes/legend_rune_bravery");
							break;

						case 13:
							rune = this.new("scripts/items/legend_helmets/runes/legend_rune_luck");
							break;
						}

						rune.setRuneVariant(selected);
						rune.setRuneBonus(true);
						rune.drop(_tile);
					}
					else
					{
						local token = this.new("scripts/items/rune_sigils/legend_vala_inscription_token");
						token.setRuneVariant(this.Math.rand(11, 13));
						token.setRuneBonus(true);
						token.updateRuneSigilToken();
						token.drop(_tile);
					}
				}
			}
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	o.onInit = function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Hexe);
		b.TargetAttractionMult = 3.0;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_hexenleader_body_01");
		body.varySaturation(0.1);
		body.varyColor(0.05, 0.05, 0.05);
		local charm_body = this.addSprite("charm_body");
		charm_body.setBrush("bust_hexen_charmed_body_01");
		charm_body.Visible = false;
		local charm_armor = this.addSprite("charm_armor");
		charm_armor.setBrush("bust_hexen_charmed_dress_0" + this.Math.rand(1, 3));
		charm_armor.Visible = false;
		local head = this.addSprite("head");
		head.setBrush("bust_hexenleader_head_01");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local charm_head = this.addSprite("charm_head");
		charm_head.setBrush("bust_hexen_charmed_head_0" + this.Math.rand(1, 2));
		charm_head.Visible = false;
		local injury = this.addSprite("injury");
		injury.setBrush("bust_hexen_01_injured");
		local hair = this.addSprite("hair");
		hair.setBrush("bust_hexen_hair_0" + this.Math.rand(1, 4));
		local charm_hair = this.addSprite("charm_hair");
		charm_hair.setBrush("bust_hexen_charmed_hair_0" + this.Math.rand(1, 5));
		charm_hair.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.m.Skills.add(this.new("scripts/skills/actives/legend_intensely_charm_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/actives/hex_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_wither"));
		this.m.Skills.add(this.new("scripts/skills/actives/sleep_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_magic_missile"));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_teleport"));
		this.m.Skills.add(this.new("scripts/skills/actives/fake_drink_night_vision_skill"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/racial/schrat_racial"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_inspiring_presence"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_levitation"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}

		if (!this.Tactical.State.isScenarioMode())
		{
			local dateToSkip = 0;

			switch(this.World.Assets.getCombatDifficulty())
			{
			case this.Const.Difficulty.Easy:
				dateToSkip = 250;
				break;

			case this.Const.Difficulty.Normal:
				dateToSkip = 200;
				break;

			case this.Const.Difficulty.Hard:
				dateToSkip = 150;
				break;

			case this.Const.Difficulty.Legendary:
				dateToSkip = 100;
				break;
			}

			if (this.World.getTime().Days >= dateToSkip)
			{
				local bonus = this.Math.min(1, this.Math.floor((this.World.getTime().Days - dateToSkip) / 20.0));
				b.MeleeSkill += this.Math.floor(bonus / 2);
				b.RangedSkill += bonus;
				b.MeleeDefense += this.Math.floor(bonus / 2);
				b.RangedDefense += this.Math.floor(bonus / 2);
				b.Hitpoints += this.Math.floor(bonus * 2);
				b.Initiative += bonus;
				b.Stamina += bonus;
				b.Bravery += bonus;
				b.FatigueRecoveryRate += this.Math.floor(bonus / 4);
			}
		}
	}

	o.assignRandomEquipment = function()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/legend_staff_gnarled"));
	}

			this.Time.scheduleEvent(this.TimeUnit.Virtual, t + 100, function ( _e )
			this.Time.scheduleEvent(this.TimeUnit.Virtual, t + 100, function ( _e )
});

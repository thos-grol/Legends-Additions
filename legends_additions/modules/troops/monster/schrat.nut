::Const.Tactical.Actor.LegendGreenwoodSchrat = {
	XP = 1100,
	ActionPoints = 10,
	Hitpoints = 900,
	Bravery = 200,
	Stamina = 400,
	MeleeSkill = 80,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 80,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		0,
		0
	]
};
::mods_hookExactClass("entity/tactical/enemies/schrat", function(o) {
	o.onDeath = function( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("ChoppingWood", 1, 1);
		}

		if (_tile != null)
		{
			local flip = this.Math.rand(0, 100) < 50;
			local decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("body");
			local head = this.getSprite("head");
			decal = _tile.spawnDetail("bust_schrat_body_01_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.95;
			decal = _tile.spawnDetail(head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = head.Color;
			decal.Saturation = head.Saturation;
			decal.Scale = 0.95;

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail("bust_schrat_body_01_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail("bust_schrat_body_01_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "A Schrat";
			corpse.IsHeadAttached = true;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 90)
			{
				local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

				for( local i = 0; i < n; i = i )
				{
					local r = this.Math.rand(1, 100);
					local loot;

					if (r <= 40)
					{
						loot = this.new("scripts/items/misc/ancient_wood_item");
					}
					else if (r <= 80)
					{
						loot = this.new("scripts/items/misc/glowing_resin_item");
					}
					else
					{
						loot = this.new("scripts/items/misc/heart_of_the_forest_item");
					}

					loot.drop(_tile);
					local chance = 1;

					if (this.LegendsMod.Configs().LegendMagicEnabled())
					{
						chance = 10;
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						local token = this.new("scripts/items/rune_sigils/legend_vala_inscription_token");
						token.setRuneVariant(this.Math.rand(31, 32));
						token.setRuneBonus(true);
						token.updateRuneSigilToken();
						token.drop(_tile);
					}

					i = ++i;
				}

				if (this.Math.rand(1, 100) <= 25)
				{
					local loot = this.new("scripts/items/loot/ancient_amber_item");
					loot.drop(_tile);
				}
			}
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	o.onInit = function()
	{
		this.actor.onInit();
		local clouds = this.Tactical.getWeather().createCloudSettings();
		clouds.Type = this.getconsttable().CloudType.Fog;
		clouds.MinClouds = 20;
		clouds.MaxClouds = 20;
		clouds.MinVelocity = 3.0;
		clouds.MaxVelocity = 9.0;
		clouds.MinAlpha = 0.35;
		clouds.MaxAlpha = 0.45;
		clouds.MinScale = 2.0;
		clouds.MaxScale = 3.0;
		this.Tactical.getWeather().buildCloudCover(clouds);
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Schrat);
		b.IsImmuneToBleeding = true;
		b.IsImmuneToRoot = true;
		b.IsIgnoringArmorOnAttack = true;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToDisarm = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 250)
		{
			b.MeleeSkill += 5;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_schrat_body_01");
		body.varySaturation(0.2);
		body.varyColor(0.05, 0.05, 0.05);
		this.m.BloodColor = body.Color;
		local head = this.addSprite("head");
		head.setBrush("bust_schrat_head_0" + this.Math.rand(1, 2));
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_schrat_01_injured");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.54;
		this.setSpriteOffset("status_rooted", this.createVec(0, 0));
		this.setSpriteOffset("status_stunned", this.createVec(0, 10));
		this.setSpriteOffset("arrow", this.createVec(0, 10));
		this.m.Skills.add(this.new("scripts/skills/racial/schrat_racial"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		this.m.Skills.add(this.new("scripts/skills/actives/grow_shield_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/uproot_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/uproot_zoc_skill"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_bash"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lacerate"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shield_skill"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shield_push"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function()
	{
		this.m.Items.equip(this.new("scripts/items/shields/beasts/schrat_shield"));
	}

	o.makeMiniboss = function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.m.Skills.add(this.new("scripts/skills/racial/legend_greenwood_schrat_racial"));
		this.m.Skills.add(this.new("scripts/skills/actives/legend_grow_greenwood_shield_skill"));
		this.m.BaseProperties.setValues(this.Const.Tactical.Actor.LegendGreenwoodSchrat);
		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		this.m.Items.equip(this.new("scripts/items/shields/beasts/legend_greenwood_schrat_shield"));
		local body = this.addSprite("body");
		body.setBrush("bust_schrat_green_body_01");
		body.varySaturation(0.2);
		body.varyColor(0.05, 0.05, 0.05);
		this.m.BloodColor = body.Color;
		local head = this.addSprite("head");
		head.setBrush("bust_schrat_green_head_0" + this.Math.rand(1, 2));
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_schrat_green_01_injured");
		return true;
	}

});


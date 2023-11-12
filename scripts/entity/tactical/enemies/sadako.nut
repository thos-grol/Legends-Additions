this.sadako <- this.inherit("scripts/entity/tactical/actor", {
	m = {
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.Hexe;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Hexe.XP;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.m.DecapitateSplatterOffset = this.createVec(-8, -26);
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/dlc2/hexe_hurt_01.wav",
			"sounds/enemies/dlc2/hexe_hurt_02.wav",
			"sounds/enemies/dlc2/hexe_hurt_03.wav",
			"sounds/enemies/dlc2/hexe_hurt_04.wav",
			"sounds/enemies/dlc2/hexe_hurt_05.wav",
			"sounds/enemies/dlc2/hexe_hurt_06.wav",
			"sounds/enemies/dlc2/hexe_hurt_07.wav",
			"sounds/enemies/dlc2/hexe_hurt_08.wav",
			"sounds/enemies/dlc2/hexe_hurt_09.wav",
			"sounds/enemies/dlc2/hexe_hurt_10.wav",
			"sounds/enemies/dlc2/hexe_hurt_11.wav",
			"sounds/enemies/dlc2/hexe_hurt_12.wav",
			"sounds/enemies/dlc2/hexe_hurt_13.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/dlc2/hexe_death_01.wav",
			"sounds/enemies/dlc2/hexe_death_02.wav",
			"sounds/enemies/dlc2/hexe_death_03.wav",
			"sounds/enemies/dlc2/hexe_death_04.wav",
			"sounds/enemies/dlc2/hexe_death_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/dlc2/hexe_idle_01.wav",
			"sounds/enemies/dlc2/hexe_idle_02.wav",
			"sounds/enemies/dlc2/hexe_idle_03.wav",
			"sounds/enemies/dlc2/hexe_idle_04.wav",
			"sounds/enemies/dlc2/hexe_idle_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Other1] = [
			"sounds/enemies/dlc2/hexe_idle_06.wav",
			"sounds/enemies/dlc2/hexe_idle_07.wav",
			"sounds/enemies/dlc2/hexe_idle_08.wav",
			"sounds/enemies/dlc2/hexe_idle_09.wav",
			"sounds/enemies/dlc2/hexe_idle_05.wav",
			"sounds/enemies/dlc2/hexe_idle_10.wav",
			"sounds/enemies/dlc2/hexe_idle_11.wav",
			"sounds/enemies/dlc2/hexe_idle_12.wav",
			"sounds/enemies/dlc2/hexe_idle_13.wav",
			"sounds/enemies/dlc2/hexe_idle_14.wav",
			"sounds/enemies/dlc2/hexe_idle_15.wav",
			"sounds/enemies/dlc2/hexe_idle_16.wav",
			"sounds/enemies/dlc2/hexe_idle_17.wav",
			"sounds/enemies/dlc2/hexe_idle_18.wav",
			"sounds/enemies/dlc2/hexe_idle_19.wav",
			"sounds/enemies/dlc2/hexe_idle_20.wav",
			"sounds/enemies/dlc2/hexe_idle_21.wav",
			"sounds/enemies/dlc2/hexe_idle_22.wav",
			"sounds/enemies/dlc2/hexe_idle_23.wav",
			"sounds/enemies/dlc2/hexe_idle_24.wav",
			"sounds/enemies/dlc2/hexe_idle_25.wav",
			"sounds/enemies/dlc2/hexe_idle_26.wav",
			"sounds/enemies/dlc2/hexe_idle_27.wav",
			"sounds/enemies/dlc2/hexe_idle_28.wav",
			"sounds/enemies/dlc2/hexe_idle_29.wav",
			"sounds/enemies/dlc2/hexe_idle_30.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/dlc2/hexe_flee_01.wav",
			"sounds/enemies/dlc2/hexe_flee_02.wav",
			"sounds/enemies/dlc2/hexe_flee_03.wav",
			"sounds/enemies/dlc2/hexe_flee_04.wav",
			"sounds/enemies/dlc2/hexe_flee_05.wav",
			"sounds/enemies/dlc2/hexe_flee_06.wav",
			"sounds/enemies/dlc2/hexe_flee_07.wav",
			"sounds/enemies/dlc2/hexe_flee_08.wav"
		];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 1.5;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 5.0;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Other1] = 2.5;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/hexe_agent");
		this.m.AIAgent.setActor(this);
	}

	function playIdleSound()
	{
		local r = this.Math.rand(1, 30);

		if (r <= 5)
		{
			this.playSound(this.Const.Sound.ActorEvent.Idle, this.Const.Sound.Volume.Actor * this.Const.Sound.Volume.ActorIdle * this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] * this.m.SoundVolumeOverall * (this.Math.rand(60, 100) * 0.01) * (this.isHiddenToPlayer ? 0.33 : 1.0), this.m.SoundPitch * (this.Math.rand(85, 115) * 0.01));
		}
		else
		{
			this.playSound(this.Const.Sound.ActorEvent.Other1, this.Const.Sound.Volume.Actor * this.Const.Sound.Volume.ActorIdle * this.m.SoundVolume[this.Const.Sound.ActorEvent.Other1] * this.m.SoundVolumeOverall * (this.Math.rand(60, 100) * 0.01) * (this.isHiddenToPlayer ? 0.33 : 1.0), this.m.SoundPitch * (this.Math.rand(85, 115) * 0.01));
		}
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
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

					if (r <= 35)
					{
						loot = this.new("scripts/items/misc/witch_hair_item");
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

					if (this.Math.rand(1, 100) <= 20)
					{
						local food = this.new("scripts/items/supplies/black_marsh_stew_item");
						food.randomizeAmount();
						food.randomizeBestBefore();
						food.drop(_tile);
					}

					if (this.Math.rand(1, 100) <= 30)
					{
						local loot = this.new("scripts/items/loot/jade_broche_item");
						loot.drop(_tile);
					}

					i = ++i;
				}

				local chance = 1;

				if (this.LegendsMod.Configs().LegendMagicEnabled())
				{
					chance = 10;
				}

				if (this.Math.rand(1, 100) <= chance)
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
			}
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		this.getSprite("body").setHorizontalFlipping(flip);
	}

	function onInit()
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
		body.setBrush("sadako");
		body.varySaturation(0.1);
		body.varyColor(0.05, 0.05, 0.05);
		local offset = this.createVec(-5, 35);
		this.setSpriteOffset("body", offset);
		


		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
	}

	function onUpdateInjuryLayer()
	{
		return;
	}

});


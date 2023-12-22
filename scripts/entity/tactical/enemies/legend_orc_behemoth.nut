this.legend_orc_behemoth <- this.inherit("scripts/entity/tactical/abstract_actor", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.LegendOrcBehemoth;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.LegendOrcBehemoth.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(20, -20);
		this.m.DecapitateBloodAmount = 3.0;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.abstract_actor.create();
		this.m.Sound[::Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/orcgiant_death_01.wav",
			"sounds/enemies/orcgiant_death_02.wav",
			"sounds/enemies/orcgiant_death_03.wav",
			"sounds/enemies/orcgiant_death_04.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/orcgiant_flee_01.wav",
			"sounds/enemies/orcgiant_flee_02.wav",
			"sounds/enemies/orcgiant_flee_03.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/orcgiant_hurt_01.wav",
			"sounds/enemies/orcgiant_hurt_02.wav",
			"sounds/enemies/orcgiant_hurt_03.wav",
			"sounds/enemies/orcgiant_hurt_04.wav",
			"sounds/enemies/orcgiant_hurt_05.wav",
			"sounds/enemies/orcgiant_hurt_06.wav",
			"sounds/enemies/orcgiant_hurt_07.wav",
			"sounds/enemies/orcgiant_hurt_08.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/orcgiant_idle_01.wav",
			"sounds/enemies/orcgiant_idle_02.wav",
			"sounds/enemies/orcgiant_idle_03.wav",
			"sounds/enemies/orcgiant_idle_04.wav",
			"sounds/enemies/orcgiant_idle_05.wav",
			"sounds/enemies/orcgiant_idle_06.wav",
			"sounds/enemies/orcgiant_idle_07.wav",
			"sounds/enemies/orcgiant_idle_08.wav",
			"sounds/enemies/orcgiant_idle_09.wav",
			"sounds/enemies/orcgiant_idle_10.wav",
			"sounds/enemies/orcgiant_idle_11.wav",
			"sounds/enemies/orcgiant_idle_12.wav",
			"sounds/enemies/orcgiant_idle_13.wav",
			"sounds/enemies/orcgiant_idle_14.wav",
			"sounds/enemies/orcgiant_idle_15.wav",
			"sounds/enemies/orcgiant_idle_16.wav",
			"sounds/enemies/orcgiant_idle_17.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/orc_fatigue_01.wav",
			"sounds/enemies/orc_fatigue_02.wav",
			"sounds/enemies/orc_fatigue_03.wav"
		];
		this.m.SoundPitch = 0.6;
		this.m.SoundVolume[::Const.Sound.ActorEvent.Idle] = 1.25;
		this.m.SoundVolume[::Const.Sound.ActorEvent.DamageReceived] = 1.0;
		this.m.SoundVolume[::Const.Sound.ActorEvent.Move] = 0.75;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_orc_behemoth_agent");
		this.m.AIAgent.setActor(this);
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (_type == ::Const.Sound.ActorEvent.Move && ::Math.rand(1, 100) <= 50)
		{
			return;
		}

		this.actor.playSound(_type, _volume, _pitch);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local flip = ::Math.rand(1, 100) < 50;

		if (_tile != null)
		{
			this.m.IsCorpseFlipped = flip;
			this.spawnBloodPool(_tile, 1);
			local decal;
			local appearance = this.getItems().getAppearance();
			local sprite_body = this.getSprite("body");
			local sprite_head = this.getSprite("head");
			decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = sprite_body.Color;
			decal.Saturation = sprite_body.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);

			if (appearance.CorpseArmor != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor, ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (_fatalityType != ::Const.FatalityType.Decapitated)
			{
				if (!appearance.HideCorpseHead)
				{
					decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = sprite_head.Color;
					decal.Saturation = sprite_head.Saturation;
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}

				if (appearance.HelmetCorpse != "")
				{
					decal = _tile.spawnDetail(appearance.HelmetCorpse, ::Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}
			}
			else if (_fatalityType == ::Const.FatalityType.Decapitated)
			{
				local layers = [];

				if (!appearance.HideCorpseHead)
				{
					layers.push(sprite_head.getBrush().Name + "_dead");
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					layers.push(appearance.HelmetCorpse);
				}

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-50, 30), 180.0, "legend_orc_behemoth_head_01_dead_bloodpool");
				local idx = 0;

				if (!appearance.HideCorpseHead)
				{
					decap[idx].Color = sprite_head.Color;
					decap[idx].Saturation = sprite_head.Saturation;
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
					idx = idx;
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
					idx = idx;
				}
			}

			if (_fatalityType == ::Const.FatalityType.Disemboweled)
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor + "_guts", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
			}
			else if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor + "_arrows", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
			}
			else if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor + "_javelin", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
			}

			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone ::Const.Corpse;
			corpse.CorpseName = "An Orc Behemoth";
			corpse.Tile = _tile;
			corpse.IsResurrectable = false;
			corpse.IsConsumable = true;
			corpse.Items = this.getItems();
			corpse.IsHeadAttached = _fatalityType != ::Const.FatalityType.Decapitated;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.getItems().dropAll(_tile, _killer, flip);
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		flip = !flip;

		foreach( a in ::Const.CharacterSprites.Helmets )
		{
			if (!this.hasSprite(a))
			{
				continue;
			}

			this.getSprite(a).setHorizontalFlipping(flip);
		}
	}

	function onInit()
	{
		this.abstract_actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendOrcBehemoth);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints * 2;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "legend_orc_behemoth_body_01";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("legend_orc_behemoth_body_01");
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("legend_orc_behemoth_body_01_bloodied");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("legend_orc_behemoth_head_01");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("legend_orc_behemoth_head_01_bloodied");

		foreach( a in ::Const.CharacterSprites.Helmets )
		{
			this.addSprite(a);
		}

		local v = 15;
		local v2 = -5;

		foreach( a in ::Const.CharacterSprites.Helmets )
		{
			if (!this.hasSprite(a))
			{
				continue;
			}

			this.setSpriteOffset(a, this.createVec(v2, v));
		}

		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_orc_03_body_bloodied");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.8;
		this.setSpriteOffset("status_rooted", this.createVec(0, 5));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_taste_the_pain"));
		this.m.Skills.add(this.new("scripts/skills/actives/line_breaker"));
		this.m.Skills.add(this.new("scripts/skills/effects/captain_effect"));
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));

		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand_orc"));
		this.m.Skills.add(this.new("scripts/skills/actives/charge"));
		this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));

		//orcs are born with the large perk tree
		this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_death_dealer"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));

		//behemoths are born with the indestructible perk tree
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_survival_instinct"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mind_over_body"));
	}

	function onFinish()
	{
		this.actor.onFinish();
	}

	function pickTraits()
	{
		return [
			::Const.Perks.AgileTree.Tree,
			::Const.Perks.ViciousTree.Tree,
			::Const.Perks.DeviousTree.Tree,
			::Const.Perks.FastTree.Tree,
			::Const.Perks.SturdyTree.Tree,
			::Const.Perks.FitTree.Tree
		];
	}

	function pickNamed()
	{
		this.m.IsMinibossWeapon <- true;
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss_greenskins");
		return true;
	}

	function pickOutfit()
	{
		local item = ::Const.World.Common.pickArmor([
			[
				1,
				"greenskins/legend_orc_behemoth_armor"
			]
		]);
		this.m.Items.equip(item);
		local item = ::Const.World.Common.pickHelmet([
			[
				1,
				"greenskins/legend_orc_behemoth_helmet"
			]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});


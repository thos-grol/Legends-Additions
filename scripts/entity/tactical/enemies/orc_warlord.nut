this.orc_warlord <- this.inherit("scripts/entity/tactical/abstract_actor", {
	m = {},
	function getImageOffsetY()
	{
		return -5;
	}

	function create()
	{
		this.m.Type = this.Const.EntityType.OrcWarlord;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.OrcWarlord.XP;
		this.m.Name = this.Const.Strings.OrcWarlordNames[this.Math.rand(0, this.Const.Strings.OrcWarlordNames.len() - 1)];
		this.m.IsGeneratingKillName = false;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(20, -20);
		this.m.DecapitateBloodAmount = 3.0;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.abstract_actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/orc_death_01.wav",
			"sounds/enemies/orc_death_02.wav",
			"sounds/enemies/orc_death_03.wav",
			"sounds/enemies/orc_death_04.wav",
			"sounds/enemies/orc_death_05.wav",
			"sounds/enemies/orc_death_06.wav",
			"sounds/enemies/orc_death_07.wav",
			"sounds/enemies/orc_death_08.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/orc_flee_01.wav",
			"sounds/enemies/orc_flee_02.wav",
			"sounds/enemies/orc_flee_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/orc_hurt_01.wav",
			"sounds/enemies/orc_hurt_02.wav",
			"sounds/enemies/orc_hurt_03.wav",
			"sounds/enemies/orc_hurt_04.wav",
			"sounds/enemies/orc_hurt_05.wav",
			"sounds/enemies/orc_hurt_06.wav",
			"sounds/enemies/orc_hurt_07.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/orc_idle_01.wav",
			"sounds/enemies/orc_idle_02.wav",
			"sounds/enemies/orc_idle_03.wav",
			"sounds/enemies/orc_idle_04.wav",
			"sounds/enemies/orc_idle_05.wav",
			"sounds/enemies/orc_idle_06.wav",
			"sounds/enemies/orc_idle_07.wav",
			"sounds/enemies/orc_idle_08.wav",
			"sounds/enemies/orc_idle_09.wav",
			"sounds/enemies/orc_idle_10.wav",
			"sounds/enemies/orc_idle_11.wav",
			"sounds/enemies/orc_idle_12.wav",
			"sounds/enemies/orc_idle_13.wav",
			"sounds/enemies/orc_idle_14.wav",
			"sounds/enemies/orc_idle_15.wav",
			"sounds/enemies/orc_idle_16.wav",
			"sounds/enemies/orc_idle_17.wav",
			"sounds/enemies/orc_idle_18.wav",
			"sounds/enemies/orc_idle_19.wav",
			"sounds/enemies/orc_idle_20.wav",
			"sounds/enemies/orc_idle_21.wav",
			"sounds/enemies/orc_idle_22.wav",
			"sounds/enemies/orc_idle_23.wav",
			"sounds/enemies/orc_idle_24.wav",
			"sounds/enemies/orc_idle_25.wav",
			"sounds/enemies/orc_idle_26.wav",
			"sounds/enemies/orc_idle_27.wav",
			"sounds/enemies/orc_idle_28.wav",
			"sounds/enemies/orc_idle_29.wav",
			"sounds/enemies/orc_fatigue_01.wav",
			"sounds/enemies/orc_fatigue_02.wav",
			"sounds/enemies/orc_fatigue_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/orc_fatigue_01.wav",
			"sounds/enemies/orc_fatigue_02.wav",
			"sounds/enemies/orc_fatigue_03.wav"
		];
		this.m.SoundPitch = 0.8;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 1.25;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Move] = 0.75;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/orc_warlord_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.OrcWarlord);

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 200)
		{
			b.MeleeSkill += 5;
			b.DamageTotalMult += 0.1;
		}
		
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_orc_04_body";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("bust_orc_04_body");
		body.varyColor(0.1, 0.1, 0.1);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_orc_04_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_orc_04_head_01");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_orc_04_head_injured");

		foreach( a in this.Const.CharacterSprites.Helmets )
		{
			this.addSprite(a);
		}

		local v = 8;
		local v2 = -15;

		foreach( a in this.Const.CharacterSprites.Helmets )
		{
			if (!this.hasSprite(a))
			{
				continue;
			}

			this.setSpriteOffset(a, this.createVec(v2, v));
		}

		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_orc_04_body_bloodied");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.setSpriteOffset("arms_icon", this.createVec(-8, 0));
		this.setSpriteOffset("shield_icon", this.createVec(-5, 0));
		this.setSpriteOffset("stunned", this.createVec(0, 10));
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(0, 16));
		this.setSpriteOffset("status_stunned", this.createVec(-5, 30));
		this.setSpriteOffset("arrow", this.createVec(-5, 30));
		this.m.Skills.add(this.new("scripts/skills/actives/warcry"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));

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
	}

	function pickOutfit()
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			local item = this.Const.World.Common.pickArmor([
				[
					1,
					"greenskins/orc_warlord_armor"
				]
			]);
			this.m.Items.equip(item);
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local item = this.Const.World.Common.pickHelmet([
				[
					1,
					"greenskins/orc_warlord_helmet"
				]
			]);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}

	function pickTraits()
	{
		return [
			::Const.Perks.AgileTree.Tree,
			::Const.Perks.IndestructibleTree.Tree,
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

	///////////////////

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (_type == this.Const.Sound.ActorEvent.Move && this.Math.rand(1, 100) <= 50)
		{
			return;
		}

		this.actor.playSound(_type, _volume, _pitch);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled() && _skill != null && !_skill.isRanged())
		{
			this.updateAchievement("Beastmode", 1, 1);
		}

		local flip = this.Math.rand(1, 100) < 50;

		if (_tile != null)
		{
			this.m.IsCorpseFlipped = flip;
			this.spawnBloodPool(_tile, 1);
			local decal;
			local appearance = this.getItems().getAppearance();
			local sprite_body = this.getSprite("body");
			local sprite_head = this.getSprite("head");
			decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = sprite_body.Color;
			decal.Saturation = sprite_body.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);

			if (appearance.CorpseArmor != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				if (!appearance.HideCorpseHead)
				{
					decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = sprite_head.Color;
					decal.Saturation = sprite_head.Saturation;
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}

				if (appearance.HelmetCorpse != "")
				{
					decal = _tile.spawnDetail(appearance.HelmetCorpse, this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
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

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-50, 30), 180.0, "bust_orc_04_head_dead_bloodpool");
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

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor + "_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor + "_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
			}

			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "An Orc Warlord";
			corpse.Tile = _tile;
			corpse.IsResurrectable = false;
			corpse.IsConsumable = true;
			corpse.Items = this.getItems();
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
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

		foreach( a in this.Const.CharacterSprites.Helmets )
		{
			if (!this.hasSprite(a))
			{
				continue;
			}

			this.getSprite(a).setHorizontalFlipping(flip);
		}
	}

	

	function onFinish()
	{
		this.actor.onFinish();
	}

	

});


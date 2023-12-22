::Const.Tactical.Actor.Ghoul <- {
	XP = 5000,
	ActionPoints = 12,
	Hitpoints = 1000,
	Bravery = 10,
	Stamina = 666,
	MeleeSkill = 115,
	RangedSkill = 0,
	MeleeDefense = 50,
	RangedDefense = 50,
	Initiative = 145,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	]
};

this.la_nachzerer <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		Head = 1
	},

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Ghoul);
		b.IsImmuneToDisarm = true;
		b.IsAffectedByNight = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsImmuneToStun = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_ghoul_body_03");
		body.varySaturation(0.25);
		body.varyColor(0.06, 0.06, 0.06);
		this.m.Head = this.Math.rand(1, 3);
		local head = this.addSprite("head");
		head.setBrush("bust_ghoul_03_head_0" + this.m.Head)
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.setBrush("bust_ghoul_03_injured");
		injury.Visible = false;
		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_body_bloodied_02");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.6;
		this.setSpriteOffset("status_rooted", this.createVec(-7, 14));

		this.getFlags().add("undead");
		this.getFlags().add("la_nachzerer");
		this.getFlags().add("immunity_overwhelm");
		this.getFlags().set("bleed_aura", 10);

		////////////////////////////////////////////////////////////////////////

		//base skills

		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_escape_artist"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_indomitable"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_survival_instinct"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
        this.m.Skills.add(::new("scripts/skills/traits/boss_fearless_trait")); //doesn't run until 25% hp


		//unique skills

		this.m.Skills.add(::new("scripts/skills/perks/perk_class_gluttony_knight")); // hair armor nullifies damage for x hits.

		//will swallow bro, damaging them and healing the damage dealt. Has a chance to miss. If the swallowed bro dies,
		//will heal temp injuries, and gain 2 charges of hair armor.
		this.m.Skills.add(::new("scripts/skills/actives/nachzerer_swallow_whole"));

		//jumps to tile with corpse within 4 range. Feast on the corpse, healing temp injuries, regaining health, and gaining 2 charges of hair armor.
		this.m.Skills.add(::new("scripts/skills/actives/nachzerer_gruesome_feast"));

		this.m.Skills.add(::new("scripts/skills/actives/nachzerer_claws")); //claws that inflict bleeding
		this.m.Skills.add(::new("scripts/skills/actives/nachzerer_claws_swipe")); //claw swing that hits 3 enemies and knocks them back.
        this.m.Skills.add(::new("scripts/skills/perks/perk_killing_frenzy")); // buffs damage on kill
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_lacerate"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));

		this.m.Skills.add(::new("scripts/skills/actives/nachzerer_leap")); //leap skill when surrounded 0ap, 3 turn cd

	}

	function create()
	{
		this.m.Type = ::Const.EntityType.Ghoul;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.Ghoul.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(35, -26);
		this.m.DecapitateBloodAmount = 1.5;
		this.m.BloodPoolScale = 1.33;
		this.m.ConfidentMoraleBrush = "icon_confident_undead";
		this.actor.create();
		this.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/ghoul_hurt_01.wav",
			"sounds/enemies/ghoul_hurt_02.wav",
			"sounds/enemies/ghoul_hurt_03.wav",
			"sounds/enemies/ghoul_hurt_04.wav",
			"sounds/enemies/ghoul_hurt_05.wav",
			"sounds/enemies/ghoul_hurt_06.wav",
			"sounds/enemies/ghoul_hurt_07.wav",
			"sounds/enemies/ghoul_hurt_08.wav",
			"sounds/enemies/ghoul_hurt_09.wav",
			"sounds/enemies/ghoul_hurt_10.wav",
			"sounds/enemies/ghoul_hurt_11.wav",
			"sounds/enemies/ghoul_hurt_12.wav",
			"sounds/enemies/ghoul_hurt_13.wav",
			"sounds/enemies/ghoul_hurt_14.wav",
			"sounds/enemies/ghoul_hurt_15.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/ghoul_death_01.wav",
			"sounds/enemies/ghoul_death_02.wav",
			"sounds/enemies/ghoul_death_03.wav",
			"sounds/enemies/ghoul_death_04.wav",
			"sounds/enemies/ghoul_death_05.wav",
			"sounds/enemies/ghoul_death_06.wav",
			"sounds/enemies/ghoul_death_07.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/ghoul_flee_01.wav",
			"sounds/enemies/ghoul_flee_02.wav",
			"sounds/enemies/ghoul_flee_03.wav",
			"sounds/enemies/ghoul_flee_04.wav",
			"sounds/enemies/ghoul_flee_05.wav",
			"sounds/enemies/ghoul_flee_06.wav",
			"sounds/enemies/ghoul_flee_07.wav",
			"sounds/enemies/ghoul_flee_08.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/ghoul_idle_01.wav",
			"sounds/enemies/ghoul_idle_02.wav",
			"sounds/enemies/ghoul_idle_03.wav",
			"sounds/enemies/ghoul_idle_04.wav",
			"sounds/enemies/ghoul_idle_05.wav",
			"sounds/enemies/ghoul_idle_06.wav",
			"sounds/enemies/ghoul_idle_07.wav",
			"sounds/enemies/ghoul_idle_08.wav",
			"sounds/enemies/ghoul_idle_09.wav",
			"sounds/enemies/ghoul_idle_10.wav",
			"sounds/enemies/ghoul_idle_11.wav",
			"sounds/enemies/ghoul_idle_12.wav",
			"sounds/enemies/ghoul_idle_13.wav",
			"sounds/enemies/ghoul_idle_14.wav",
			"sounds/enemies/ghoul_idle_15.wav",
			"sounds/enemies/ghoul_idle_16.wav",
			"sounds/enemies/ghoul_idle_17.wav",
			"sounds/enemies/ghoul_idle_18.wav",
			"sounds/enemies/ghoul_idle_19.wav",
			"sounds/enemies/ghoul_idle_20.wav",
			"sounds/enemies/ghoul_idle_21.wav",
			"sounds/enemies/ghoul_idle_22.wav",
			"sounds/enemies/ghoul_idle_23.wav",
			"sounds/enemies/ghoul_idle_24.wav",
			"sounds/enemies/ghoul_idle_25.wav",
			"sounds/enemies/ghoul_idle_26.wav",
			"sounds/enemies/ghoul_idle_27.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Other1] = [
			"sounds/enemies/ghoul_grows_01.wav",
			"sounds/enemies/ghoul_grows_02.wav",
			"sounds/enemies/ghoul_grows_03.wav",
			"sounds/enemies/ghoul_grows_04.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Other2] = [
			"sounds/enemies/ghoul_death_fullbelly_01.wav",
			"sounds/enemies/ghoul_death_fullbelly_02.wav",
			"sounds/enemies/ghoul_death_fullbelly_03.wav"
		];
		this.m.SoundPitch = 0.9;
		local onArmorHitSounds = this.getItems().getAppearance().ImpactSound;
		onArmorHitSounds[::Const.BodyPart.Body] = ::Const.Sound.ArmorLeatherImpact;
		onArmorHitSounds[::Const.BodyPart.Head] = ::Const.Sound.ArmorLeatherImpact;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/la_nachzerer_agent");
		this.m.AIAgent.setActor(this);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local flip = this.Math.rand(0, 100) < 50;
		local isResurrectable = _fatalityType != ::Const.FatalityType.Decapitated;
		local sprite_body = this.getSprite("body");
		local sprite_head = this.getSprite("head");

		if (_tile != null)
		{
			local decal;
			local skin = this.getSprite("body");
			this.m.IsCorpseFlipped = flip;
			decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = skin.Color;
			decal.Saturation = skin.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);

			if (_fatalityType == ::Const.FatalityType.Decapitated)
			{
				local layers = [
					sprite_head.getBrush().Name + "_dead"
				];
				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-45, 10), 55.0, sprite_head.getBrush().Name + "_bloodpool");

				foreach( sprite in decap )
				{
					sprite.Color = skin.Color;
					sprite.Saturation = skin.Saturation;
					sprite.Scale = 0.9;
					sprite.setBrightness(0.9);
				}
			}
			else
			{
				decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = skin.Color;
				decal.Saturation = skin.Saturation;
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead_arrows", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}
			else if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead_javelin", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
			local corpse = clone ::Const.Corpse;
			corpse.CorpseName = "A " + this.getName();
			corpse.Tile = _tile;
			corpse.Value = 2.0;
			corpse.IsResurrectable = false;
			corpse.Armor = this.m.BaseProperties.Armor;
			corpse.IsHeadAttached = _fatalityType != ::Const.FatalityType.Decapitated;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function drop_loot(_tile)
	{
		if (this.World.Retinue.hasFollower("follower.surgeon") && ::Math.rand(1,100) <= 25)
		{
			local tome = this.new("scripts/items/misc/anatomist/nachzehrer_potion_item");
			tome.drop(_tile);
		}

		// for(local i = 0; i < 3; i++ )
		// {
		// 	if (::Math.rand(1,100) <= 20 )
		// 	{
		// 		local s = this.new("scripts/items/misc/magic/soul_splinter");
		// 		s.drop(_tile);
		// 	}
		// }

	}

	function onAfterDeath( _tile )
	{
        local skill = this.getSkills().getSkillByID("actives.nachzerer_swallow_whole");
		if (skill.getSwallowedEntity() != null)
		{
			local e = skill.getSwallowedEntity();
			this.Tactical.addEntityToMap(e, _tile.Coords.X, _tile.Coords.Y);
			e.getFlags().set("Devoured", false);

			if (!e.isPlayerControlled()) ::Tactical.getTemporaryRoster().remove(e);
			::Tactical.TurnSequenceBar.addEntity(e);

			local slime = e.getSprite("dirt");
			slime.setBrush("bust_slime");
			slime.Visible = true;
		}

		if (skill.getSwallowedItems() != null)
		{
			local items = skill.getSwallowedItems();
			if (items.len() != 0)
			{
				_tile.IsContainingItems = true;
				foreach(item in items)
				{
					_tile.Items.push(item);
				}
			}
		}
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = !this.isAlliedWithPlayer();
		this.getSprite("body_blood").setHorizontalFlipping(flip);
	}

});


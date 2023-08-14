::Const.Tactical.Actor.SkeletonLich = {
	XP = 750,
	ActionPoints = 12,
	Hitpoints = 240,
	Bravery = 110,
	Stamina = 100,
	MeleeSkill = 0,
	RangedSkill = 0,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 50,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::mods_hookExactClass("entity/tactical/enemies/skeleton_lich", function(o) {
	o.setStage = function( _s )
	{
		local flip = _s == 0;
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("armor").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("face").setHorizontalFlipping(flip);
		this.getSprite("injury").setHorizontalFlipping(flip);
		this.getSprite("beard").setHorizontalFlipping(flip);
		this.getSprite("hair").setHorizontalFlipping(flip);
		this.getSprite("helmet").setHorizontalFlipping(flip);
		this.getSprite("helmet_damage").setHorizontalFlipping(flip);
		this.getSprite("beard_top").setHorizontalFlipping(flip);
		this.getSprite("body_blood").setHorizontalFlipping(flip);
		this.getSprite("dirt").setHorizontalFlipping(flip);
		this.getSprite("blur_1").Visible = _s != 0;
		this.getSprite("blur_2").Visible = _s != 0;
	}

	o.loadResources = function()
	{
		this.actor.loadResources();
		local a = [];
		a.extend([
			"sounds/enemies/dlc6/skull_move_01.wav",
			"sounds/enemies/dlc6/skull_move_02.wav",
			"sounds/enemies/dlc6/skull_move_03.wav",
			"sounds/enemies/dlc6/skull_move_04.wav"
		]);
		a.extend([
			"sounds/enemies/dlc6/skull_bang_01.wav",
			"sounds/enemies/dlc6/skull_bang_02.wav",
			"sounds/enemies/dlc6/skull_bang_03.wav",
			"sounds/enemies/dlc6/skull_bang_04.wav"
		]);
		a.extend([
			"sounds/enemies/dlc6/skull_death_01.wav",
			"sounds/enemies/dlc6/skull_death_02.wav",
			"sounds/enemies/dlc6/skull_death_03.wav",
			"sounds/enemies/dlc6/skull_death_04.wav"
		]);
		a.extend([
			"sounds/enemies/geist_idle_13.wav",
			"sounds/enemies/geist_idle_14.wav",
			"sounds/enemies/geist_idle_15.wav",
			"sounds/enemies/geist_idle_16.wav",
			"sounds/enemies/geist_idle_17.wav"
		]);
		a.extend([
			"sounds/enemies/ghost_death_01.wav",
			"sounds/enemies/ghost_death_02.wav"
		]);
		a.extend([
			"sounds/enemies/ghastly_touch_01.wav"
		]);
		a.extend([
			"sounds/enemies/dlc6/wither_01.wav",
			"sounds/enemies/dlc6/wither_02.wav",
			"sounds/enemies/dlc6/wither_03.wav"
		]);

		for( local i = 0; i != a.len(); i = i )
		{
			this.Tactical.addResource(a[i]);
			i = ++i;
		}
	}

	o.onDeath = function( _killer, _skill, _tile, _fatalityType )
	{
		local entities = this.Tactical.Entities.getInstancesOfFaction(this.getFaction());
		local phylacteries = [];

		foreach( e in entities )
		{
			if (e.getType() == this.Const.EntityType.SkeletonPhylactery)
			{
				phylacteries.push(e);
			}
		}

		if (phylacteries.len() != 0)
		{
			this.getItems().unequip(this.getItems().getItemAtSlot(this.Const.ItemSlot.Body));
			this.getItems().unequip(this.getItems().getItemAtSlot(this.Const.ItemSlot.Head));
		}

		this.skeleton.onDeath(_killer, _skill, _tile, _fatalityType);

		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

			for( local i = 0; i < n; i = i )
			{
				local loot = this.new("scripts/items/misc/legend_ancient_scroll_item");
				loot.drop(_tile);
				local loot = this.new("scripts/items/misc/legend_ancient_scroll_item");
				loot.drop(_tile);
				local loot = this.new("scripts/items/misc/legend_ancient_scroll_item");
				loot.drop(_tile);
				local loot = this.new("scripts/items/misc/legend_ancient_scroll_item");
				loot.drop(_tile);
				local loot = this.new("scripts/items/misc/legend_ancient_scroll_item");
				loot.drop(_tile);
				i = ++i;
			}
		}

		if (phylacteries.len() != 0)
		{
			local players = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);
			local candidates = [];

			foreach( phy in phylacteries )
			{
				local nearest = 9000;

				foreach( player in players )
				{
					local d = player.getTile().getDistanceTo(phy.getTile());

					if (d < nearest)
					{
						nearest = d;
					}
				}

				candidates.push({
					Phylactery = phy,
					Distance = nearest
				});
			}

			candidates.sort(function ( _a, _b )
			{
				if (_a.Distance < _b.Distance)
				{
					return -1;
				}
				else if (_a.Distance > _b.Distance)
				{
					return 1;
				}

				return 0;
			});
			local p = candidates[0].Phylactery;
			local t = p.getTile();
			p.kill(null, null);
			local spawn = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/skeleton_lich", t.Coords);
			spawn.assignRandomEquipment();
			spawn.setFaction(this.getFaction());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this) + " transcends death!");
		}
		else
		{
			this.Sound.play("sounds/enemies/dlc6/lich_death_01.wav", this.Const.Sound.Volume.Actor, this.getPos());
		}
	}

	o.onInit = function()
	{
		this.actor.onInit();
		this.addSprite("socket").setBrush("bust_base_undead");
		local body = this.addSprite("body");
		body.setBrush("bust_skeleton_body_02");
		body.setHorizontalFlipping(true);
		body.Saturation = 0.8;

		if (this.Math.rand(0, 100) < 75)
		{
			body.varySaturation(0.2);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyColor(0.025, 0.025, 0.025);
		}

		this.m.BloodColor = body.Color;
		this.m.BloodSaturation = body.Saturation;
		this.addSprite("body_injury").setBrush("bust_skeleton_body_injured");
		this.addSprite("armor");
		this.addSprite("armor_layer_chain");
		this.addSprite("armor_layer_plate");
		this.addSprite("armor_layer_tabbard");
		this.addSprite("armor_layer_cloak");
		this.addSprite("armor_upgrade_back");
		local head = this.addSprite("head");
		head.setBrush("bust_skeleton_head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.setBrush("bust_skeleton_head_injured");
		local beard = this.addSprite("beard");
		local face = this.addSprite("face");
		face.setBrush("bust_skeleton_face_03");
		local hair = this.addSprite("hair");

		foreach( a in this.Const.CharacterSprites.Helmets )
		{
			this.addSprite(a);
		}

		local beard_top = this.addSprite("beard_top");
		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_body_bloodied_02");
		body_blood.setHorizontalFlipping(true);
		body_blood.Visible = false;
		local body_dirt = this.addSprite("dirt");
		body_dirt.setBrush("bust_body_dirt_02");
		body_dirt.setHorizontalFlipping(true);
		body_dirt.Visible = this.Math.rand(1, 100) <= 33;
		local book = this.addSprite("book");
		book.setBrush("icon_necronomicon");
		book.setHorizontalFlipping(true);
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SkeletonLich);
		b.TargetAttractionMult = 3.0;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToDisarm = true;
		b.DamageReceivedTotalMult *= 0.5;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.SameMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 3;
		this.m.Skills.add(this.new("scripts/skills/racial/skeleton_racial"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		local skill;
		skill = this.new("scripts/skills/actives/horror_skill");
		skill.m.MaxRange = 99;
		skill.m.ActionPointCost = 4;
		this.m.Skills.add(skill);
		skill = this.new("scripts/skills/actives/miasma_skill");
		skill.m.MaxRange = 99;
		skill.m.ActionPointCost = 4;
		this.m.Skills.add(skill);
		skill = this.new("scripts/skills/actives/lightning_storm_skill");
		skill.setCooldownAfterImpact(false);
		this.m.Skills.add(skill);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		this.m.Skills.add(this.new("scripts/skills/actives/summon_mirror_image_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/summon_flying_skulls_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/geomancy_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/geomancy_once_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/raise_all_undead_skill"));
	}

	o.onMovementStep = function( _tile, _levelDifference )
	{
		for( local i = 0; i < this.Const.Tactical.LichParticles.len(); i = i )
		{
			this.Tactical.spawnParticleEffect(false, this.Const.Tactical.LichParticles[i].Brushes, _tile, this.Const.Tactical.LichParticles[i].Delay, this.Const.Tactical.LichParticles[i].Quantity, this.Const.Tactical.LichParticles[i].LifeTimeQuantity, this.Const.Tactical.LichParticles[i].SpawnRate, this.Const.Tactical.LichParticles[i].Stages);
			i = ++i;
		}

		return this.actor.onMovementStep(_tile, _levelDifference);
	}

	o.assignRandomEquipment = function()
	{
		local armor = [
			[
				1,
				"ancient/ancient_lich_attire"
			]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);
		local helmet = [
			[
				1,
				"ancient/ancient_lich_headpiece"
			]
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}

});

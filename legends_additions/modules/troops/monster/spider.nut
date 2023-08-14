::Const.Tactical.Actor.Spider = {
	XP = 100,
	ActionPoints = 11,
	Hitpoints = 60,
	Bravery = 45,
	Stamina = 130,
	MeleeSkill = 60,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 20,
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		20,
		20
	]
};
::mods_hookExactClass("entity/tactical/enemies/spider", function(o) {
	o.onDeath = function( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			local flip = this.Math.rand(0, 100) < 50;
			local decal;
			local body_decal;
			local head_decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("body");
			local head = this.getSprite("head");
			decal = _tile.spawnDetail("bust_spider_body_01_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.9 * this.m.Size;
			body_decal = decal;

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				decal = _tile.spawnDetail("bust_spider_head_01_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = head.Color;
				decal.Saturation = head.Saturation;
				decal.Scale = 0.9 * this.m.Size;
				head_decal = decal;

				if (_fatalityType == this.Const.FatalityType.None)
				{
					local corpse_data = {
						Body = body_decal,
						Head = head_decal,
						Start = this.Time.getRealTimeF(),
						Vector = this.createVec(0.0, -1.0),
						Iterations = 0,
						function onCorpseEffect( _data )
						{
							if (this.Time.getRealTimeF() - _data.Start > 0.2)
							{
								if (++_data.Iterations > 5)
								{
									return;
								}

								_data.Vector = this.createVec(this.Math.rand(-100, 100) * 0.01, this.Math.rand(-100, 100) * 0.01);
								_data.Start = this.Time.getRealTimeF();
							}

							local f = (this.Time.getRealTimeF() - _data.Start) / 0.2;
							_data.Body.setOffset(this.createVec(0.0 + 0.5 * _data.Vector.X * f, 30.0 + 1.0 * _data.Vector.Y * f));
							_data.Head.setOffset(this.createVec(0.0 + 0.5 * _data.Vector.X * f, 30.0 + 1.0 * _data.Vector.Y * f));
							this.Time.scheduleEvent(this.TimeUnit.Real, 10, _data.onCorpseEffect, _data);
						}

					};
					this.Time.scheduleEvent(this.TimeUnit.Real, 10, corpse_data.onCorpseEffect, corpse_data);
				}
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [
					"bust_spider_head_01_dead"
				];
				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-50, -10), 0.0, "bust_spider_head_01_dead_bloodpool");
				decap[0].Color = head.Color;
				decap[0].Saturation = head.Saturation;
				decap[0].Scale = 0.9 * this.m.Size;
			}

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail("bust_spider_body_01_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9 * this.m.Size;
			}

			if (_fatalityType == this.Const.FatalityType.Disemboweled)
			{
				decal = _tile.spawnDetail("bust_spider_gut", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9 * this.m.Size;
			}
			else if (_fatalityType == this.Const.FatalityType.Smashed)
			{
				decal = _tile.spawnDetail("bust_spider_skull", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9 * this.m.Size;
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "A Webknecht";
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
			corpse.IsConsumable = false;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.m.Size > 0.75 && this.Math.rand(1, 100) <= 60)
			{
				local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

				for( local i = 0; i < n; i = i )
				{
					local r = this.Math.rand(1, 100);
					local loot;

					if (r <= 60)
					{
						loot = this.new("scripts/items/misc/spider_silk_item");
					}
					else
					{
						loot = this.new("scripts/items/misc/poison_gland_item");
					}

					loot.drop(_tile);
					i = ++i;
				}

				if (this.Math.rand(1, 100) <= 5)
				{
					local loot = this.new("scripts/items/loot/webbed_valuables_item");
					loot.drop(_tile);
				}
			}
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	o.onInit = function()
	{
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Spider);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 25)
		{
			b.DamageDirectAdd += 0.05;

			if (this.World.getTime().Days >= 50)
			{
				b.DamageDirectAdd += 0.05;
				b.MeleeDefense += 5;
				b.RangedDefense += 5;
			}
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 3;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local legs_back = this.addSprite("legs_back");
		legs_back.setBrush("bust_spider_legs_back");
		local body = this.addSprite("body");
		body.setBrush("bust_spider_body_0" + this.Math.rand(1, 4));

		if (this.Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.3);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyColor(0.1, 0.1, 0.1);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyBrightness(0.1);
		}

		local legs_front = this.addSprite("legs_front");
		legs_front.setBrush("bust_spider_legs_front");
		legs_front.Color = body.Color;
		legs_front.Saturation = body.Saturation;
		legs_back.Color = body.Color;
		legs_back.Saturation = body.Saturation;
		local head = this.addSprite("head");
		head.setBrush("bust_spider_head_01");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_spider_01_injured");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(7, 10));
		this.setSpriteOffset("status_stunned", this.createVec(0, -20));
		this.setSpriteOffset("arrow", this.createVec(0, -20));
		this.setSize(this.Math.rand(70, 90) * 0.01);
		this.m.Skills.add(this.new("scripts/skills/actives/spider_bite_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/web_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		this.m.Skills.add(this.new("scripts/skills/racial/spider_racial"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_levitation"));
			this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.setSize = function( _s )
	{
		this.m.Size = _s;
		this.m.DecapitateBloodAmount = _s * 0.75;
		this.getSprite("body").Scale = _s;
		this.getSprite("head").Scale = _s;
		this.getSprite("injury").Scale = _s;
		this.getSprite("status_rooted").Scale = _s * 0.65;
		this.getSprite("status_rooted_back").Scale = _s * 0.65;
		this.getSprite("legs_back").Scale = _s;
		this.getSprite("legs_front").Scale = _s;
		local offset = this.createVec(0, -10.0 * (1.0 - _s));
		this.setSpriteOffset("body", offset);
		this.setSpriteOffset("head", offset);
		this.setSpriteOffset("injury", offset);
		this.setSpriteOffset("status_rooted", this.createVec(7, 10 - 10.0 * (1.0 - _s)));
		this.setSpriteOffset("status_rooted_back", this.createVec(7, 10 - 10.0 * (1.0 - _s)));
		this.setSpriteOffset("legs_back", offset);
		this.setSpriteOffset("legs_front", offset);
	}

});

